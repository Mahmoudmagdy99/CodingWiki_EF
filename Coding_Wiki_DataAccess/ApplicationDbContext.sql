IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627165347_AddBookToDb'
)
BEGIN
    CREATE TABLE [Books] (
        [BookId] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NOT NULL,
        [ISBN] nvarchar(max) NOT NULL,
        [Price] float NOT NULL,
        CONSTRAINT [PK_Books] PRIMARY KEY ([BookId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627165347_AddBookToDb'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250627165347_AddBookToDb', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627172128_changePriceColumnToDecimalInBooksTable'
)
BEGIN
    DECLARE @var sysname;
    SELECT @var = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'Price');
    IF @var IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT [' + @var + '];');
    ALTER TABLE [Books] ALTER COLUMN [Price] decimal(10,5) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627172128_changePriceColumnToDecimalInBooksTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250627172128_changePriceColumnToDecimalInBooksTable', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627180927_AddGenresToDb'
)
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'Title');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Books] ALTER COLUMN [Title] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627180927_AddGenresToDb'
)
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'ISBN');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [Books] ALTER COLUMN [ISBN] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627180927_AddGenresToDb'
)
BEGIN
    CREATE TABLE [Genres] (
        [GenreId] int NOT NULL IDENTITY,
        [GenreName] nvarchar(max) NULL,
        [Display] int NOT NULL,
        CONSTRAINT [PK_Genres] PRIMARY KEY ([GenreId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250627180927_AddGenresToDb'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250627180927_AddGenresToDb', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628112913_renameDisplayColumninGenreTable'
)
BEGIN
    EXEC sp_rename N'[Genres].[Display]', N'DisplayOrder', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628112913_renameDisplayColumninGenreTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628112913_renameDisplayColumninGenreTable', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628121450_seedBookTable'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BookId', N'ISBN', N'Price', N'Title') AND [object_id] = OBJECT_ID(N'[Books]'))
        SET IDENTITY_INSERT [Books] ON;
    EXEC(N'INSERT INTO [Books] ([BookId], [ISBN], [Price], [Title])
    VALUES (1, N''123B12'', 10.99, N''Spider without Duty''),
    (2, N''12123B12'', 11.99, N''Fortune of time''),
    (3, N''77652'', 20.99, N''Fake Sunday''),
    (4, N''CC12B12'', 25.99, N''Cookie Jar''),
    (5, N''90392B33'', 40.99, N''Cloudy Forest'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'BookId', N'ISBN', N'Price', N'Title') AND [object_id] = OBJECT_ID(N'[Books]'))
        SET IDENTITY_INSERT [Books] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628121450_seedBookTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628121450_seedBookTable', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124235_updateGenreTableAndColumnName'
)
BEGIN
    ALTER TABLE [Genres] DROP CONSTRAINT [PK_Genres];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124235_updateGenreTableAndColumnName'
)
BEGIN
    EXEC sp_rename N'[Genres]', N'tb_genres', 'OBJECT';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124235_updateGenreTableAndColumnName'
)
BEGIN
    EXEC sp_rename N'[tb_genres].[GenreName]', N'Name', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124235_updateGenreTableAndColumnName'
)
BEGIN
    ALTER TABLE [tb_genres] ADD CONSTRAINT [PK_tb_genres] PRIMARY KEY ([GenreId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124235_updateGenreTableAndColumnName'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628124235_updateGenreTableAndColumnName', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124835_changePrimaryKeyAndRequiredinGenre'
)
BEGIN
    EXEC sp_rename N'[tb_genres].[GenreId]', N'Genre_Id', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124835_changePrimaryKeyAndRequiredinGenre'
)
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[tb_genres]') AND [c].[name] = N'Name');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [tb_genres] DROP CONSTRAINT [' + @var3 + '];');
    EXEC(N'UPDATE [tb_genres] SET [Name] = N'''' WHERE [Name] IS NULL');
    ALTER TABLE [tb_genres] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
    ALTER TABLE [tb_genres] ADD DEFAULT N'' FOR [Name];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628124835_changePrimaryKeyAndRequiredinGenre'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628124835_changePrimaryKeyAndRequiredinGenre', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628125236_renameGenreToCategory'
)
BEGIN
    DROP TABLE [tb_genres];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628125236_renameGenreToCategory'
)
BEGIN
    CREATE TABLE [Categories] (
        [CategoryId] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([CategoryId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628125236_renameGenreToCategory'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628125236_renameGenreToCategory', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628125655_maxLengthAndNotMappedInBooksTable'
)
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Books]') AND [c].[name] = N'ISBN');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Books] DROP CONSTRAINT [' + @var4 + '];');
    EXEC(N'UPDATE [Books] SET [ISBN] = N'''' WHERE [ISBN] IS NULL');
    ALTER TABLE [Books] ALTER COLUMN [ISBN] nvarchar(20) NOT NULL;
    ALTER TABLE [Books] ADD DEFAULT N'' FOR [ISBN];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628125655_maxLengthAndNotMappedInBooksTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628125655_maxLengthAndNotMappedInBooksTable', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628141225_addAuthorPublisherAndSubCategory'
)
BEGIN
    CREATE TABLE [Authors] (
        [Author_Id] int NOT NULL IDENTITY,
        [FirstName] nvarchar(50) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [BirthDate] datetime2 NOT NULL,
        [Location] nvarchar(max) NULL,
        CONSTRAINT [PK_Authors] PRIMARY KEY ([Author_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628141225_addAuthorPublisherAndSubCategory'
)
BEGIN
    CREATE TABLE [Publishers] (
        [Publisher_Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Location] nvarchar(max) NULL,
        CONSTRAINT [PK_Publishers] PRIMARY KEY ([Publisher_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628141225_addAuthorPublisherAndSubCategory'
)
BEGIN
    CREATE TABLE [SubCategories] (
        [SubCategoryId] int NOT NULL IDENTITY,
        [Name] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_SubCategories] PRIMARY KEY ([SubCategoryId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250628141225_addAuthorPublisherAndSubCategory'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250628141225_addAuthorPublisherAndSubCategory', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629154153_addBookDetailsToDb'
)
BEGIN
    CREATE TABLE [BookDetails] (
        [BookDetail_Id] int NOT NULL IDENTITY,
        [NumberOfChapters] int NOT NULL,
        [NumberOfPages] int NOT NULL,
        [Weigth] nvarchar(max) NULL,
        CONSTRAINT [PK_BookDetails] PRIMARY KEY ([BookDetail_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629154153_addBookDetailsToDb'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250629154153_addBookDetailsToDb', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629160247_addOneToOneRelation_Book_BookDetail'
)
BEGIN
    ALTER TABLE [BookDetails] ADD [Book_Id] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629160247_addOneToOneRelation_Book_BookDetail'
)
BEGIN
    CREATE UNIQUE INDEX [IX_BookDetails_Book_Id] ON [BookDetails] ([Book_Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629160247_addOneToOneRelation_Book_BookDetail'
)
BEGIN
    ALTER TABLE [BookDetails] ADD CONSTRAINT [FK_BookDetails_Books_Book_Id] FOREIGN KEY ([Book_Id]) REFERENCES [Books] ([BookId]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629160247_addOneToOneRelation_Book_BookDetail'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250629160247_addOneToOneRelation_Book_BookDetail', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    ALTER TABLE [Books] ADD [Publisher_Id] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [Publisher_Id] = 1
    WHERE [BookId] = 1;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [Publisher_Id] = 1
    WHERE [BookId] = 2;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [Publisher_Id] = 2
    WHERE [BookId] = 3;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [Publisher_Id] = 3
    WHERE [BookId] = 4;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    EXEC(N'UPDATE [Books] SET [Publisher_Id] = 3
    WHERE [BookId] = 5;
    SELECT @@ROWCOUNT');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Publisher_Id', N'Location', N'Name') AND [object_id] = OBJECT_ID(N'[Publishers]'))
        SET IDENTITY_INSERT [Publishers] ON;
    EXEC(N'INSERT INTO [Publishers] ([Publisher_Id], [Location], [Name])
    VALUES (1, N''Chicago'', N''Pub 1 Jimmy''),
    (2, N''New York'', N''Pub 2 John''),
    (3, N''Hawaii'', N''Pub 3 Ben'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Publisher_Id', N'Location', N'Name') AND [object_id] = OBJECT_ID(N'[Publishers]'))
        SET IDENTITY_INSERT [Publishers] OFF;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    CREATE INDEX [IX_Books_Publisher_Id] ON [Books] ([Publisher_Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    ALTER TABLE [Books] ADD CONSTRAINT [FK_Books_Publishers_Publisher_Id] FOREIGN KEY ([Publisher_Id]) REFERENCES [Publishers] ([Publisher_Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629162949_addOneToManyRelation_Book_Publisher'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250629162949_addOneToManyRelation_Book_Publisher', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629164437_addManyToManyRelation_SkipMappingTable'
)
BEGIN
    CREATE TABLE [AuthorBook] (
        [AuthorsAuthor_Id] int NOT NULL,
        [BooksBookId] int NOT NULL,
        CONSTRAINT [PK_AuthorBook] PRIMARY KEY ([AuthorsAuthor_Id], [BooksBookId]),
        CONSTRAINT [FK_AuthorBook_Authors_AuthorsAuthor_Id] FOREIGN KEY ([AuthorsAuthor_Id]) REFERENCES [Authors] ([Author_Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AuthorBook_Books_BooksBookId] FOREIGN KEY ([BooksBookId]) REFERENCES [Books] ([BookId]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629164437_addManyToManyRelation_SkipMappingTable'
)
BEGIN
    CREATE INDEX [IX_AuthorBook_BooksBookId] ON [AuthorBook] ([BooksBookId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629164437_addManyToManyRelation_SkipMappingTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250629164437_addManyToManyRelation_SkipMappingTable', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629165755_addManualMappingTable_ManytoMany_Book_Author'
)
BEGIN
    DROP TABLE [AuthorBook];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629165755_addManualMappingTable_ManytoMany_Book_Author'
)
BEGIN
    CREATE TABLE [BookAuthorMap] (
        [Book_Id] int NOT NULL,
        [Author_Id] int NOT NULL,
        CONSTRAINT [PK_BookAuthorMap] PRIMARY KEY ([Author_Id], [Book_Id]),
        CONSTRAINT [FK_BookAuthorMap_Authors_Author_Id] FOREIGN KEY ([Author_Id]) REFERENCES [Authors] ([Author_Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_BookAuthorMap_Books_Book_Id] FOREIGN KEY ([Book_Id]) REFERENCES [Books] ([BookId]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629165755_addManualMappingTable_ManytoMany_Book_Author'
)
BEGIN
    CREATE INDEX [IX_BookAuthorMap_Book_Id] ON [BookAuthorMap] ([Book_Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629165755_addManualMappingTable_ManytoMany_Book_Author'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250629165755_addManualMappingTable_ManytoMany_Book_Author', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629235945_addFluent_BookDetailToDb'
)
BEGIN
    CREATE TABLE [Fluent_BookDetails] (
        [BookDetail_Id] int NOT NULL IDENTITY,
        [NoOfChapters] int NOT NULL,
        [NumberOfPages] int NOT NULL,
        [Weigth] nvarchar(max) NULL,
        CONSTRAINT [PK_Fluent_BookDetails] PRIMARY KEY ([BookDetail_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250629235945_addFluent_BookDetailToDb'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250629235945_addFluent_BookDetailToDb', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630001103_addFluent_BookToDb'
)
BEGIN
    CREATE TABLE [Fluent_Books] (
        [BookId] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NULL,
        [ISBN] nvarchar(50) NOT NULL,
        [Price] decimal(18,2) NOT NULL,
        CONSTRAINT [PK_Fluent_Books] PRIMARY KEY ([BookId])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630001103_addFluent_BookToDb'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250630001103_addFluent_BookToDb', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630002202_addFluent_AuthorAndPublisherToDb'
)
BEGIN
    CREATE TABLE [Fluent_Authors] (
        [Author_Id] int NOT NULL IDENTITY,
        [FirstName] nvarchar(50) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [BirthDate] datetime2 NOT NULL,
        [Location] nvarchar(max) NULL,
        CONSTRAINT [PK_Fluent_Authors] PRIMARY KEY ([Author_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630002202_addFluent_AuthorAndPublisherToDb'
)
BEGIN
    CREATE TABLE [Fluent_Publishers] (
        [Publisher_Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Location] nvarchar(max) NULL,
        CONSTRAINT [PK_Fluent_Publishers] PRIMARY KEY ([Publisher_Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630002202_addFluent_AuthorAndPublisherToDb'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250630002202_addFluent_AuthorAndPublisherToDb', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630004647_addFluent_OneToOneRelation_Book_BookDetail'
)
BEGIN
    ALTER TABLE [Fluent_BookDetails] ADD [Book_Id] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630004647_addFluent_OneToOneRelation_Book_BookDetail'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Fluent_BookDetails_Book_Id] ON [Fluent_BookDetails] ([Book_Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630004647_addFluent_OneToOneRelation_Book_BookDetail'
)
BEGIN
    ALTER TABLE [Fluent_BookDetails] ADD CONSTRAINT [FK_Fluent_BookDetails_Fluent_Books_Book_Id] FOREIGN KEY ([Book_Id]) REFERENCES [Fluent_Books] ([BookId]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630004647_addFluent_OneToOneRelation_Book_BookDetail'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250630004647_addFluent_OneToOneRelation_Book_BookDetail', N'9.0.6');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630005819_addFluent_OneManyRelation_Book_Publisher'
)
BEGIN
    ALTER TABLE [Fluent_Books] ADD [Publisher_Id] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630005819_addFluent_OneManyRelation_Book_Publisher'
)
BEGIN
    CREATE INDEX [IX_Fluent_Books_Publisher_Id] ON [Fluent_Books] ([Publisher_Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630005819_addFluent_OneManyRelation_Book_Publisher'
)
BEGIN
    ALTER TABLE [Fluent_Books] ADD CONSTRAINT [FK_Fluent_Books_Fluent_Publishers_Publisher_Id] FOREIGN KEY ([Publisher_Id]) REFERENCES [Fluent_Publishers] ([Publisher_Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250630005819_addFluent_OneManyRelation_Book_Publisher'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250630005819_addFluent_OneManyRelation_Book_Publisher', N'9.0.6');
END;

COMMIT;
GO