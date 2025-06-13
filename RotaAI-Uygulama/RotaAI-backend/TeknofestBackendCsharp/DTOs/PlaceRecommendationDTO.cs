namespace TeknofestBackendCsharp.DTOs
{
    public class PlaceRecommendationDTO
    {
        public int PlaceId { get; set; }
        public string PlaceName { get; set; }
        public string PlaceImage { get; set; }
        public string PlaceDesc { get; set; }
        public string CityName { get; set; }
        public double RecommendationScore { get; set; }
    }
} 