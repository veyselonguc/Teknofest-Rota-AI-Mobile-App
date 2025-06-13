using System.ComponentModel.DataAnnotations;

namespace WebAPI_RotaAI.Models
{
    public class Users
    {
        [Key]
        public int userId {get; set;}
        [Required]
        public String nameSurname { get; set; } = "";
        [Required]
        public String mail { get; set; } = "";
        [Required]
        public String password { get; set; } = "";
    }
}
