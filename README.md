# VendasCRUDDelphi
Projeto CRUD com Delphi 11 + SQL Server 😁😁

![ProjetoDelphi](https://github.com/felipe-era/VendasCRUDDelphi/assets/22670639/ddbacecd-7728-4842-ad05-16a63d5adbbb)


** Tables Scripts
```
USE [BDVENDAS]
GO

/****** Object:  Table [dbo].[Clientes]    Script Date: 25/07/2023 20:07:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Clientes](
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Telefone] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---------------------------------------------
USE [BDVENDAS]
GO

/****** Object:  Table [dbo].[Produtos]    Script Date: 25/07/2023 20:08:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Produtos](
	[ProdutoID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](100) NULL,
	[Preco] [decimal](10, 2) NULL,
	[Estoque] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProdutoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

----------------------------------------------
USE [BDVENDAS]
GO

/****** Object:  Table [dbo].[Vendas]    Script Date: 25/07/2023 20:08:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Vendas](
	[VendaID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NULL,
	[DataVenda] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[VendaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Vendas]  WITH CHECK ADD FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Clientes] ([ClienteID])
GO

-----------------------
USE [BDVENDAS]
GO

/****** Object:  Table [dbo].[Itens_Venda]    Script Date: 25/07/2023 20:08:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Itens_Venda](
	[IDVenda] [int] IDENTITY(1,1) NOT NULL,
	[VendaID] [int] NULL,
	[ProdutoID] [int] NULL,
	[Quantidade] [int] NULL,
	[ValorTotal] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDVenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Itens_Venda]  WITH CHECK ADD FOREIGN KEY([ProdutoID])
REFERENCES [dbo].[Produtos] ([ProdutoID])
GO

ALTER TABLE [dbo].[Itens_Venda]  WITH CHECK ADD FOREIGN KEY([VendaID])
REFERENCES [dbo].[Vendas] ([VendaID])
GO
```
