USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[SecData] Script Date: 12/21/2020 8:09:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SecData] (
    [SecDataID]          UNIQUEIDENTIFIER NOT NULL,
    [PolicyID]           UNIQUEIDENTIFIER NOT NULL,
    [AuthType]           INT              NOT NULL,
    [XmlDescription]     NTEXT            NOT NULL,
    [NtSecDescPrimary]   IMAGE            NOT NULL,
    [NtSecDescSecondary] NTEXT            NULL,
    [NtSecDescState]     INT              NOT NULL
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[SecData]', @OptionName = N'text in row', @OptionValue = N'256';


GO
CREATE UNIQUE CLUSTERED INDEX [IX_SecData]
    ON [dbo].[SecData]([PolicyID] ASC, [AuthType] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SecData_NtSecDescState]
    ON [dbo].[SecData]([NtSecDescState] ASC);


GO
ALTER TABLE [dbo].[SecData]
    ADD CONSTRAINT [PK_SecData] PRIMARY KEY NONCLUSTERED ([SecDataID] ASC);


GO
ALTER TABLE [dbo].[SecData]
    ADD CONSTRAINT [FK_SecDataPolicyID] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policies] ([PolicyID]) ON DELETE CASCADE;


GO
ALTER TABLE [dbo].[SecData]
    ADD CONSTRAINT [DF_SecData_NtSecDescState] DEFAULT ((0)) FOR [NtSecDescState];


