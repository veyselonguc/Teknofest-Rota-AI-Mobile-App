using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace WebAPI_RotaAI.Migrations
{
    /// <inheritdoc />
    public partial class guncelleme : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "name",
                table: "users",
                newName: "Password");

            migrationBuilder.RenameColumn(
                name: "address",
                table: "users",
                newName: "NameSurname");

            migrationBuilder.AddColumn<string>(
                name: "Mail",
                table: "users",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Mail",
                table: "users");

            migrationBuilder.RenameColumn(
                name: "Password",
                table: "users",
                newName: "name");

            migrationBuilder.RenameColumn(
                name: "NameSurname",
                table: "users",
                newName: "address");
        }
    }
}
