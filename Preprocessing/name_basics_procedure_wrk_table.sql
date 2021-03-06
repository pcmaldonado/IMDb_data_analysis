USE [imdb_202201]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_name_basics_202201]    Script Date: 20/01/2022 15:55:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[BLD_WRK_name_basics_202201] --BUILDING A WORK TABLE
-- =============================================
-- Author:		Paula Maldonado
-- Create date: 2022-01-17
-- Description:	Raw => Work
-- MOD DATE:
-- =============================================
AS
BEGIN

-- =============================================
-- DROP TABLE BLOCK
-- =============================================
IF OBJECT_ID('name_basics_202201') IS NOT NULL
DROP TABLE [name_basics_202201]

-- =============================================
-- CREATE TABLE BLOCK
-- =============================================

CREATE TABLE [name_basics_202201]
	([RowNumber] INT IDENTITY(1,1)
      ,[nconst] VARCHAR(10) NOT NULL
      ,[primaryName] NVARCHAR(100) NOT NULL
      ,[birthYear] INT
      ,[deathYear] INT
      ,[primaryProfession] VARCHAR(100)
      ,[knownForTitles] VARCHAR(100)
	  
	  CONSTRAINT [nconst] PRIMARY KEY ([nconst])) 

-- =============================================
-- TRUNCATE TABLE
-- =============================================
TRUNCATE TABLE [name_basics_202201]

-- =============================================
-- INSERT INTO BLOCK
-- =============================================
INSERT INTO [name_basics_202201]
(		[nconst]
      ,[primaryName]
      ,[birthYear]
      ,[deathYear]
      ,[primaryProfession]
      ,[knownForTitles]
	   )

SELECT 
      [nconst]
      ,CASE WHEN LEN([primaryName]) > 100 THEN SUBSTRING([primaryName], 1, 100) ELSE [primaryName] END     
      ,CASE WHEN [birthYear] = '\N' THEN -1 ELSE [birthYear] END
      ,CASE WHEN [deathYear] = '\N' THEN -1 ELSE [deathYear] END
      ,[primaryProfession]
      ,[knownForTitles]   
FROM [RAW_name_basics_202201]

END
