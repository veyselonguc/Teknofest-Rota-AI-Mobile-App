namespace TeknofestBackendCsharp.DTOs
{
    public class CityDTO
    {
        public int CityId { get; set; }
        public string CityName { get; set; }
    }

    public class CityWithPlacesDTO : CityDTO
    {
        public ICollection<PlaceDTO> Places { get; set; }
    }
} 