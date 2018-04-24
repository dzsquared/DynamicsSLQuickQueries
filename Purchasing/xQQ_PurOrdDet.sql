USE [FloApp]
GO

/****** Object:  View [dbo].[xQQ_PurOrdDet]    Script Date: 8/21/2017 10:15:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[xQQ_PurOrdDet]
AS
SELECT        D.CpnyID AS [Company ID], D.PONbr AS [PO Number], CONVERT(date, P.PODate) AS [PO Date], 
                         CASE P.Status WHEN 'M' THEN 'M - Completed' WHEN 'O' THEN 'O - Open Order' WHEN 'P' THEN 'P - Purchase Order' WHEN 'Q' THEN 'Q - Quote Order' WHEN 'X' THEN 'X - Canceled' ELSE P.Status END AS [PO Status],
                          P.PerEnt AS [Period Entered], P.PerClosed AS [Period Closed], 
                         CASE D .POType WHEN 'OR' THEN 'OR - Regular Order' WHEN 'DP' THEN 'DP - Drop Ship' WHEN 'BL' THEN 'BL - Blanket Order' WHEN 'ST' THEN 'ST - Standard Order' ELSE D .POType END AS [PO Type], 
                         P.VendID AS [Vendor ID], P.VendName AS [Vendor Name], D.LineRef AS [Line Reference Number], 
                         CASE D .PurchaseType WHEN 'DL' THEN 'DL - Description Line' WHEN 'FR' THEN 'FR - Freight Charges' WHEN 'GI' THEN 'GI - Goods for Inventory' WHEN 'GN' THEN 'GN - Non-Inventory Goods' WHEN 'GP' THEN
                          'GP - Goods for Project' WHEN 'GS' THEN 'GS - Goods for Sales Order' WHEN 'MI' THEN 'MI - Misc Charges' WHEN 'PI' THEN 'PI - Goods for Project Inventory' WHEN 'PS' THEN 'PS - Goods for Project Sales Order'
                          WHEN 'SE' THEN 'SE - Services for Expense' WHEN 'SP' THEN 'SP - Services for Project' ELSE D .PurchaseType END AS [Purchase For], 
                         CASE D .OpenLine WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE CONVERT(varchar, D .OpenLine) END AS [Open PO Line], D.InvtID AS [Inventory ID], I.Descr AS [Inventory ID Description], 
                         D.TranDesc AS [Transaction Description], D.SiteID AS [Site ID], S.Name AS [Site Name], I.ClassID AS [Inventory Product Class ID], dbo.ProductClass.Descr AS [Inventory Product Class Description], 
                         D.PurchUnit AS [Purchase UOM], D.QtyOrd AS [Quantity Ordered], D.UnitCost AS [Unit Cost], D.ExtCost AS [Extended Cost], D.QtyRcvd AS [Quantity Received], D.CostReceived AS [Cost Received], 
                         CASE D .RcptStage WHEN 'N' THEN 'N - Not Received' WHEN 'P' THEN 'P - Partially Received' WHEN 'F' THEN 'F - Fully Received' WHEN 'X' THEN 'X - No Receipts Expected' ELSE D .RcptStage END AS [Receipt Stage],
                          D.QtyReturned AS [Quantity Returned], D.CostReturned AS [Cost Returned], 
                         CASE D .VouchStage WHEN 'N' THEN 'N - Not Vouchered' WHEN 'P' THEN 'P - Partially Vouchered' WHEN 'F' THEN 'F - Fully Vouchered' ELSE D .VouchStage END AS [Vouchered Stage], 
                         D.QtyVouched AS [Vouchered Quantity], D.CostVouched AS [Vouchered Cost], D.ProjectID AS [Project ID], D.TaskID AS [Task ID], D.PurAcct AS [Purchasing Account], D.PurSub AS [Purchasing Subaccount], 
                         D.AddlCostPct AS [Additional Cost Percent], D.AlternateID AS [Alternate ID], D.AltIDType AS [Alternate ID Type], D.BlktLineRef AS [Blanket Line Reference Number], D.Buyer, D.CnvFact AS [Conversion Factor], 
                         CONVERT(date, D.Crtd_DateTime) AS [Create Date], D.Crtd_Prog AS [Create Program], D.Crtd_User AS [Create User], D.CuryCostReceived AS [Currency Cost Received], 
                         D.CuryCostReturned AS [Currency Cost Returned], D.CuryCostVouched AS [Currency Cost Vouchered], D.CuryExtCost AS [Currency Extended Cost], D.CuryID AS [Currency ID], 
                         D.CuryMultDiv AS [Currency Multiply/Divide], D.CuryRate AS [Currency Rate], D.CuryTaxAmt00 AS [Currency Tax Amount 01], D.CuryTaxAmt01 AS [Currency Tax Amount 02], 
                         D.CuryTaxAmt02 AS [Currency Tax Amount 03], D.CuryTaxAmt03 AS [Currency Tax Amount 04], D.CuryTxblAmt00 AS [Currency Taxable Amount 01], D.CuryTxblAmt01 AS [Currency Taxable Amount 02], 
                         D.CuryTxblAmt02 AS [Currency Taxable Amount 03], D.CuryTxblAmt03 AS [Currency Taxable Amount 04], D.CuryUnitCost AS [Currency Unit Cost], D.ExtWeight AS [Extended Weight], 
                         D.FlatRateLineNbr AS [Flat Rate Line Number], CASE D .S4Future10 WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE CONVERT(varchar, D .S4Future10) END AS [Include in Forecast Usage Calculation], 
                         CASE D .IRIncLeadTime WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE CONVERT(varchar, D .IRIncLeadTime) END AS [IR Include in Lead Time], 
                         CASE D .KitUnExpld WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE CONVERT(varchar, D .KitUnExpld) END AS [Kit Unexplode], D.Labor_Class_Cd AS [Labor Class Code], CONVERT(date, D.LUpd_DateTime) 
                         AS [Last Update Date], D.LUpd_Prog AS [Last Update Program], D.LUpd_User AS [Last Update User], D.NoteID, CASE D .OrigPOLine WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE CONVERT(varchar, 
                         D .OrigPOLine) END AS [Original PO Line], D.PC_Flag AS [Project Controller Flag], D.PC_ID AS [Project Controller ID], D.PC_Status AS [Project Controller Status], CONVERT(date, D.PromDate) AS [Promised Date], 
                         CASE D .RcptPctAct WHEN 'E' THEN 'E - Error and Reject Quantity' WHEN 'W' THEN 'W - Warn and Accept Quantity' WHEN 'N' THEN 'N - Accept Quantity No Warning' ELSE D .RcptPctAct END AS [Receipt Percent Action],
                          D.RcptPctMax AS [Receipt Percent Maximum], D.RcptPctMin AS [Receipt Percent Minimum], D.ReasonCd AS [Reason Code], D.RefNbr AS [Reference Number], CONVERT(date, D.ReqdDate) AS [Required Date], 
                         D.ReqNbr AS [Required Number], D.ServiceCallID AS [Service Call ID], D.S4Future09 AS [Shelf Life In Days], P.ShipAddr1 AS [Ship-To Address 1], P.ShipAddr2 AS [Ship-To Address 2], 
                         P.ShipAddrID AS [Ship-To Address ID], P.ShipCity AS [Ship-To City], P.ShipCountry AS [Ship-To Country/Region], P.ShipCustID AS [Ship-To Customer ID], CASE WHEN CHARINDEX('~', P.ShipName) 
                         > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(P.ShipName, 1, CHARINDEX('~', P.ShipName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(P.ShipName, CHARINDEX('~', P.ShipName) + 1, 60)))) 
                         ELSE P.ShipName END AS [Ship-To Name], P.ShipState AS [Ship-To State], P.ShipZip AS [Ship-To Postal Code], P.ShipVia AS [Ship Via ID], D.StepNbr AS [Step Number], D.SvcContractID AS [Service Contract ID], 
                         D.SvcLineNbr AS [Service Call Line Number], D.TaxAmt00 AS [Tax Amount 01], D.TaxAmt01 AS [Tax Amount 02], D.TaxAmt02 AS [Tax Amount 03], D.TaxAmt03 AS [Tax Amount 04], D.TaxCalced AS [Tax Calculated], 
                         D.TaxCat AS [Tax Category], D.TaxID00 AS [Tax ID 01], D.TaxID01 AS [Tax ID 02], D.TaxID02 AS [Tax ID 03], D.TaxID03 AS [Tax ID 04], D.TaxIdDflt AS [Tax ID Default], D.TxblAmt00 AS [Taxable Amount 01], 
                         D.TxblAmt01 AS [Taxable Amount 02], D.TxblAmt02 AS [Taxable Amount 03], D.TxblAmt03 AS [Taxable Amount 04], D.UnitMultDiv AS [Unit Multiply/Divide], D.UnitWeight, D.User1, D.User2, D.User3, D.User4, 
                         D.User5, D.User6, CONVERT(date, D.User7) AS User7, CONVERT(date, D.User8) AS User8, D.WIP_COGS_Acct AS [WIP COGS Account], D.WIP_COGS_Sub AS [WIP COGS Subaccount], 
                         D.WOBOMSeq AS [Work Order/Bill of Materials Sequence], D.WOCostType AS [Work Order Cost Type], D.WONbr AS [Work Order Number], D.WOStepNbr AS [Work Order Step Number]
FROM            dbo.ProductClass RIGHT OUTER JOIN
                         dbo.Inventory AS I WITH (nolock) ON dbo.ProductClass.ClassID = I.ClassID RIGHT OUTER JOIN
                         dbo.PurOrdDet AS D WITH (nolock) LEFT OUTER JOIN
                         dbo.PurchOrd AS P WITH (nolock) ON D.CpnyID = P.CpnyID AND D.PONbr = P.PONbr ON I.InvtID = D.InvtID LEFT OUTER JOIN
                         dbo.Site AS S WITH (nolock) ON D.SiteID = S.SiteId

GO