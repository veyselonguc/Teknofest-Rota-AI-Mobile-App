using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Models;
using BC = BCrypt.Net.BCrypt;

namespace TeknofestBackendCsharp.Data
{
    public static class SeedData
    {
        public static async Task Initialize(IServiceProvider serviceProvider)
        {
            using var context = new ApplicationDbContext(
                serviceProvider.GetRequiredService<DbContextOptions<ApplicationDbContext>>());

            // Veritabanı boş ise örnek verileri ekle
            if (!context.Cities.Any())
            {
                // Şehirleri ekle
                var istanbul = new City { CityName = "İstanbul" };
                var ankara = new City { CityName = "Ankara" };
                var izmir = new City { CityName = "İzmir" };

                context.Cities.AddRange(istanbul, ankara, izmir);
                await context.SaveChangesAsync();

                // Gezilecek yerleri ekle
                var places = new List<Place>
                {
                    new Place
                    {
                        CityId = istanbul.CityId,
                        PlaceName = "Ayasofya",
                        PlaceImage = "https://example.com/ayasofya.jpg",
                        PlaceDesc = "Bizans İmparatorluğu'nun en önemli kilisesi, Osmanlı İmparatorluğu'nun en önemli camisi."
                    },
                    new Place
                    {
                        CityId = istanbul.CityId,
                        PlaceName = "Topkapı Sarayı",
                        PlaceImage = "https://example.com/topkapi.jpg",
                        PlaceDesc = "Osmanlı İmparatorluğu'nun 400 yıl boyunca yönetim merkezi olan saray."
                    },
                    new Place
                    {
                        CityId = ankara.CityId,
                        PlaceName = "Anıtkabir",
                        PlaceImage = "https://example.com/anitkabir.jpg",
                        PlaceDesc = "Türkiye Cumhuriyeti'nin kurucusu Mustafa Kemal Atatürk'ün anıt mezarı."
                    },
                    new Place
                    {
                        CityId = izmir.CityId,
                        PlaceName = "Saat Kulesi",
                        PlaceImage = "https://example.com/saatkulesi.jpg",
                        PlaceDesc = "İzmir'in simgesi haline gelmiş tarihi saat kulesi."
                    }
                };

                context.Places.AddRange(places);
                await context.SaveChangesAsync();

                // Örnek kullanıcı ekle
                var user = new User
                {
                    UserName = "test_user",
                    Email = "test@example.com",
                    Password = BC.HashPassword("Test123!")
                };

                context.Users.Add(user);
                await context.SaveChangesAsync();

                // Örnek ziyaret ve puanlama ekle
                var visitedPlaces = new List<VisitedPlace>
                {
                    new VisitedPlace
                    {
                        UserId = user.UserId,
                        PlaceId = places[0].PlaceId,
                        Point = 5
                    },
                    new VisitedPlace
                    {
                        UserId = user.UserId,
                        PlaceId = places[1].PlaceId,
                        Point = 4
                    }
                };

                context.VisitedPlaces.AddRange(visitedPlaces);
                await context.SaveChangesAsync();
            }
        }
    }
} 