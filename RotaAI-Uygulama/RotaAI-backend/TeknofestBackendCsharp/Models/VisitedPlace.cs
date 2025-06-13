using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TeknofestBackendCsharp.Models
{
    public class VisitedPlace
    {
        [Key]
        [Column(Order = 0)]
        public int UserId { get; set; }
        
        [Key]
        [Column(Order = 1)]
        public int PlaceId { get; set; }
        
        [Required]
        [Range(1, 5)]
        public int Point { get; set; }
        
        // Navigation properties
        [ForeignKey("UserId")]
        public virtual User User { get; set; }
        
        [ForeignKey("PlaceId")]
        public virtual Place Place { get; set; }
    }
} 