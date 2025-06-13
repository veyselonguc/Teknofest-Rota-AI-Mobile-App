using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Data;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Models;
using TeknofestBackendCsharp.Services.Interfaces;
using BC = BCrypt.Net.BCrypt;

namespace TeknofestBackendCsharp.Services
{
    public class UserService : IUserService
    {
        private readonly ApplicationDbContext _context;

        public UserService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<UserResponseDTO> RegisterAsync(RegisterDTO registerDTO)
        {
            if (await _context.Users.AnyAsync(u => u.Email == registerDTO.Email))
            {
                throw new InvalidOperationException("Bu e-posta adresi zaten kayıtlı.");
            }

            var user = new User
            {
                UserName = registerDTO.UserName,
                Email = registerDTO.Email,
                Password = BC.HashPassword(registerDTO.Password)
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return new UserResponseDTO
            {
                UserId = user.UserId,
                UserName = user.UserName,
                Email = user.Email
            };
        }

        public async Task<string> LoginAsync(LoginDTO loginDTO)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == loginDTO.Email);
            if (user == null || !BC.Verify(loginDTO.Password, user.Password))
            {
                throw new InvalidOperationException("Geçersiz e-posta veya şifre.");
            }

            // TODO: JWT token oluşturma işlemi eklenecek
            return "Token will be implemented";
        }

        public async Task<UserResponseDTO> GetUserByIdAsync(int userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                throw new InvalidOperationException("Kullanıcı bulunamadı.");
            }

            return new UserResponseDTO
            {
                UserId = user.UserId,
                UserName = user.UserName,
                Email = user.Email
            };
        }

        public async Task<IEnumerable<UserResponseDTO>> GetAllUsersAsync()
        {
            return await _context.Users
                .Select(u => new UserResponseDTO
                {
                    UserId = u.UserId,
                    UserName = u.UserName,
                    Email = u.Email
                })
                .ToListAsync();
        }
    }
} 