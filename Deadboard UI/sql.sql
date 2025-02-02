CREATE TABLE test (
    AutoID INT IDENTITY(1,1) NOT NULL,
    Extract NVARCHAR(75) NULL,
    Rows NVARCHAR(7) NULL,
    Sum NVARCHAR(7) NULL,
    Timestamp NVARCHAR(150) NULL
PRIMARY KEY CLUSTERED
(
[AutoID] ASC
) WITH (PAD_INDEX = OFF,STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)[PRIMARY]
) ON [PRIMARY]
insert into test (Extract) Values('test')
select * from test

    CREATE TABLE test (
        AutoID INT IDENTITY(1,1) NOT NULL,
        Extract NVARCHAR(75) NULL,
        Rows int(7) NULL,
        Sum int(7) NULL,
        Timestamp NVARCHAR(150) NULL
    )

        insert into test (AutoID,Extract,Rows,Sum,Timestamp) Values(1,'testrow',2432,36743,'01.01.2024');
        insert into test (AutoID,Extract,Rows,Sum,Timestamp) Values(2,'testrow',2452,36743,'02.01.2024');
        insert into test (AutoID,Extract,Rows,Sum,Timestamp) Values(3,'testrow',3432,40743,'03.01.2024');
        insert into test (AutoID,Extract,Rows,Sum,Timestamp) Values(4,'testrow',3932,41743,'04.01.2024');
        insert into test (AutoID,Extract,Rows,Sum,Timestamp) Values(5,'testrow',20,5,'05.01.2024');
        insert into test (AutoID,Extract,Rows,Sum,Timestamp) Values(6,'testrow',4032,42743,'06.01.2024');