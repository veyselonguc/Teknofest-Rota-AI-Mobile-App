using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Data;
using TeknofestBackendCsharp.DTOs;
using TeknofestBackendCsharp.Models;
using TeknofestBackendCsharp.Services.Interfaces;
using System.Diagnostics;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Logging;

namespace TeknofestBackendCsharp.Services
{
    public class PlaceRecommendationService : IPlaceRecommendationService
    {
        private readonly ApplicationDbContext _context;
        private readonly IConfiguration _configuration;
        private readonly ILogger<PlaceRecommendationService> _logger;

        public PlaceRecommendationService(ApplicationDbContext context, IConfiguration configuration, ILogger<PlaceRecommendationService> logger)
        {
            _context = context;
            _configuration = configuration;
            _logger = logger;
        }

        public async Task<IEnumerable<PlaceRecommendationDTO>> GetRecommendationsAsync(int userId, int count = 5)
        {
            try
            {
                // Kullanıcının ziyaret ettiği yerleri al
                var visitedPlaces = await _context.VisitedPlaces
                    .Include(vp => vp.Place)
                        .ThenInclude(p => p.City)
                    .Where(vp => vp.UserId == userId)
                    .ToListAsync();

                if (!visitedPlaces.Any())
                {
                    _logger.LogInformation($"Kullanıcı {userId} için ziyaret edilmiş yer bulunamadı. Popüler yerler öneriliyor.");
                    return await GetPopularPlacesAsync(count);
                }

                _logger.LogInformation($"Kullanıcı {userId} için {visitedPlaces.Count} ziyaret edilmiş yer bulundu.");

                // Python script'ini çalıştır
                var recommendations = await RunRecommendationScriptAsync(visitedPlaces);

                if (recommendations == null || !recommendations.Any())
                {
                    _logger.LogWarning($"Kullanıcı {userId} için öneri bulunamadı. Popüler yerler öneriliyor.");
                    return await GetPopularPlacesAsync(count);
                }

                _logger.LogInformation($"Python script'inden gelen öneriler: {JsonSerializer.Serialize(recommendations)}");

                // Önerilen yerleri veritabanından al
                var recommendedPlaceIds = recommendations.Select(r => r.PlaceId).ToList();
                _logger.LogInformation($"Önerilen yer ID'leri: {string.Join(", ", recommendedPlaceIds)}");

                var recommendedPlaces = await _context.Places
                    .Include(p => p.City)
                    .Where(p => recommendedPlaceIds.Contains(p.PlaceId))
                    .ToListAsync();

                _logger.LogInformation($"Veritabanından bulunan yerler: {recommendedPlaces.Count}");

                var result = recommendedPlaces.Select(p => new PlaceRecommendationDTO
                {
                    PlaceId = p.PlaceId,
                    PlaceName = p.PlaceName,
                    PlaceImage = p.PlaceImage,
                    PlaceDesc = p.PlaceDesc,
                    CityName = p.City.CityName,
                    RecommendationScore = recommendations.First(r => r.PlaceId == p.PlaceId).RecommendationScore
                }).ToList();

                _logger.LogInformation($"Kullanıcı {userId} için {result.Count} öneri bulundu.");
                return result.Take(count);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Kullanıcı {userId} için öneri oluşturulurken hata oluştu.");
                return await GetPopularPlacesAsync(count);
            }
        }

        private async Task<IEnumerable<PlaceRecommendationDTO>> GetPopularPlacesAsync(int count)
        {
            return await _context.Places
                .Include(p => p.City)
                .OrderByDescending(p => p.VisitedPlaces.Count)
                .Take(count)
                .Select(p => new PlaceRecommendationDTO
                {
                    PlaceId = p.PlaceId,
                    PlaceName = p.PlaceName,
                    PlaceImage = p.PlaceImage,
                    PlaceDesc = p.PlaceDesc,
                    CityName = p.City.CityName,
                    RecommendationScore = 0.0
                })
                .ToListAsync();
        }

        private async Task<List<PlaceRecommendationDTO>> RunRecommendationScriptAsync(List<VisitedPlace> visitedPlaces)
        {
            try
            {
                _logger.LogInformation("Python script'i çalıştırılıyor...");

                // Ziyaret edilen yerleri basitleştirilmiş formatta hazırla
                var simplifiedVisitedPlaces = visitedPlaces.Select(vp => new
                {
                    PlaceId = vp.PlaceId,
                    PlaceName = vp.Place.PlaceName,
                    PlaceDesc = vp.Place.PlaceDesc,
                    CityName = vp.Place.City.CityName,
                    Point = vp.Point
                }).ToList();

                _logger.LogInformation($"Ziyaret edilen yerler: {JsonSerializer.Serialize(simplifiedVisitedPlaces)}");

                var visitedPlacesJson = JsonSerializer.Serialize(simplifiedVisitedPlaces);
                var base64VisitedPlaces = Convert.ToBase64String(Encoding.UTF8.GetBytes(visitedPlacesJson));
                
                // ODBC bağlantı dizesini oluştur
                var connectionString = "DRIVER={ODBC Driver 17 for SQL Server};" +
                                    "SERVER=(localdb)\\mssqllocaldb;" +
                                    "DATABASE=TravelPlacesDb;" +
                                    "Trusted_Connection=yes;";

                _logger.LogInformation($"Bağlantı dizesi: {connectionString}");

                var startInfo = new ProcessStartInfo
                {
                    FileName = "python",
                    Arguments = $"\"{Path.Combine(Directory.GetCurrentDirectory(), "PythonScripts", "museum_recommendation.py")}\" \"{base64VisitedPlaces}\" \"{connectionString}\"",
                    RedirectStandardOutput = true,
                    RedirectStandardError = true,
                    UseShellExecute = false,
                    CreateNoWindow = true
                };

                using var process = new Process { StartInfo = startInfo };
                process.Start();

                var output = await process.StandardOutput.ReadToEndAsync();
                var error = await process.StandardError.ReadToEndAsync();

                await process.WaitForExitAsync();

                _logger.LogInformation($"Python script çıktısı: {output}");
                _logger.LogInformation($"Python script hata çıktısı: {error}");

                if (process.ExitCode != 0)
                {
                    _logger.LogError($"Python script hata kodu ile sonlandı: {process.ExitCode}");
                    return null;
                }

                if (string.IsNullOrWhiteSpace(output))
                {
                    _logger.LogWarning("Python script'ten boş çıktı alındı");
                    return null;
                }

                try
                {
                    var recommendations = JsonSerializer.Deserialize<List<PlaceRecommendationDTO>>(output);
                    _logger.LogInformation($"Öneriler başarıyla alındı. Öneri sayısı: {recommendations?.Count ?? 0}");
                    return recommendations;
                }
                catch (JsonException ex)
                {
                    _logger.LogError($"JSON ayrıştırma hatası: {ex.Message}");
                    _logger.LogError($"Ayrıştırılamayan JSON: {output}");
                    return null;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError($"Python script çalıştırma hatası: {ex.Message}");
                _logger.LogError($"Hata detayı: {ex}");
                return null;
            }
        }
    }
} 