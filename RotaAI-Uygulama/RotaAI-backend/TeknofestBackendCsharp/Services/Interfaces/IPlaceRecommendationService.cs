using TeknofestBackendCsharp.DTOs;

namespace TeknofestBackendCsharp.Services.Interfaces
{
    public interface IPlaceRecommendationService
    {
        Task<IEnumerable<PlaceRecommendationDTO>> GetRecommendationsAsync(int userId, int count = 5);
    }
} 