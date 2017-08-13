--QQ for AR aging reporting

CREATE VIEW [dbo].[QQ08610] AS

SELECT d.CustID
    , c.Name as [Customer Name]
    , d.SlsperId
    , p.manager1
    , AvgDayToPay
    , d.DocType
    , d.RefNbr
    , c.terms
    , d.DocDate
    , d.DueDate
    , DaysPastDue = Case when d.DocType in ('CM', 'PA', 'PP') then 0 else DateDiff(Day, d.DueDate, s.Crtd_DateTime) end
    , d.ProjectID
    , d.CustOrdNbr
    , d.DocDesc
    , CuryOrigDocAmt = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * d.CuryOrigDocAmt
    , [Current] = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') 
                    THEN 1 
                   ELSE -1 
              END * CASE WHEN d.DocType NOT IN ('CM', 'PA', 'PP') AND s.Crtd_DateTime<= d.DueDate 
                                  OR d.DocType IN ('CM', 'PA', 'PP') AND (s.Crtd_DateTime<=d.DocDate OR ARSetup.S4Future09=0) 
                            THEN d.DocBal 
                         ELSE 0 
                    END
    , [1 to 30] = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') 
                       THEN 1 
                      ELSE -1 
                 END * CASE WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') 
                                                      THEN d.DocDate 
                                                    ELSE d.DueDate 
                                               END, s.Crtd_DateTime) <= s.AgeDays00 AND 
			         DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') 
                                                      THEN d.DocDate  
                                                    ELSE d.DueDate 
                                               END, s.Crtd_DateTime) >= 1 AND
                                 (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) 
                              THEN d.DocBal
		            ELSE 0 END
    , [31 to 60] = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) <= s.AgeDays01 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) > s.AgeDays00 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END
    , [61 to 90] = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) <= s.AgeDays02 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) > s.AgeDays01 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END
    , [Over 90] = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) > s.AgeDays02 AND 
                (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END
    , Total =  (CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') 
                       THEN 1 
                      ELSE -1 
                 END * CASE WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') 
                                                      THEN d.DocDate 
                                                    ELSE d.DueDate 
                                               END, s.Crtd_DateTime) <= s.AgeDays00 AND 
			         DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') 
                                                      THEN d.DocDate  
                                                    ELSE d.DueDate 
                                               END, s.Crtd_DateTime) >= 1 AND
                                 (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) 
                              THEN d.DocBal
		            ELSE 0 END +
	CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) <= s.AgeDays01 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) > s.AgeDays00 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END +
	 CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) <= s.AgeDays02 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, s.Crtd_DateTime) > s.AgeDays01 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END +
	CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END
    , s.Crtd_DateTime) > s.AgeDays02 AND (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal ELSE 0 END)

    FROM ARDoc d 
    INNER JOIN AR_Balances b ON b.CpnyID=d.CpnyID AND b.CustID=d.CustID 
    INNER JOIN Customer c  ON c.CustID=d.CustID
    INNER JOIN PJProj p on d.ProjectID = p.project		  
    INNER JOIN (SELECT Ord=1, StmtCycleID, AgeDays00 = CONVERT(INT,AgeDays00), GetDate() as Crtd_DateTime,
                    AgeDays01 = CONVERT(INT,AgeDays01), AgeDays02 = CONVERT(INT,AgeDays02) 
                    FROM ARStmt) s 
        ON s.StmtCycleID=c.StmtCycleID 
    LEFT JOIN Terms t ON d.Terms <> '' AND t.TermsID=d.Terms 
    CROSS JOIN ARSetup (NOLOCK)

 WHERE d.Rlsed=1 AND d.CuryDocBal<>0 

