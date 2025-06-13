using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Data;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Models;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Services
{
    public class PlaceService : IPlaceService
    {
        private readonly ApplicationDbContext _context;

        public PlaceService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<PlaceDetailDTO> GetPlaceDetailsAsync(int placeId)
        {
            var place = await _context.Places
                .Include(p => p.City)
                .Include(p => p.VisitedPlaces)
                .FirstOrDefaultAsync(p => p.PlaceId == placeId);

            if (place == null)
            {
                throw new InvalidOperationException("Gezilecek yer bulunamadı.");
            }

            var averageRating = place.VisitedPlaces.Any() 
                ? place.VisitedPlaces.Average(vp => vp.Point) 
                : 0;

            return new PlaceDetailDTO
            {
                PlaceId = place.PlaceId,
                PlaceName = place.PlaceName,
                PlaceImage = place.PlaceImage,
                PlaceDesc = place.PlaceDesc,
                CityId = place.CityId,
                CityName = place.City.CityName,
                AverageRating = averageRating,
                TotalRatings = place.VisitedPlaces.Count
            };
        }

        public async Task<IEnumerable<PlaceDTO>> GetPlacesByCityAsync(int cityId)
        {
            return await _context.Places
                .Include(p => p.City)
                .Where(p => p.CityId == cityId)
                .Select(p => new PlaceDTO
                {
                    PlaceId = p.PlaceId,
                    PlaceName = p.PlaceName,
                    PlaceImage = p.PlaceImage,
                    PlaceDesc = p.PlaceDesc,
                    CityId = p.CityId,
                    CityName = p.City.CityName
                })
                .ToListAsync();
        }
    }
} 