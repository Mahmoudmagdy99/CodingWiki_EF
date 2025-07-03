# CodingWiki_EF 🚀  
**A learning project focused on mastering Entity Framework Core using layered architecture across multiple app types.**

## 📚 Overview

This solution demonstrates EF Core fundamentals and advanced features through a multi-project setup:
- **CodingWiki_Console** – Console app showcasing DbContext usage, seeding, and LINQ queries.  
- **CodingWiki_Web** – ASP.NET Core MVC app with CRUD UI for data exploration.  
- **CodingWiki_DataAccess** – Contains DbContext, migrations, repository patterns, fluent API & data annotations.  
- **CodingWiki_Model** – Centralized entity models shared by console and web layers.

## 🧠 Key Concepts & Features

- Code-First EF Core with **migrations** and **database seeding**
- Modeling relationships: one-to-many, many-to-many, navigation properties
- Configuration via **Data Annotations** and **Fluent API**
- Use of **LINQ** (e.g. `Include`, `Select`, `Where`, tracking vs. no-tracking)
- Clean separation using **Repository and Unit of Work** patterns
- Demonstrations in both console and web UI environments

## 🛠️ Technologies

- .NET 7 & EF Core 7
- SQL Server (or LocalDB)
- ASP.NET Core MVC
- C#
- Microsoft.EntityFrameworkCore tooling

## 🏗️ Project Structure

```plaintext
CodingWiki_EF/
├── CodingWiki_Model        # Shared POCO entity classes
├── CodingWiki_DataAccess   # DbContext, configurations, repositories, migrations
├── CodingWiki_Console      # Console demo: querying, seeding, relations
├── CodingWiki_Web          # ASP.NET Core MVC with CRUD UI
└── CodingWiki.sln
