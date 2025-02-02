WITH Masterdata AS (
    SELECT [BOARD customer group], [Key account], [REP Auto GI Other], [SU - Area Reporting], [REP Business Unit],
           ROW_NUMBER() OVER (PARTITION BY [BOARD customer group] ORDER BY [BOARD customer group]) AS rn
    FROM [board_staging_ROB].[dbo].[DP_RD_PPortfolio_BCG_Masterdata_all]
)
INSERT INTO [board_staging_ROB].[dbo].[DP_RD_PPortfolio_TBL_DemandPlanning_ACT_all] (
    [BOARD customer group],
    [Key account],
    [REP Auto GI Other],
    [SU - Area DESC],
    [REP Business Unit],
    [Product],
    [Plant],
    [Class],
    [Product Family DESC],
    [Month],
    [Actuals]
)
SELECT 
    m.[BOARD customer group],
    m.[Key account],
    m.[REP Auto GI Other],
    m.[SU - Area Reporting],
    m.[REP Business Unit],
    i.[Product],
    i.[Plant],
    i.[Class],
    i.[Product Family],
    i.[Month],
    i.[Spalte 4] as Actuals
FROM Masterdata m
JOIN [board_staging_ROB].[dbo].[DP_RD_PPortfolio_IST] i
    ON m.[BOARD customer group] = i.[BOARD customer group]
JOIN [board_staging_ROB].[dbo].[DP_RD_PPortfolio_Area_2] a
    ON m.[BOARD customer group] = a.[BOARD customer group]
WHERE m.rn = 1
  AND a.[Spalte 2] != 0;