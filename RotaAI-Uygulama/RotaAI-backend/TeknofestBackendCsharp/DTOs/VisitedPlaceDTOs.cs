using System.ComponentModel.DataAnnotations;

namespace TeknofestBackendCsharp.DTOs
{
    public class VisitedPlaceDTO
    {
        public int PlaceId { get; set; }
        public string PlaceName { get; set; }
        public string PlaceImage { get; set; }
        public int Point { get; set; }
        public string CityName { get; set; }
    }

    public class RatePlaceDTO
    {
        [Required]
        [Range(1, 5)]
        public int Point { get; set; }
    }
} 