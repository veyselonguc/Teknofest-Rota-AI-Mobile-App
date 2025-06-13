using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TeknofestBackendCsharp.Models
{
    public class Place
    {
        [Key]
        public int PlaceId { get; set; }
        
        [Required]
        public int CityId { get; set; }
        
        [Required]
        [MaxLength(200)]
        public string PlaceName { get; set; }
        
        [Required]
        [MaxLength(500)]
        public string PlaceImage { get; set; }
        
        [Required]
        public string PlaceDesc { get; set; }
        
        // Navigation properties
        [ForeignKey("CityId")]
        public virtual City City { get; set; }
        public virtual ICollection<VisitedPlace> VisitedPlaces { get; set; }
    }
} 