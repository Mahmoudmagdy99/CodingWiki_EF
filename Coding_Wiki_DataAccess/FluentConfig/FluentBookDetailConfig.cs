using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CodingWiki_Model.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Coding_Wiki_DataAccess.FluentConfig
{
    public class FluentBookDetailConfig : IEntityTypeConfiguration<Fluent_BookDetail>
    {
        public void Configure(EntityTypeBuilder<Fluent_BookDetail> modelBuilder)
        {
            modelBuilder.ToTable("Fluent_BookDetails");
            modelBuilder.Property(u => u.NumberOfChapters).HasColumnName("NoOfChapters");
            modelBuilder.Property(u => u.NumberOfChapters).IsRequired();
            modelBuilder.HasKey(u => u.BookDetail_Id);
            modelBuilder.HasOne(b => b.Book).WithOne(b => b.BookDetail).HasForeignKey<Fluent_BookDetail>(u => u.Book_Id);
        }
    }
}
