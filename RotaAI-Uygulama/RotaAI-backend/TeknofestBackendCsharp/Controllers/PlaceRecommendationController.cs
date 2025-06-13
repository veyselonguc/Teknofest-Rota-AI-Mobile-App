using Microsoft.AspNetCore.Mvc;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PlaceRecommendationController : ControllerBase
    {
        private readonly IPlaceRecommendationService _recommendationService;

        public PlaceRecommendationController(IPlaceRecommendationService recommendationService)
        {
            _recommendationService = recommendationService;
        }

        [HttpGet("user/{userId}")]
        public async Task<ActionResult<IEnumerable<PlaceRecommendationDTO>>> GetRecommendations(int userId, [FromQuery] int count = 5)
        {
            try
            {
                var recommendations = await _recommendationService.GetRecommendationsAsync(userId, count);
                return Ok(recommendations);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
} 