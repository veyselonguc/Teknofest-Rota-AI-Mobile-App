using Microsoft.EntityFrameworkCore;
using TeknofestBackendCsharp.Models;

namespace TeknofestBackendCsharp.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<City> Cities { get; set; }
        public DbSet<Place> Places { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<VisitedPlace> VisitedPlaces { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<VisitedPlace>()
                .HasKey(vp => new { vp.UserId, vp.PlaceId });
        }
    }
} 