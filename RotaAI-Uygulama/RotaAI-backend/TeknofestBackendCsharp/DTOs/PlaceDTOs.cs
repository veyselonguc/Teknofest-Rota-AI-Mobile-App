namespace TeknofestBackendCsharp.DTOs
{
    public class PlaceDTO
    {
        public int PlaceId { get; set; }
        public string PlaceName { get; set; }
        public string PlaceImage { get; set; }
        public string PlaceDesc { get; set; }
        public int CityId { get; set; }
        public string CityName { get; set; }
    }

    public class PlaceDetailDTO : PlaceDTO
    {
        public double AverageRating { get; set; }
        public int TotalRatings { get; set; }
    }
} 