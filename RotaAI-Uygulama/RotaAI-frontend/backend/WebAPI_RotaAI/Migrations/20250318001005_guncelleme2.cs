using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebAPI_RotaAI.Migrations
{
    /// <inheritdoc />
    public partial class guncelleme2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Password",
                table: "users",
                newName: "password");

            migrationBuilder.RenameColumn(
                name: "NameSurname",
                table: "users",
                newName: "nameSurname");

            migrationBuilder.RenameColumn(
                name: "Mail",
                table: "users",
                newName: "mail");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "password",
                table: "users",
                newName: "Password");

            migrationBuilder.RenameColumn(
                name: "nameSurname",
                table: "users",
                newName: "NameSurname");

            migrationBuilder.RenameColumn(
                name: "mail",
                table: "users",
                newName: "Mail");
        }
    }
}
