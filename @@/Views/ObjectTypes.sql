



CREATE     VIEW [@@].[ObjectTypes]
AS
SELECT
  [V].[Object_Type] COLLATE Latin1_General_CI_AS_KS_WS AS [Object_Type]
, CAST(TRIM([V].[Object_Type_Description]) AS VARCHAR(60)) AS [Object_Type_Description]
, [V].[Super_Type]
, [V].[Type_Name]
FROM
(
  VALUES ('AF', 'Aggregate function (CLR)               ', 'F','')
  ,      ('C' , 'CHECK constraint                       ', 'C','')
  ,      ('D' , 'DEFAULT (constraint or stand-alone)    ', 'C','')
  ,      ('F' , 'FOREIGN KEY constraint                 ', 'C','')
  ,      ('FN', 'SQL scalar function                    ', 'F','FUNCTION')
  ,      ('FS', 'Assembly (CLR) scalar-function         ', 'F','')
  ,      ('FT', 'Assembly (CLR) table-valued function   ', 'F','')
  ,      ('IF', 'SQL inline table-valued function       ', 'F','FUNCTION')
  ,      ('IT', 'Internal table                         ', 'T','')
  ,      ('P' , 'SQL Stored Procedure                   ', 'P','PROCEDURE')
  ,      ('PC', 'Assembly (CLR) stored-procedure        ', 'P','')
  ,      ('PG', 'Plan guide                             ', 'I','')
  ,      ('PK', 'PRIMARY KEY constraint                 ', 'C','')
  ,      ('R' , 'Rule (old-style, stand-alone)          ', 'C','')
  ,      ('RF', 'Replication-filter-procedure           ', 'P','')
  ,      ('S' , 'System base table                      ', 'T','')
  ,      ('SN', 'Synonym                                ', 'S','SYNONYM')
  ,      ('SO', 'Sequence object                        ', 'I','')
  ,      ('U' , 'Table (user-defined)                   ', 'T','')
  ,      ('V' , 'View                                   ', 'V','VIEW')
  ,      ('EC', 'Edge constraint                        ', 'C','')
  ,      ('SQ', 'Service queue                          ', 'Q','')
  ,      ('TA', 'Assembly (CLR) DML trigger             ', 'P','')
  ,      ('TF', 'SQL table-valued-function              ', 'F','FUNCTION')
  ,      ('TR', 'SQL DML trigger                        ', 'P','')
  ,      ('TT', 'Table type                             ', 'T','TYPE')
  ,      ('UQ', 'UNIQUE constraint                      ', 'C','')
  ,      ('X' , 'Extended stored procedure              ', 'P','')
  ,      ('ST', 'STATS_TREE                             ', 'I','')
  ,      ('ET', 'External Table                         ', 'T','')
  ,      ('TY', 'Type                                   ', 'Y','TYPE')
) AS [V] ([Object_Type], [Object_Type_Description], [Super_Type],[Type_Name]);
GO

