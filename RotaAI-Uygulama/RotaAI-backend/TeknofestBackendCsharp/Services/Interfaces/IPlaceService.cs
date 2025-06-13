using TeknofestBackendCsharp.DTOs;

namespace TeknofestBackendCsharp.Services.Interfaces
{
    public interface IPlaceService
    {
        Task<PlaceDetailDTO> GetPlaceDetailsAsync(int placeId);
        Task<IEnumerable<PlaceDTO>> GetPlacesByCityAsync(int cityId);
    }
} 