using Microsoft.AspNetCore.Mvc;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VisitedPlaceController : ControllerBase
    {
        private readonly IVisitedPlaceService _visitedPlaceService;

        public VisitedPlaceController(IVisitedPlaceService visitedPlaceService)
        {
            _visitedPlaceService = visitedPlaceService;
        }

        [HttpGet("user/{userId}")]
        public async Task<ActionResult<IEnumerable<VisitedPlaceDTO>>> GetUserVisitedPlaces(int userId)
        {
            var visitedPlaces = await _visitedPlaceService.GetUserVisitedPlacesAsync(userId);
            return Ok(visitedPlaces);
        }

        [HttpPost("user/{userId}/place/{placeId}/visit")]
        public async Task<ActionResult<VisitedPlaceDTO>> AddVisitedPlace(int userId, int placeId)
        {
            try
            {
                var result = await _visitedPlaceService.AddVisitedPlaceAsync(userId, placeId);
                return Ok(result);
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("user/{userId}/place/{placeId}/rate")]
        public async Task<ActionResult<VisitedPlaceDTO>> RatePlace(int userId, int placeId, RatePlaceDTO ratePlaceDTO)
        {
            try
            {
                var result = await _visitedPlaceService.RatePlaceAsync(userId, placeId, ratePlaceDTO);
                return Ok(result);
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
} 