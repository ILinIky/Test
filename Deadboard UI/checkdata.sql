WITH RECURSIVE_CTE AS (
    -- Anker: Erster Datensatz ist immer valid
    SELECT
        t.AutoID,
        t.Extract,
        t.Rows,
        t.Sum,
        t.[Timestamp],
        'valid' AS Status,
        0.0 AS RowDifferencePercent, -- Keine Differenz für den ersten Eintrag
        0.0 AS SumDifferencePercent, -- Keine Differenz für den ersten Eintrag
        t.Rows AS LastValidRows,
        t.Sum AS LastValidSum
    FROM test t
    WHERE t.AutoID = (SELECT MIN(AutoID) FROM test)

    UNION ALL

    -- Rekursive Berechnung für alle folgenden Datensätze
    SELECT
        nxt.AutoID,
        nxt.Extract,
        nxt.Rows,
        nxt.Sum,
        nxt.[Timestamp],
        CASE 
            WHEN ABS((nxt.Rows - RECURSIVE_CTE.LastValidRows)*1.0 / RECURSIVE_CTE.LastValidRows) > 0.15
             OR ABS((nxt.Sum - RECURSIVE_CTE.LastValidSum)*1.0 / RECURSIVE_CTE.LastValidSum) > 0.15
            THEN 'not_valid'
            ELSE 'valid'
        END AS Status,
        ABS((nxt.Rows - RECURSIVE_CTE.LastValidRows) * 1.0 / RECURSIVE_CTE.LastValidRows) * 100 AS RowDifferencePercent,
        ABS((nxt.Sum - RECURSIVE_CTE.LastValidSum) * 1.0 / RECURSIVE_CTE.LastValidSum) * 100 AS SumDifferencePercent,
        CASE 
            WHEN ABS((nxt.Rows - RECURSIVE_CTE.LastValidRows)*1.0 / RECURSIVE_CTE.LastValidRows) > 0.15
             OR ABS((nxt.Sum - RECURSIVE_CTE.LastValidSum)*1.0 / RECURSIVE_CTE.LastValidSum) > 0.15
            THEN RECURSIVE_CTE.LastValidRows
            ELSE nxt.Rows
        END AS LastValidRows,
        CASE 
            WHEN ABS((nxt.Rows - RECURSIVE_CTE.LastValidRows)*1.0 / RECURSIVE_CTE.LastValidRows) > 0.15
             OR ABS((nxt.Sum - RECURSIVE_CTE.LastValidSum)*1.0 / RECURSIVE_CTE.LastValidSum) > 0.15
            THEN RECURSIVE_CTE.LastValidSum
            ELSE nxt.Sum
        END AS LastValidSum
    FROM RECURSIVE_CTE
    JOIN test nxt ON nxt.AutoID = RECURSIVE_CTE.AutoID + 1
)

SELECT 
    AutoID, 
    Extract, 
    Rows, 
    Sum, 
    [Timestamp], 
    Status,
    Round(RowDifferencePercent,2) AS RowDiffPercent,
    Round(SumDifferencePercent,2) AS SumDiffPercent
FROM RECURSIVE_CTE
ORDER BY AutoID;
