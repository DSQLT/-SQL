



CREATE VIEW [@@].[Types]
AS
SELECT 
V.type_id,
V.type_name,
V.type_pattern,
V.type_default,
V.type_comparison,
V.type_to_char,
V.type_to_value
FROM
(
    VALUES
        (34, 'image', '%t', 'null', '%v', 'cast(%v as varchar(max))'										,NULL),
        (35, 'text', '%t', '''''', '%v', 'cast(%v as varchar(max))'										,NULL),
        (36, 'uniqueidentifier', '%t', 'newid()', '%v', 'cast(%v as varchar(max))'						,NULL),
        (40, 'date', '%t', '''''', '%v', 'cast(%v as varchar(max))'										,NULL),
        (41, 'time', '%t(%s)', '''''', '%v', 'cast(%v as varchar(max))'									,NULL),
        (42, 'datetime2', '%t', '''''', '%v', 'CONVERT(varchar(max),%v,126)'								,NULL),
        (43, 'datetimeoffset', '%t', '''''', '%v', 'CONVERT(varchar(max),%v,126)'							,NULL),
        (48, 'tinyint', '%t', '0', '%v', 'cast(%v as varchar(max))'										,'%v'),
        (52, 'smallint', '%t', '0', '%v', 'cast(%v as varchar(max))'										,'%v'),
        (56, 'int', '%t', '0', '%v', 'cast(%v as varchar(max))'											,'%v'),
        (58, 'smalldatetime', '%t', '''''', 'CONVERT(varchar(8),%v,112)', 'CONVERT(varchar(max),%v,126)'	,NULL),
        (59, 'real', '%t', '0', 'round(%v,5)', 'cast(%v as varchar(max))'									,'%v'),
        (60, 'money', '%t', '0', 'round(%v,2)', 'cast(%v as varchar(max))'								,'%v'),
        (61, 'datetime', '%t', '''''', 'CONVERT(varchar(8),%v,112)', 'CONVERT(varchar(max),%v,126)'		,NULL),
        (62, 'float', '%t', '0', 'round(%v,5)', 'cast(%v as varchar(max))'								,'%v'),
        (98, 'sql_variant', '%t', '0', '%v', 'cast(%v as varchar(max))'									,NULL),
        (99, 'ntext', '%t', '''''', '%v', 'cast(%v as varchar(max))'										,NULL),
        (104, 'bit', '%t', '0', '%v', 'cast(%v as varchar(max))'											,'%v'),
        (106, 'decimal', '%t(%p,%s)', '0', 'round(%v,%s)', 'cast(%v as varchar(max))'						,'%v'),
        (108, 'numeric', '%t(%p,%s)', '0', 'round(%v,%s)', 'cast(%v as varchar(max))'						,'%v'),
        (122, 'smallmoney', '%t', '0', 'round(%v,2)', 'cast(%v as varchar(max))'							,'%v'),
        (127, 'bigint', '%t', '0', '%v', 'cast(%v as varchar(max))'										,'%v'),
        (128, 'hierarchyid', '%t', '''''', '%v', 'cast(%v as varchar(max))'								,NULL),
        (129, 'geometry', '%t', '''''', '%v', 'cast(%v as varchar(max))'									,NULL),
        (130, 'geography', '%t', '''''', '%v', 'cast(%v as varchar(max))'									,NULL),
        (165, 'varbinary', '%t(%l)', 'null', '%v', 'cast(%v as varchar(max))'								,NULL),
        (167, 'varchar', '%t(%l)', '''''', 'cast(%v as %t(%l))', '%v'										,'[@@].[QuoteSQ](%v)'),
        (173, 'binary', '%t(%l)', 'null', '%v', 'cast(%v as varchar(max))'								,NULL),
        (175, 'char', '%t(%l)', '''''', 'cast(%v as %t(%l))', '%v'										,'[@@].[QuoteSQ](%v)'),
        (189, 'timestamp', '%t', '''''', '%v', 'cast(%v as varchar(max))'									,NULL),
        (231, 'nvarchar', '%t(%h)', '''''', 'cast(%v as %t(%h))', '%v'									,'[@@].[QuoteSQ](%v)'),
        (239, 'nchar', '%t(%h)', '''''', 'cast(%v as %t(%h))', '%v'										,'[@@].[QuoteSQ](%v)'),
        (241, 'xml', '%t', 'null', 'cast(%v as varchar(max))', 'cast(%v as varchar(max))'					,'[@@].[QuoteSQ](%v)'),
        (256, 'sysname', '%t', '''''', '%v', '%v'															,'[@@].[QuoteSQ](%v)')
) AS V ([type_id], [type_name], [type_pattern], [type_default], [type_comparison], [type_to_char], [type_to_value]);
GO

