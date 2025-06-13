using Microsoft.EntityFrameworkCore;
using WebAPI_RotaAI.Models;

var builder = WebApplication.CreateBuilder(args);

// HTTP/2 protokolünü devre dışı bırak
builder.WebHost.ConfigureKestrel(options =>
{
    options.ConfigureEndpointDefaults(lo => lo.Protocols = Microsoft.AspNetCore.Server.Kestrel.Core.HttpProtocols.Http1);
});

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// CORS ayarlarını ekleyin
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        builder =>
        {
            builder
                .AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader();
        });
});

// Veritabanı bağlantısını ekleyin
builder.Services.AddDbContext<ApiDbContext>(option =>
    option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// CORS middleware'ini ekleyin
app.UseCors("AllowAll");

// HTTPS yönlendirmesini kaldır
// app.UseHttpsRedirection();

app.UseAuthorization();
app.MapControllers();

app.Run();