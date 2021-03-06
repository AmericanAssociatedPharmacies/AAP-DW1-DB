USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_RecreateFK]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SalesFact_RecreateFK]


AS


SET NOCOUNT ON;

BEGIN


ALTER TABLE [dbo].[SalesFact]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_APIEventKey] FOREIGN KEY([APIEventKey])
REFERENCES [dbo].[EventDimAPI] ([EventKey]);

ALTER TABLE [dbo].[SalesFact]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAHEventKey] FOREIGN KEY([CAHEventKey])
REFERENCES [dbo].[EventDimCAH] ([EventKey]);

ALTER TABLE [dbo].[SalesFact]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_DateKey] FOREIGN KEY([DateKey])
REFERENCES [dbo].[DateDim] ([DateKey]);

ALTER TABLE [dbo].[SalesFact]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_DrugKey] FOREIGN KEY([DrugKey])
REFERENCES [dbo].[DrugDim] ([DrugKey]);

ALTER TABLE [dbo].[SalesFact]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_PharmacyKey] FOREIGN KEY([PharmacyKey])
REFERENCES [dbo].[PharmacyDim] ([PharmacyKey]);


END

GO
