# 📘 CodingWiki_EF

A structured learning project built to explore and demonstrate the capabilities of **Entity Framework Core** using a multi-project architecture. It includes both a Console App and an ASP.NET Core MVC App sharing a centralized data access layer.

## 🧠 What You'll Learn

- Code-First Migrations
- Entity Relationships:
  - One-to-One
  - One-to-Many
  - Many-to-Many
- Data Annotations vs. Fluent API
- Seeding data into the database
- LINQ Queries with `Include`, `Select`, `Where`
- Repository and Unit of Work Patterns
- DbContext tracking vs. no-tracking
- Clean project architecture

## 🏗️ Solution Structure

```plaintext
CodingWiki_EF/
├── CodingWiki_Model          # Entity models (POCO classes)
├── CodingWiki_DataAccess     # DbContext, configurations, migrations, UoW
├── CodingWiki_Console        # Console app for testing EF features
├── CodingWiki_Web            # ASP.NET Core MVC app for CRUD UI
└── CodingWiki.sln            # Solution file

## 🛠 Technologies Used

- [.NET 7](https://dotnet.microsoft.com/en-us/download/dotnet/7.0)
- [Entity Framework Core 7](https://learn.microsoft.com/en-us/ef/core/)
- [ASP.NET Core MVC](https://learn.microsoft.com/en-us/aspnet/core/mvc/overview)
- [SQL Server / LocalDB](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/sql-server-express-localdb)
- C#
- LINQ

