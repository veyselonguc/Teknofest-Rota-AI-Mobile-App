using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Data;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Models;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Services
{
    public class CityService : ICityService
    {
        private readonly ApplicationDbContext _context;

        public CityService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CityDTO>> GetAllCitiesAsync()
        {
            return await _context.Cities
                .Select(c => new CityDTO
                {
                    CityId = c.CityId,
                    CityName = c.CityName
                })
                .ToListAsync();
        }

        public async Task<CityWithPlacesDTO> GetCityWithPlacesAsync(int cityId)
        {
            var city = await _context.Cities
                .Include(c => c.Places)
                .FirstOrDefaultAsync(c => c.CityId == cityId);

            if (city == null)
            {
                throw new InvalidOperationException("Şehir bulunamadı.");
            }

            return new CityWithPlacesDTO
            {
                CityId = city.CityId,
                CityName = city.CityName,
                Places = city.Places.Select(p => new PlaceDTO
                {
                    PlaceId = p.PlaceId,
                    PlaceName = p.PlaceName,
                    PlaceImage = p.PlaceImage,
                    PlaceDesc = p.PlaceDesc,
                    CityId = p.CityId,
                    CityName = city.CityName
                }).ToList()
            };
        }
    }
} 