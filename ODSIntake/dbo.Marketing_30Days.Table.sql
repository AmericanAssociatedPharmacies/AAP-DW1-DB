USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Marketing_30Days]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marketing_30Days](
	["Recipient ID"] [varchar](500) NULL,
	["Source"] [varchar](500) NULL,
	["Time"] [varchar](500) NULL,
	["OS"] [varchar](500) NULL,
	["Browser"] [varchar](500) NULL,
	["Subject"] [varchar](500) NULL,
	["User Agent"] [varchar](500) NULL,
	["MessageID"] [varchar](500) NULL,
	["(Deprecated) Process Stage"] [varchar](500) NULL,
	["(Deprecated) Traversed Path"] [varchar](500) NULL,
	["2019 Eligible"] [varchar](500) NULL,
	["AAP #"] [varchar](500) NULL,
	["AAP App Received"] [varchar](500) NULL,
	["AAP Effective"] [varchar](500) NULL,
	["AAP Membership Type"] [varchar](500) NULL,
	["AAP Parent"] [varchar](500) NULL,
	["AAP Parent #"] [varchar](500) NULL,
	["AAP Parent Text"] [varchar](500) NULL,
	["AAP Quit"] [varchar](500) NULL,
	["AAP Status"] [varchar](500) NULL,
	["AAP Term Notice"] [varchar](500) NULL,
	[API #] [varchar](500) NULL,
	["API # of Reactivations"] [varchar](500) NULL,
	["API Activation"] [varchar](500) NULL,
	["API Alert"] [varchar](500) NULL,
	["API App Received"] [varchar](500) NULL,
	["API Application Status"] [varchar](500) NULL,
	["API Brands"] [varchar](500) NULL,
	["API Closed"] [varchar](500) NULL,
	["API Credit Alert"] [varchar](500) NULL,
	["API Credit Limit"] [varchar](500) NULL,
	["API Default Shipping"] [varchar](500) NULL,
	["API First Order"] [varchar](500) NULL,
	["API Freight"] [varchar](500) NULL,
	["API Generics"] [varchar](500) NULL,
	["API Generics Q1"] [varchar](500) NULL,
	["API Generics Q2"] [varchar](500) NULL,
	["API Generics Q3"] [varchar](500) NULL,
	["API Generics Q4"] [varchar](500) NULL,
	["API Generics Recommendation"] [varchar](500) NULL,
	["API Generics Update Frequency"] [varchar](500) NULL,
	["API Generics YTD"] [varchar](500) NULL,
	["API Inactive"] [varchar](500) NULL,
	["API Last Order"] [varchar](500) NULL,
	["API MOT"] [varchar](500) NULL,
	["API OTCs"] [varchar](500) NULL,
	["API Order Cut-Off"] [varchar](500) NULL,
	["API Original Activation"] [varchar](500) NULL,
	["API PMID Transition"] [varchar](500) NULL,
	["API Parent"] [varchar](500) NULL,
	["API Parent #"] [varchar](500) NULL,
	["API Payment Method"] [varchar](500) NULL,
	["API Payment Method Profile Form"] [varchar](500) NULL,
	["API Payment Terms"] [varchar](500) NULL,
	["API Primary Order Method"] [varchar](500) NULL,
	["API Priority"] [varchar](500) NULL,
	["API Purchase Goal"] [varchar](500) NULL,
	["API Purchases Date Range"] [varchar](500) NULL,
	["API Questionniare"] [varchar](500) NULL,
	["API Refrigerated"] [varchar](500) NULL,
	["API Status"] [varchar](500) NULL,
	["API Totals"] [varchar](500) NULL,
	["API Warehouse"] [varchar](500) NULL,
	["Account Number"] [varchar](500) NULL,
	["Account Rating"] [varchar](500) NULL,
	["Address 1"] [varchar](500) NULL,
	["Address 1  Address Type"] [varchar](500) NULL,
	["Address 1  Country Region"] [varchar](500) NULL,
	["Address 1  County"] [varchar](500) NULL,
	["Address 1  Fax"] [varchar](500) NULL,
	["Address 1  Freight Terms"] [varchar](500) NULL,
	["Address 1  ID"] [varchar](500) NULL,
	["Address 1  Latitude"] [varchar](500) NULL,
	["Address 1  Longitude"] [varchar](500) NULL,
	["Address 1  Name"] [varchar](500) NULL,
	["Address 1  Post Office Box"] [varchar](500) NULL,
	["Address 1  Primary Contact Name"] [varchar](500) NULL,
	["Address 1  Shipping Method"] [varchar](500) NULL,
	["Address 1  Telephone 2"] [varchar](500) NULL,
	["Address 1  Telephone 3"] [varchar](500) NULL,
	["Address 1  UPS Zone"] [varchar](500) NULL,
	["Address 1  UTC Offset"] [varchar](500) NULL,
	["Address 2  Address Type"] [varchar](500) NULL,
	["Address 2  Country Region"] [varchar](500) NULL,
	["Address 2  County"] [varchar](500) NULL,
	["Address 2  Fax"] [varchar](500) NULL,
	["Address 2  Freight Terms"] [varchar](500) NULL,
	["Address 2  ID"] [varchar](500) NULL,
	["Address 2  Latitude"] [varchar](500) NULL,
	["Address 2  Longitude"] [varchar](500) NULL,
	["Address 2  Name"] [varchar](500) NULL,
	["Address 2  Post Office Box"] [varchar](500) NULL,
	["Address 2  Primary Contact Name"] [varchar](500) NULL,
	["Address 2  Shipping Method"] [varchar](500) NULL,
	["Address 2  Telephone 1"] [varchar](500) NULL,
	["Address 2  Telephone 2"] [varchar](500) NULL,
	["Address 2  Telephone 3"] [varchar](500) NULL,
	["Address 2  UPS Zone"] [varchar](500) NULL,
	["Address 2  UTC Offset"] [varchar](500) NULL,
	["Address Phone"] [varchar](500) NULL,
	["Affiliate"] [varchar](500) NULL,
	["Affiliate Active"] [varchar](500) NULL,
	["Affiliate End"] [varchar](500) NULL,
	["Affiliate Group"] [varchar](500) NULL,
	["Affiliation"] [varchar](500) NULL,
	["Aging 30"] [varchar](500) NULL,
	["Aging 30 (Base)"] [varchar](500) NULL,
	["Aging 60"] [varchar](500) NULL,
	["Aging 60 (Base)"] [varchar](500) NULL,
	["Aging 90"] [varchar](500) NULL,
	["Aging 90 (Base)"] [varchar](500) NULL,
	["Annual Revenue"] [varchar](500) NULL,
	["Annual Revenue (Base)"] [varchar](500) NULL,
	["Aplicor #"] [varchar](500) NULL,
	["Application Approved"] [varchar](500) NULL,
	["Application Fee Date"] [varchar](500) NULL,
	["Application Fee Paid"] [varchar](500) NULL,
	["Application to Credit"] [varchar](500) NULL,
	["Arete Effective"] [varchar](500) NULL,
	["Arete Network"] [varchar](500) NULL,
	["Arete Termination"] [varchar](500) NULL,
	["At Risk"] [varchar](500) NULL,
	["Authorized Signature"] [varchar](500) NULL,
	["Automation"] [varchar](500) NULL,
	["Average Volume"] [varchar](500) NULL,
	["Business Class"] [varchar](500) NULL,
	["Business Established"] [varchar](500) NULL,
	["Business Type"] [varchar](500) NULL,
	["CAH 2nd Account"] [varchar](500) NULL,
	["CAH 3rd Account"] [varchar](500) NULL,
	["CAH Average GCR"] [varchar](500) NULL,
	["CAH Avg Monthly Volume"] [varchar](500) NULL,
	["CAH CSOS Account"] [varchar](500) NULL,
	["CAH Combo Account"] [varchar](500) NULL,
	["CAH Contract Date"] [varchar](500) NULL,
	["CAH Contracted DSO"] [varchar](500) NULL,
	["CAH Cost of Goods"] [varchar](500) NULL,
	["CAH DC"] [varchar](500) NULL,
	["CAH DME Account"] [varchar](500) NULL,
	["CAH Deposit Account"] [varchar](500) NULL,
	["CAH Eff Date New Agreement"] [varchar](500) NULL,
	["CAH Group #"] [varchar](500) NULL,
	["CAH Last Review"] [varchar](500) NULL,
	["CAH Matrix"] [varchar](500) NULL,
	["CAH OTC Account"] [varchar](500) NULL,
	["CAH Order Min Fee"] [varchar](500) NULL,
	["CAH POS Account"] [varchar](500) NULL,
	["CAH Payment Terms"] [varchar](500) NULL,
	["CAH Potential Monthly Volume"] [varchar](500) NULL,
	["CAH Primary Account"] [varchar](500) NULL,
	["CAH Review Type"] [varchar](500) NULL,
	["CAH S&T Account"] [varchar](500) NULL,
	["CAH Specialty Account"] [varchar](500) NULL,
	["CAH Status"] [varchar](500) NULL,
	["CAH Term Code"] [varchar](500) NULL,
	["CAH Term Comments"] [varchar](500) NULL,
	["CAH Term Date"] [varchar](500) NULL,
	["CSOS Alert"] [varchar](500) NULL,
	["CSOS Approved"] [varchar](500) NULL,
	["CSOS Declined"] [varchar](500) NULL,
	["CSOS Installed"] [varchar](500) NULL,
	["CSOS Questionniare Received"] [varchar](500) NULL,
	["CSOS Status"] [varchar](500) NULL,
	["Category"] [varchar](500) NULL,
	["City"] [varchar](500) NULL,
	["Classification"] [varchar](500) NULL,
	["Combined Volume"] [varchar](500) NULL,
	["Conference 2015"] [varchar](500) NULL,
	["Conference 2016"] [varchar](500) NULL,
	["Conference 2017"] [varchar](500) NULL,
	["Conference 2018"] [varchar](500) NULL,
	["Conference 2019"] [varchar](500) NULL,
	["Conference 2020"] [varchar](500) NULL,
	["Conference Cancellation Date"] [varchar](500) NULL,
	["Conference Reg Date"] [varchar](500) NULL,
	["Controlled Substances Profile"] [varchar](500) NULL,
	["Copy to Financial"] [varchar](500) NULL,
	["Copy to Mailing"] [varchar](500) NULL,
	["Copy to Marketing Email"] [varchar](500) NULL,
	["Corporate Name"] [varchar](500) NULL,
	["County"] [varchar](500) NULL,
	["Created By"] [varchar](500) NULL,
	["Created By (Delegate)"] [varchar](500) NULL,
	["Created By (External Party)"] [varchar](500) NULL,
	["Created On"] [varchar](500) NULL,
	["Credit Hold"] [varchar](500) NULL,
	["Credit Limit"] [varchar](500) NULL,
	["Credit Limit (Base)"] [varchar](500) NULL,
	["Credit Report Auth"] [varchar](500) NULL,
	["Currency"] [varchar](500) NULL,
	["Current TM"] [varchar](500) NULL,
	["Customer Size"] [varchar](500) NULL,
	["DEA Pharmacy Name"] [varchar](500) NULL,
	["DEA HIN"] [varchar](500) NULL,
	["DEA HIN Expiration"] [varchar](500) NULL,
	["DEA HIN Issue"] [varchar](500) NULL,
	["Description"] [varchar](500) NULL,
	["Diversion CE"] [varchar](500) NULL,
	["Do not allow Bulk Emails"] [varchar](500) NULL,
	["Do not allow Bulk Mails"] [varchar](500) NULL,
	["Do not allow Emails"] [varchar](500) NULL,
	["Do not allow Faxes"] [varchar](500) NULL,
	["Do not allow Mails"] [varchar](500) NULL,
	["Do not allow Phone Calls"] [varchar](500) NULL,
	["DocuSign Sender"] [varchar](500) NULL,
	["DocuSign Sender Email"] [varchar](500) NULL,
	["Dun & Bradstreet No"] [varchar](500) NULL,
	["EDI Alias"] [varchar](500) NULL,
	["EDI FTP 832 Tier 2"] [varchar](500) NULL,
	["EDI FTP 832 Tier 2 Start"] [varchar](500) NULL,
	["EDI FTP Activation"] [varchar](500) NULL,
	["EDI FTP Application Received"] [varchar](500) NULL,
	["EDI FTP Approved"] [varchar](500) NULL,
	["Entity Image Id"] [varchar](500) NULL,
	["Exchange Rate"] [varchar](500) NULL,
	["Executive Email"] [varchar](500) NULL,
	["FTP Site"] [varchar](500) NULL,
	["Fax"] [varchar](500) NULL,
	["Federal Tax ID #"] [varchar](500) NULL,
	["Financial City"] [varchar](500) NULL,
	["Financial Email"] [varchar](500) NULL,
	["Financial State"] [varchar](500) NULL,
	["Financial Street 1"] [varchar](500) NULL,
	["Financial Street 2"] [varchar](500) NULL,
	["Financial Street 3"] [varchar](500) NULL,
	["Financial Zip"] [varchar](500) NULL,
	["Follow Email Activity"] [varchar](500) NULL,
	["General Email"] [varchar](500) NULL,
	["General Email 2"] [varchar](500) NULL,
	["Group #"] [varchar](500) NULL,
	["Group AAP"] [varchar](500) NULL,
	["Group API"] [varchar](500) NULL,
	["Group Alliance"] [varchar](500) NULL,
	["Group CAH"] [varchar](500) NULL,
	["Historical Record"] [varchar](500) NULL,
	["IATV"] [varchar](500) NULL,
	["IATV Title"] [varchar](500) NULL,
	["Import Sequence Number"] [varchar](500) NULL,
	["Incorporation State"] [varchar](500) NULL,
	["Industry"] [varchar](500) NULL,
	["Industry Support Fund"] [varchar](500) NULL,
	["Last Buy Analysis"] [varchar](500) NULL,
	["Last Date Included in Campaign"] [varchar](500) NULL,
	["Last On Hold Time"] [varchar](500) NULL,
	["Last SLA applied"] [varchar](500) NULL,
	["Last Visit (Rollup)"] [varchar](500) NULL,
	["Last Visit (Rollup) (Last Updated On)"] [varchar](500) NULL,
	["Last Visit (Rollup) (State)"] [varchar](500) NULL,
	["Magento Flight"] [varchar](500) NULL,
	["Magic Link"] [varchar](500) NULL,
	["Mailing Address"] [varchar](500) NULL,
	["Mailing CIty"] [varchar](500) NULL,
	["Mailing State"] [varchar](500) NULL,
	["Mailing Street 1"] [varchar](500) NULL,
	["Mailing Street 2"] [varchar](500) NULL,
	["Mailing Street 3"] [varchar](500) NULL,
	["Mailing Zip"] [varchar](500) NULL,
	["Main Phone"] [varchar](500) NULL,
	["Managed Care Affiliation"] [varchar](500) NULL,
	["Managed Care Affiliation (Old)"] [varchar](500) NULL,
	["Market Capitalization"] [varchar](500) NULL,
	["Market Capitalization (Base)"] [varchar](500) NULL,
	["Marketing Email"] [varchar](500) NULL,
	["Marketing Level"] [varchar](500) NULL,
	["Marketing Only"] [varchar](500) NULL,
	["Master ID"] [varchar](500) NULL,
	["Member Support Rep"] [varchar](500) NULL,
	["Membership Owner"] [varchar](500) NULL,
	["Merged"] [varchar](500) NULL,
	["Mobile Device"] [varchar](500) NULL,
	["Modified By"] [varchar](500) NULL,
	["Modified By (Delegate)"] [varchar](500) NULL,
	["Modified By (External Party)"] [varchar](500) NULL,
	["Modified On"] [varchar](500) NULL,
	["NCPA ID"] [varchar](500) NULL,
	["NCPDP"] [varchar](500) NULL,
	["NPI"] [varchar](500) NULL,
	["Number of Employees"] [varchar](500) NULL,
	["On Hold Time (Minutes)"] [varchar](500) NULL,
	["Open Deals"] [varchar](500) NULL,
	["Open Deals(Last Updated Time)"] [varchar](500) NULL,
	["Open Deals(State)"] [varchar](500) NULL,
	["Open Revenue"] [varchar](500) NULL,
	["Open Revenue (Base)"] [varchar](500) NULL,
	["Open Revenue(Last Updated Time)"] [varchar](500) NULL,
	["Open Revenue(State)"] [varchar](500) NULL,
	["Ordering Contact"] [varchar](500) NULL,
	["Ordering Contact Text"] [varchar](500) NULL,
	["Organization Type"] [varchar](500) NULL,
	["Originating Lead"] [varchar](500) NULL,
	["Other Phone"] [varchar](500) NULL,
	["Owner"] [varchar](500) NULL,
	["Owner Email"] [varchar](500) NULL,
	["Owner Id"] [varchar](500) NULL,
	["Owner Type"] [varchar](500) NULL,
	["Ownership"] [varchar](500) NULL,
	["Ownership Change"] [varchar](500) NULL,
	["Owning Business Unit"] [varchar](500) NULL,
	["Owning Team"] [varchar](500) NULL,
	["Owning User"] [varchar](500) NULL,
	[PMID] [varchar](500) NULL,
	["Parent Account Text"] [varchar](500) NULL,
	["Participates in Workflow"] [varchar](500) NULL,
	["Payment Terms"] [varchar](500) NULL,
	["Personal Guaranty"] [varchar](500) NULL,
	["Pharmacist License"] [varchar](500) NULL,
	["Pharmacist License Expiration"] [varchar](500) NULL,
	["Pharmacist Name"] [varchar](500) NULL,
	["Pharmacy Name"] [varchar](500) NULL,
	["Pharmacy Owner"] [varchar](500) NULL,
	["Pharmacy Owner Email"] [varchar](500) NULL,
	["Pharmacy Owner Fax"] [varchar](500) NULL,
	["Pharmacy Owner Mobile Phone"] [varchar](500) NULL,
	["Pharmacy Owner Phone"] [varchar](500) NULL,
	["Pharmacy Owner Text"] [varchar](500) NULL,
	["Pharmacy Owner Title"] [varchar](500) NULL,
	["Pharmacy Software (Old)"] [varchar](500) NULL,
	["Pharmacy System"] [varchar](500) NULL,
	["Photos Received"] [varchar](500) NULL,
	["Planogram"] [varchar](500) NULL,
	["Planogram Quit"] [varchar](500) NULL,
	["Planogram Start"] [varchar](500) NULL,
	["Power of Attorney"] [varchar](500) NULL,
	["Preferred Day"] [varchar](500) NULL,
	["Preferred Facility Equipment"] [varchar](500) NULL,
	["Preferred Method of Contact"] [varchar](500) NULL,
	["Preferred Service"] [varchar](500) NULL,
	["Preferred Time"] [varchar](500) NULL,
	["Preferred User"] [varchar](500) NULL,
	["Previous Group Alliance"] [varchar](500) NULL,
	["Previous Member PMID"] [varchar](500) NULL,
	["Previous Member Record"] [varchar](500) NULL,
	["Previous Primary Wholesaler"] [varchar](500) NULL,
	["Previous Wholesaler"] [varchar](500) NULL,
	["Previous Wholesaler Account No"] [varchar](500) NULL,
	["Price List"] [varchar](500) NULL,
	["Primary Attestation"] [varchar](500) NULL,
	["Primary Contact"] [varchar](500) NULL,
	["Primary Contact Text"] [varchar](500) NULL,
	["Primary Satori ID"] [varchar](500) NULL,
	["Primary Twitter ID"] [varchar](500) NULL,
	["Primary Wholesaler"] [varchar](500) NULL,
	["Primary Wholesaler (Old)"] [varchar](500) NULL,
	["Primary Wholesaler Account No"] [varchar](500) NULL,
	["Process"] [varchar](500) NULL,
	["ProfitAmp Activation (FA)"] [varchar](500) NULL,
	["ProfitAmp Activation (MA)"] [varchar](500) NULL,
	["ProfitAmp Billing"] [varchar](500) NULL,
	["ProfitAmp Fee"] [varchar](500) NULL,
	["ProfitAmp Level"] [varchar](500) NULL,
	["ProfitAmp Notice (FA)"] [varchar](500) NULL,
	["ProfitAmp Notice (MA)"] [varchar](500) NULL,
	["ProfitAmp Received (FA)"] [varchar](500) NULL,
	["ProfitAmp Received (MA)"] [varchar](500) NULL,
	["ProfitAmp Sender"] [varchar](500) NULL,
	["ProfitAmp Sender Email"] [varchar](500) NULL,
	["ProfitAmp Sent (FA)"] [varchar](500) NULL,
	["ProfitAmp Sent (MA)"] [varchar](500) NULL,
	["ProfitAmp Signer Email"] [varchar](500) NULL,
	["ProfitAmp Signer Name"] [varchar](500) NULL,
	["ProfitAmp Signer Title"] [varchar](500) NULL,
	["ProfitAmp Termination (FA)"] [varchar](500) NULL,
	["ProfitAmp Termination (MA)"] [varchar](500) NULL,
	["ProfitAmp Upgrade"] [varchar](500) NULL,
	["Rebate Payment Method"] [varchar](500) NULL,
	["Record Created On"] [varchar](500) NULL,
	["Referral Incentive Date"] [varchar](500) NULL,
	["Referral Incentive Paid"] [varchar](500) NULL,
	["Referral Incentive Status"] [varchar](500) NULL,
	["Referral Status"] [varchar](500) NULL,
	["Referral Submission Date"] [varchar](500) NULL,
	["Referring Pharmacy"] [varchar](500) NULL,
	["Referring Pharmacy Email"] [varchar](500) NULL,
	["Relationship Type"] [varchar](500) NULL,
	["Resignation Reason"] [varchar](500) NULL,
	["S&T Activation"] [varchar](500) NULL,
	["S&T Application Received"] [varchar](500) NULL,
	["S&T Brand Smart Plus"] [varchar](500) NULL,
	["S&T Cloud"] [varchar](500) NULL,
	["S&T Cloud Workstations"] [varchar](500) NULL,
	["S&T Eligible"] [varchar](500) NULL,
	["S&T Mobile"] [varchar](500) NULL,
	["S&T Mobile Install Date"] [varchar](500) NULL,
	["S&T PVA Mode"] [varchar](500) NULL,
	["S&T PVA Mode Max Brand"] [varchar](500) NULL,
	["S&T PVA Mode Max Generic"] [varchar](500) NULL,
	["S&T Status"] [varchar](500) NULL,
	["S&T Tier 2"] [varchar](500) NULL,
	["S&T Version"] [varchar](500) NULL,
	["SIC Code"] [varchar](500) NULL,
	["SLA"] [varchar](500) NULL,
	["Saturdays Close"] [varchar](500) NULL,
	["Saturdays Open"] [varchar](500) NULL,
	["Secondary Phone"] [varchar](500) NULL,
	["Send Application Email"] [varchar](500) NULL,
	["Send Application Name"] [varchar](500) NULL,
	["Send Application Title"] [varchar](500) NULL,
	["Send Marketing Materials"] [varchar](500) NULL,
	["Shares Outstanding"] [varchar](500) NULL,
	["Shipping Method"] [varchar](500) NULL,
	["Site Questionnaire Received"] [varchar](500) NULL,
	["Software Liability Waiver"] [varchar](500) NULL,
	["Specialty"] [varchar](500) NULL,
	["Start Up"] [varchar](500) NULL,
	["State"] [varchar](500) NULL,
	["State CS License"] [varchar](500) NULL,
	["State CS License Expiration"] [varchar](500) NULL,
	["State License"] [varchar](500) NULL,
	["State License Expiration"] [varchar](500) NULL,
	["State Tax ID #"] [varchar](500) NULL,
	["Status"] [varchar](500) NULL,
	["Stock Exchange"] [varchar](500) NULL,
	["Street 1"] [varchar](500) NULL,
	["Street 2"] [varchar](500) NULL,
	["Street 3"] [varchar](500) NULL,
	["Sub-Type"] [varchar](500) NULL,
	["Sundays Close"] [varchar](500) NULL,
	["Sundays Open"] [varchar](500) NULL,
	["TeamsFollowed"] [varchar](500) NULL,
	["Telephone 3"] [varchar](500) NULL,
	["Territory"] [varchar](500) NULL,
	["Territory Code_DO NOT USE"] [varchar](500) NULL,
	["Territory Manager"] [varchar](500) NULL,
	["Territory Manager Email"] [varchar](500) NULL,
	["Territory_DO NOT USE"] [varchar](500) NULL,
	["Ticker Symbol"] [varchar](500) NULL,
	["Time Spent by me"] [varchar](500) NULL,
	["Time Zone Rule Version Number"] [varchar](500) NULL,
	["Tri State API ID"] [varchar](500) NULL,
	["Tri State API Select"] [varchar](500) NULL,
	["Tri State API Select End"] [varchar](500) NULL,
	["Tri State API Select Start"] [varchar](500) NULL,
	["Trigger API Onboarding"] [varchar](500) NULL,
	["Type"] [varchar](500) NULL,
	["Type (Previous Value)"] [varchar](500) NULL,
	["UTC Conversion Time Zone Code"] [varchar](500) NULL,
	["VAI #"] [varchar](500) NULL,
	["Version Number"] [varchar](500) NULL,
	["Website"] [varchar](500) NULL,
	["Weekdays Close"] [varchar](500) NULL,
	["Weekdays Open"] [varchar](500) NULL,
	["Yomi Account Name"] [varchar](500) NULL,
	["Zip"] [varchar](500) NULL,
	["Zone"] [varchar](500) NULL,
	["ListId"] [varchar](500) NULL,
	[" tz"] [varchar](500) NULL
) ON [PRIMARY]
GO
