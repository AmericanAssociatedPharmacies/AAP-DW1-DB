USE [SSISDB]
GO
/****** Object:  Table [internal].[data_type_mapping]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[data_type_mapping](
	[mapping_id] [bigint] IDENTITY(1,1) NOT NULL,
	[ssis_data_type] [nvarchar](128) NOT NULL,
	[sql_data_type] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Data_Type_Mapping] PRIMARY KEY CLUSTERED 
(
	[mapping_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Unique_data_type_mapping] UNIQUE NONCLUSTERED 
(
	[ssis_data_type] ASC,
	[sql_data_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
