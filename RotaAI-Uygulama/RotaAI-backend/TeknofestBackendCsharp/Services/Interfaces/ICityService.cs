using TeknofestBackendCsharp.DTOs;

namespace TeknofestBackendCsharp.Services.Interfaces
{
    public interface ICityService
    {
        Task<IEnumerable<CityDTO>> GetAllCitiesAsync();
        Task<CityWithPlacesDTO> GetCityWithPlacesAsync(int cityId);
    }
} 