using Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Persistencia.Data.Configuration;

public class RolConfiguration : IEntityTypeConfiguration<Rol>
{
    public void Configure(EntityTypeBuilder<Rol> builder)
    {
        builder.ToTable("rol");
        builder.Property(p => p.Id)
                .IsRequired();
                
        builder.Property(p => p.Nombre)
                .IsRequired()
                .HasMaxLength(100);

        builder.Property(p => p.DescripcionRol)
                .IsRequired()
                .HasMaxLength(100);
    }
}