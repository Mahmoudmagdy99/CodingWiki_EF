// See https://aka.ms/new-console-template for more information
using Coding_Wiki_DataAccess.Data;
using CodingWiki_Model.Models;
using Microsoft.EntityFrameworkCore;

Console.WriteLine("Hello, World!");

//using(ApplicationDbContext context = new ApplicationDbContext())
//{
//    context.Database.EnsureCreated();
//    if(context.Database.GetPendingMigrations().Count() > 0)
//    {
//        context.Database.Migrate();
//    }
//}

//AddBooks();
//GetAllBooks();
//GetBook();

//void AddBooks()
//{
//    Book book = new Book { Title = "New EF Core Book", ISBN = "1231231212", Price = 10.93m, Publisher_Id = 1 };
//    using var context = new ApplicationDbContext();
//    context.Books.Add(book);
//    context.SaveChanges();
//}

//void GetAllBooks()
//{
//    using var context = new ApplicationDbContext();
//    var books = context.Books.ToList();
//    foreach (var book in books)
//    {
//        Console.WriteLine($"Title: {book.Title}, ISBN: {book.ISBN}");
//    }
//}

//void GetBook()
//{
//    try
//    {
//        using var context = new ApplicationDbContext();
//        var book = context.Books.Find(6);
//        Console.WriteLine(book.Title + " - " + book.ISBN);
//    }
//    catch (Exception ex)
//    {
//    }
//}