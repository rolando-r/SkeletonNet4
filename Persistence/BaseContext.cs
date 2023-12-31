using System.Reflection;
using Domain;
using Microsoft.EntityFrameworkCore;
namespace Persistence
{
    public class BaseContext : DbContext
    {
        public BaseContext(DbContextOptions<BaseContext> options) : base(options)
        {
        }
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Rol> Roles { get; set; }
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
        }
    }
}

        