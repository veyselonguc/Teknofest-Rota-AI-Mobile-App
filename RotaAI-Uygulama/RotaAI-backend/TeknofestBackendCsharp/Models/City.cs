using System.ComponentModel.DataAnnotations;

namespace TeknofestBackendCsharp.Models
{
    public class City
    {
        [Key]
        public int CityId { get; set; }
        
        [Required]
        [MaxLength(100)]
        public string CityName { get; set; }
        
        // Navigation property
        public virtual ICollection<Place> Places { get; set; }
    }
} 