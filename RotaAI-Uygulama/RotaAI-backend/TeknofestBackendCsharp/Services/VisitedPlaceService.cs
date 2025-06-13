using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Data;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Models;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Services
{
    public class VisitedPlaceService : IVisitedPlaceService
    {
        private readonly ApplicationDbContext _context;

        public VisitedPlaceService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<VisitedPlaceDTO>> GetUserVisitedPlacesAsync(int userId)
        {
            return await _context.VisitedPlaces
                .Include(vp => vp.Place)
                    .ThenInclude(p => p.City)
                .Where(vp => vp.UserId == userId)
                .Select(vp => new VisitedPlaceDTO
                {
                    PlaceId = vp.PlaceId,
                    PlaceName = vp.Place.PlaceName,
                    PlaceImage = vp.Place.PlaceImage,
                    Point = vp.Point,
                    CityName = vp.Place.City.CityName
                })
                .ToListAsync();
        }

        public async Task<VisitedPlaceDTO> AddVisitedPlaceAsync(int userId, int placeId)
        {
            // Kullanıcı ve yer kontrolü
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                throw new InvalidOperationException("Kullanıcı bulunamadı.");
            }

            var place = await _context.Places
                .Include(p => p.City)
                .FirstOrDefaultAsync(p => p.PlaceId == placeId);
            if (place == null)
            {
                throw new InvalidOperationException("Gezilecek yer bulunamadı.");
            }

            // Yer zaten ziyaret edilmiş mi kontrolü
            var existingVisit = await _context.VisitedPlaces
                .FirstOrDefaultAsync(vp => vp.UserId == userId && vp.PlaceId == placeId);

            if (existingVisit != null)
            {
                throw new InvalidOperationException("Bu yer zaten ziyaret edilmiş.");
            }

            // Yeni ziyaret kaydı oluştur
            var visitedPlace = new VisitedPlace
            {
                UserId = userId,
                PlaceId = placeId,
                Point = 0 // Başlangıçta puan 0 olarak ayarlanır
            };

            _context.VisitedPlaces.Add(visitedPlace);
            await _context.SaveChangesAsync();

            return new VisitedPlaceDTO
            {
                PlaceId = visitedPlace.PlaceId,
                PlaceName = place.PlaceName,
                PlaceImage = place.PlaceImage,
                Point = visitedPlace.Point,
                CityName = place.City.CityName
            };
        }

        public async Task<VisitedPlaceDTO> RatePlaceAsync(int userId, int placeId, RatePlaceDTO ratePlaceDTO)
        {
            var visitedPlace = await _context.VisitedPlaces
                .Include(vp => vp.Place)
                    .ThenInclude(p => p.City)
                .FirstOrDefaultAsync(vp => vp.UserId == userId && vp.PlaceId == placeId);

            if (visitedPlace == null)
            {
                throw new InvalidOperationException("Bu yer henüz ziyaret edilmemiş.");
            }

            visitedPlace.Point = ratePlaceDTO.Point;
            await _context.SaveChangesAsync();

            return new VisitedPlaceDTO
            {
                PlaceId = visitedPlace.PlaceId,
                PlaceName = visitedPlace.Place.PlaceName,
                PlaceImage = visitedPlace.Place.PlaceImage,
                Point = visitedPlace.Point,
                CityName = visitedPlace.Place.City.CityName
            };
        }
    }
} 