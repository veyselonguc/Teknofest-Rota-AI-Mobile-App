using Microsoft.AspNetCore.Mvc;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PlaceController : ControllerBase
    {
        private readonly IPlaceService _placeService;

        public PlaceController(IPlaceService placeService)
        {
            _placeService = placeService;
        }

        [HttpGet("{placeId}")]
        public async Task<ActionResult<PlaceDetailDTO>> GetPlaceDetails(int placeId)
        {
            try
            {
                var place = await _placeService.GetPlaceDetailsAsync(placeId);
                return Ok(place);
            }
            catch (InvalidOperationException ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("city/{cityId}")]
        public async Task<ActionResult<IEnumerable<PlaceDTO>>> GetPlacesByCity(int cityId)
        {
            var places = await _placeService.GetPlacesByCityAsync(cityId);
            return Ok(places);
        }
    }
} 