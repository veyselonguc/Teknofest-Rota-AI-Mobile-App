using System.ComponentModel.DataAnnotations;

namespace TeknofestBackendCsharp.Models
{
    public class User
    {
        [Key]
        public int UserId { get; set; }
        
        [Required]
        [MaxLength(50)]
        public string UserName { get; set; }
        
        [Required]
        [EmailAddress]
        [MaxLength(100)]
        public string Email { get; set; }
        
        [Required]
        public string Password { get; set; }
        
        // Navigation property
        public virtual ICollection<VisitedPlace> VisitedPlaces { get; set; }
    }
} 