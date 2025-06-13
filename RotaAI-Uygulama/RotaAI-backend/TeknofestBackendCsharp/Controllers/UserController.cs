using Microsoft.AspNetCore.Mvc;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Services.Interfaces;

namespace TeknofestBackendCsharp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<UserResponseDTO>>> GetAllUsers()
        {
            var users = await _userService.GetAllUsersAsync();
            return Ok(users);
        }

        [HttpPost("register")]
        public async Task<ActionResult<UserResponseDTO>> Register(RegisterDTO registerDTO)
        {
            try
            {
                var result = await _userService.RegisterAsync(registerDTO);
                return Ok(result);
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("login")]
        public async Task<ActionResult<string>> Login(LoginDTO loginDTO)
        {
            try
            {
                var token = await _userService.LoginAsync(loginDTO);
                return Ok(new { token });
            }
            catch (InvalidOperationException ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("{userId}")]
        public async Task<ActionResult<UserResponseDTO>> GetUser(int userId)
        {
            try
            {
                var user = await _userService.GetUserByIdAsync(userId);
                return Ok(user);
            }
            catch (InvalidOperationException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
} 