using Microsoft.AspNetCore.Mvc;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CityController : ControllerBase
    {
        private readonly ICityService _cityService;

        public CityController(ICityService cityService)
        {
            _cityService = cityService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CityDTO>>> GetCities()
        {
            var cities = await _cityService.GetAllCitiesAsync();
            return Ok(cities);
        }

        [HttpGet("{cityId}/places")]
        public async Task<ActionResult<CityWithPlacesDTO>> GetCityWithPlaces(int cityId)
        {
            try
            {
                var city = await _cityService.GetCityWithPlacesAsync(cityId);
                return Ok(city);
            }
            catch (InvalidOperationException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
} 