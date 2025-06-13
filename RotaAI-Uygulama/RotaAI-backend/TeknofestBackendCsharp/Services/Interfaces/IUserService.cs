using TeknofestBackendCsharp.DTOs;

namespace TeknofestBackendCsharp.Services.Interfaces
{
    public interface IUserService
    {
        Task<UserResponseDTO> RegisterAsync(RegisterDTO registerDTO);
        Task<string> LoginAsync(LoginDTO loginDTO);
        Task<UserResponseDTO> GetUserByIdAsync(int userId);
        Task<IEnumerable<UserResponseDTO>> GetAllUsersAsync();
    }
} 