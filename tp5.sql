-- a --
SELECT * FROM ARTICLE a
Order by a.DESIGNATION ASC;

-- b --
SELECT * FROM ARTICLE a
Order by a.PRIX DESC;

-- c --
SELECT * from ARTICLE a 
WHERE a.DESIGNATION LIKE '%boulon%'
ORDER BY a.PRIX ASC;

-- d --
SELECT * from ARTICLE a 
WHERE a.DESIGNATION LIKE '%sachet%';

-- e --
SELECT * from ARTICLE a 
WHERE UPPER(a.DESIGNATION) LIKE UPPER('%sachet%');

-- f --
SELECT * FROM ARTICLE a 
JOIN FOURNISSEUR f on a.ID_FOU = f.ID
ORDER BY f.NOM  ASC, a.PRIX DESC; 

-- g --
SELECT * FROM ARTICLE a 
JOIN FOURNISSEUR f on a.ID_FOU = f.ID
WHERE f.NOM like '%Dubois & Fils%';

-- h --
SELECT AVG(a.PRIX) as 'Moyenne de prix' FROM ARTICLE a 
JOIN FOURNISSEUR f on a.ID_FOU = f.ID
WHERE f.NOM like '%Dubois & Fils%';

-- i --
SELECT f.NOM, AVG(a.PRIX) as 'Moyenne de prix' FROM ARTICLE a 
JOIN FOURNISSEUR f on a.ID_FOU = f.ID
GROUP BY f.ID; 

-- j --
SELECT * FROM BON b 
WHERE b.DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k --
SELECT b.id, b.NUMERO, b.DATE_CMDE, b.DELAI  FROM BON b 
JOIN COMPO c ON b.ID = c.ID_BON 
JOIN ARTICLE a ON a.ID = c.ID_ART
WHERE a.DESIGNATION LIKE '%boulon%'
GROUP BY b.ID; 

-- l --
SELECT b.id, b.NUMERO, b.DATE_CMDE, b.DELAI, f.NOM  FROM BON b 
JOIN COMPO c ON b.ID = c.ID_BON 
JOIN ARTICLE a ON a.ID = c.ID_ART
JOIN FOURNISSEUR f ON b.ID_FOU = f.ID 
WHERE a.DESIGNATION LIKE '%boulon%'
GROUP BY b.ID; 

-- m --
SELECT c.ID_BON ,SUM(c.QTE * a.PRIX) as 'Total bon' FROM COMPO c  
JOIN ARTICLE a ON a.ID = c.ID_ART
GROUP BY c.ID_BON;

-- n --
SELECT c.ID_BON ,SUM(c.QTE) as 'Nombre d''articles' FROM COMPO c  
JOIN ARTICLE a ON a.ID = c.ID_ART
GROUP BY c.ID_BON;

-- o --
SELECT b.NUMERO ,SUM(c.QTE) as 'Nombre d''articles' FROM COMPO c  
JOIN ARTICLE a ON a.ID = c.ID_ART
JOIN BON b ON c.ID_BON = b.ID
GROUP BY c.ID_BON
HAVING SUM(c.QTE) > 25;

-- p --
SELECT SUM(c.QTE * a.PRIX) as 'Total commande' FROM COMPO c  
JOIN ARTICLE a ON a.ID = c.ID_ART
JOIN BON b ON c.ID_BON = b.ID
WHERE b.DATE_CMDE BETWEEN '2019-04-01' AND '2019-04-30';

-- Requetes difficiles --

-- a --
SELECT a1.ID, a1.DESIGNATION, a1.ID_FOU, a2.ID_FOU  AS Autre_FOURNISSEUR
FROM ARTICLE a1
JOIN ARTICLE a2 ON a1.DESIGNATION = a2.DESIGNATION AND a1.ID_FOU != a2.ID_FOU ;


-- b --
SELECT YEAR(b.DATE_CMDE) AS Annee, MONTH(b.DATE_CMDE) AS Mois, SUM(a.PRIX * c.QTE) AS Depenses
FROM BON b
JOIN COMPO c ON b.ID = c.ID_BON
JOIN ARTICLE a ON c.ID_ART = a.ID
GROUP BY YEAR(b.DATE_CMDE), MONTH(b.DATE_CMDE)
ORDER BY Annee, Mois;

-- c --
SELECT * FROM BON b 
WHERE ID NOT IN (SELECT DISTINCT ID_BON FROM COMPO c);

-- Avec EXISTS --

SELECT * 
FROM BON b 
WHERE NOT EXISTS (
	SELECT *  
	FROM COMPO c
	WHERE b.ID = c.ID_BON	
);

-- d --
SELECT f.NOM AS Fournisseur, AVG(total_prix_bon) AS PrixMoyenCommande
FROM (
    SELECT b.ID_FOU, b.ID, SUM(a.PRIX * c.QTE) AS total_prix_bon
    FROM BON b
    JOIN COMPO c ON b.ID = c.ID_BON
    JOIN ARTICLE a ON c.ID_ART = a.ID
    GROUP BY b.ID_FOU, b.ID
) AS bons_fournisseur
JOIN FOURNISSEUR f ON bons_fournisseur.ID_FOU = f.ID
GROUP BY bons_fournisseur.ID_FOU;






