USE [SalesDDS]
GO
/****** Object:  Table [dbo].[DateDim]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateDim](
	[DateKey] [int] NOT NULL,
	[TheDate] [date] NOT NULL,
	[DayOfMonth] [tinyint] NOT NULL,
	[DaySuffix] [char](2) NOT NULL,
	[DayOfWeek] [tinyint] NOT NULL,
	[DayName] [varchar](10) NOT NULL,
	[IsWeekend] [bit] NOT NULL,
	[IsHoliday] [bit] NOT NULL,
	[HolidayText] [varchar](64) NULL,
	[DOWInMonth] [tinyint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[WeekOfMonth] [tinyint] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[ISOWeekOfYear] [tinyint] NOT NULL,
	[MonthOfYear] [tinyint] NOT NULL,
	[MonthName] [varchar](10) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[Year] [int] NOT NULL,
	[MMYYYY] [char](6) NOT NULL,
	[MonthYear] [char](7) NOT NULL,
	[FirstDayOfMonth] [date] NOT NULL,
	[LastDayOfMonth] [date] NOT NULL,
	[FirstDayOfQuarter] [date] NOT NULL,
	[LastDayOfQuarter] [date] NOT NULL,
	[FirstDayOfYear] [date] NOT NULL,
	[LastDayOfYear] [date] NOT NULL,
	[FirstDayOfNextMonth] [date] NOT NULL,
	[FirstDayOfNextYear] [date] NOT NULL,
	[IsWeekDay] [bit] NOT NULL,
	[IsAAPHoliday] [bit] NOT NULL,
	[IsAPIHoliday] [bit] NOT NULL,
	[IsAPIShipDate] [bit] NOT NULL,
	[IsUPSShipDate] [bit] NOT NULL,
	[IsFedExShipDate] [bit] NOT NULL,
	[DayOfQuarter] [int] NOT NULL,
	[CCYYMM] [int] NULL,
 CONSTRAINT [CPK_DateDim] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((0)) FOR [IsWeekDay]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((0)) FOR [IsAAPHoliday]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((0)) FOR [IsAPIHoliday]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((1)) FOR [IsAPIShipDate]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((1)) FOR [IsUPSShipDate]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((1)) FOR [IsFedExShipDate]
GO
ALTER TABLE [dbo].[DateDim] ADD  DEFAULT ((0)) FOR [DayOfQuarter]
GO
