-- a --
UPDATE ARTICLE a 
SET a.DESIGNATION = LOWER(a.DESIGNATION) 
WHERE a.ID = 2;

-- b --
UPDATE ARTICLE a 
SET a.DESIGNATION = UPPER(a.DESIGNATION) 
WHERE a.PRIX > 10;

-- c --
UPDATE ARTICLE
SET PRIX = PRIX * 0.9
WHERE ID NOT IN (SELECT DISTINCT ID_ART FROM COMPO);

-- d --
UPDATE COMPO  
SET QTE = QTE * 2
WHERE COMPO.ID_ART IN (SELECT ID FROM ARTICLE WHERE ID_FOU = 1);

-- e --
UPDATE ARTICLE 
SET DESIGNATION = SUBSTR(DESIGNATION, 1, LOCATE('(', DESIGNATION) - 1)
WHERE DESIGNATION LIKE '%(%' ;

-- OU --

UPDATE ARTICLE 
SET DESIGNATION = CONCAT(
	SUBSTR(DESIGNATION, 1, LOCATE('(', DESIGNATION) - 1), 
	SUBSTR(DESIGNATION, LOCATE(')', DESIGNATION) + 1))
WHERE DESIGNATION LIKE '%(%' OR DESIGNATION LIKE '%)%';





