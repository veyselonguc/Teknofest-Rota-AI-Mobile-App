using TeknofestBackendCsharp.DTOs;

namespace TeknofestBackendCsharp.Services.Interfaces
{
    public interface IVisitedPlaceService
    {
        Task<IEnumerable<VisitedPlaceDTO>> GetUserVisitedPlacesAsync(int userId);
        Task<VisitedPlaceDTO> RatePlaceAsync(int userId, int placeId, RatePlaceDTO ratePlaceDTO);
        Task<VisitedPlaceDTO> AddVisitedPlaceAsync(int userId, int placeId);
    }
} 