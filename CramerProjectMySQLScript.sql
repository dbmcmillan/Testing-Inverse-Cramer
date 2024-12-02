CREATE TABLE cramerpicks500 AS
SELECT * FROM cramerpicks JOIN sandp ON cramerpicks.Ticker = sandp.Symbol;

CREATE VIEW joined AS
select cramerpicks500.Ticker, cramerpicks500.Company, sandp.Longname FROM cramerpicks500
JOIN sandp ON cramerpicks500.Ticker = sandp.Symbol;

select * from cramerpicks500 where Company = "Not Available";

UPDATE cramerpicks500 join joined on cramerpicks500.Ticker = joined.Ticker
SET cramerpicks500.Company = joined.Longname
WHERE cramerpicks500.Company = "Not Available"
; 

ALTER TABLE cramerpicks500 
DROP COLUMN Symbol, 
DROP COLUMN Shortname,
DROP COLUMN Longname;


Select Ticker, Company, AVG(`1-Year Change Benchmark`) from cramerpicks500 group by Ticker, Company ORDER BY AVG(`1-Year Change Benchmark`) ;

SELECT * from cramerpicks500;

SELECT STR_TO_DATE(`Date`, '%e/%c/%Y') AS `Date`;

UPDATE cramerpicks500
SET `Date` = STR_TO_DATE(`Date`, '%e/%c/%Y');

SELECT * FROM cramerpicks500
INTO OUTFILE "C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\cramerpicks500"
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

SELECT * FROM cramerpicks500
INTO OUTFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cramerpicks500.csv"
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
