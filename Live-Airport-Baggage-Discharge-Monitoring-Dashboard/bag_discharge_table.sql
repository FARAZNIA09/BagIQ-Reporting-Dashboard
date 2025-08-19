USE [Internship]
GO

/****** Object:  Table [dbo].[bag_discharge]    Script Date: 19-08-2025 10:51:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bag_discharge](
	[Time_Stamp] [datetime] NULL,
	[Flight_Name] [varchar](50) NULL,
	[Discharge_Name] [varchar](50) NULL,
	[Discharge_Reason] [varchar](50) NULL,
	[SDD] [date] NULL,
	[Bags] [int] NULL
) ON [PRIMARY]
GO

