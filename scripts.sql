
CREATE DATABASE myFirstDatabaseSqlServer;

/* Use the newly created database */
IF NOT EXISTS (
	SELECT *
	FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[accounts]') 
	AND type IN (N'U')
)
BEGIN
	CREATE TABLE accounts(
		id INT IDENTITY(1,1) PRIMARY KEY,
		customer_id INT NOT NULL,
		balance DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (balance >= 0),
		created_at DATETIME NOT NULL DEFAULT GETDATE(),
	);
END;

/* Select all records from the 'accounts' table if it exists */
IF EXISTS (
	SELECT 1 FROM sys.objects /* O 1 serve para verificar se existe pelo menos uma linha */
	WHERE object_id = OBJECT_ID(N'[dbo].[accounts]')
	AND type IN (N'U')
)
BEGIN
	SELECT * FROM dbo.accounts;
END;


/* Insert a new account with a balance of 1000000.0 for customer_id 1 if the 'accounts' table exists */
IF EXISTS(
	SELECT 1 FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[dbo].[accounts]')
	AND type IN(N'U')
)
BEGIN
	INSERT INTO dbo.accounts (customer_id, balance)
	VALUES(1, 1000000.0);
END;


/* Add  a new column 'updated_at' to the 'accounts' table if the 'name' column exists */
IF EXISTS(
	SELECT 1 
	FROM sys.columns
	WHERE name = 'name'
	AND object_id = OBJECT_ID('dbo.accounts')
)
BEGIN
	ALTER TABLE dbo.accounts
	ADD updated_at VARCHAR(100) NULL;
END;

/* Drop the 'name' column from the 'accounts' table if it exists */
IF EXISTS(
	SELECT 1 
	FROM sys.columns
	WHERE name = 'customer_name'
	AND object_id = OBJECT_ID('dbo.accounts')
)
BEGIN
	ALTER TABLE dbo.accounts
	DROP COLUMN customer_name;
END;
