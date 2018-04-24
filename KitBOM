CREATE VIEW dbo.x_QQ_KitBOM AS
WITH k AS
(SELECT c.KitID AS OrigID, c.KitID, c.CmpnentID, CAST(1 AS float) ParentQty, c.CmpnentQty, 0 Level -- "anchor"
 FROM dbo.Component AS c
 UNION ALL
 SELECT k.OrigID, c.KitID, c.CmpnentID, k.CmpnentQty, c.CmpnentQty, k.Level + 1
 FROM dbo.Component AS c JOIN k ON c.KitID = k.CmpnentID)
SELECT k.OrigID Kit, ik.Descr KitName, CASE WHEN MAX(c.KitID) IS NULL THEN k.CmpnentID ELSE '*' + k.CmpnentID END Component, ic.Descr ComponentName, SUM(k.CmpnentQty * k.ParentQty) Qty
FROM k JOIN dbo.Inventory AS ik ON k.OrigID = ik.InvtID JOIN dbo.Inventory AS ic ON k.CmpnentID = ic.InvtID
LEFT JOIN dbo.Component AS c ON k.CmpnentID = c.KitID
GROUP BY k.OrigID, ik.Descr, k.CmpnentID, ic.Descr;
