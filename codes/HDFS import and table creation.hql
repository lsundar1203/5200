
hdfs dfs -mkdir drug
hdfs dfs -mkdir drug/cig
hdfs dfs -mkdir drug/cig1
hdfs dfs -mkdir drug/cig2
hdfs dfs -mkdir drug/cig3
hdfs dfs -mkdir drug/Mari
hdfs dfs -mkdir drug/alcohol
hdfs dfs -mkdir drug/cocaine
hdfs dfs -mkdir drug/heroine
hdfs dfs -mkdir drug/weight

cd drug

hdfs dfs -put cigestimate.csv drug/cig
hdfs dfs -put cigbrand.csv drug/cig1
hdfs dfs -put Cigfrequency.csv drug/cig2
hdfs dfs -put First_cig_smoke_stat.csv drug/cig3
hdfs dfs -put Mari_full.csv drug/Mari
hdfs dfs -put Alcohol.csv drug/alcohol
hdfs dfs -put Cocaine1.csv drug/cocaine
hdfs dfs -put heroine.csv drug/heroine
hdfs dfs -put weight.csv drug/weight


DROP TABLE IF EXISTS CIGESTIMATE;
CREATE EXTERNAL TABLE IF NOT EXISTS Cigestimate
(CASEID BIGINT,QUESTID BIGINT,CIGEVER INT,CIGWILYR INT,CIGREC INT,
CIG30AV INT,CG30EST INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/cig'
TBLPROPERTIES ('skip.header.line.count'='1');


DROP TABLE IF EXISTS CIGBRAND;
CREATE EXTERNAL TABLE IF NOT EXISTS Cigbrand
(CASEID BIGINT,QUESTID BIGINT,
Brandmostused INT, 30daybrand INT, MENTHOL30 INT,CIG30MLN INT,CIG30RO INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/cig1'
TBLPROPERTIES ('skip.header.line.count'='1');


DROP TABLE IF EXISTS CIGFREQUENCY;
CREATE EXTERNAL TABLE IF NOT EXISTS cigfrequency
(CASEID INT,QUESTID INT,CIGDLYMO INT,CIGAGE INT,CIGDLYFU INT,CIGDLMFU INT)
ROW FORMAT DELIMITED FIELDs TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/cig2'
TBLPROPERTIES('skip.header.line.count'='1');


DROP TABLE IF EXISTS First_cigsmokestat;
CREATE EXTERNAL TABLE IF NOT EXISTS Firstcigsmoke
(CASEID INT, QUESTID INT,CIGEVER INT, CIGTRY INT, CIGYFU INT, CIGMFU INT)
ROW FORMAT DELIMITED FIELDs TERMINATED BY'|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/cig3'
TBLPROPERTIES('skip.header.line.count'='1');

DROP TABLE IF EXISTS Mari;
CREATE EXTERNAL TABLE IF NOT EXISTS Mari
(CASEID INT, QUESTID INT,MJEVER INT, MJAGE INT,MJYFU INT, MJMFU INT,MJREC INT,MJYRTOT INT,
MRTOTFG INT,MJFQFLG INT,MRBSTWAY INT,MRDAYPYR INT,MRDAYPMO INT,MRDAYPWK INT,MJDAY30A INT,
MR30EST INT)
ROW FORMAT DELIMITED FIELDs TERMINATED BY'|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/Mari'
TBLPROPERTIES('skip.header.line.count'='1');

DROP TABLE IF EXISTS alcohol;
CREATE TABLE IF NOT EXISTS alcohol (CASEID BIGINT,QUESTID2 BIGINT, ALCEVER BIGINT , 
ALCTRY BIGINT, ALCYFU BIGINT, ALCMFU BIGINT, ALCREC BIGINT,
ALCYRTOT BIGINT, ALTOTFG BIGINT, ALFQFLG BIGINT, ALBSTWAY BIGINT, 
ALDAYPYR BIGINT , ALDAYPMO BIGINT, ALDAYPWK BIGINT, ALCDAYS BIGINT, AL30EST BIGINT, 
ALDYSFG BIGINT) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION '/user/pattima/drug/alcohol'
TBLPROPERTIES ('skip.header.line.count'='1');

CREATE TABLE IF NOT EXISTS cocaine (CASEID BIGINT,QUESTID2 BIGINT, COCEVER BIGINT , 
COCAGE BIGINT, COCYFU BIGINT, COCMFU BIGINT, COCREC BIGINT, 
COCYRTOT BIGINT, CCTOTFG BIGINT, CCFQFLG BIGINT, CCBSTWAY BIGINT, 
CCDAYPYR BIGINT , CCDAYPMO BIGINT, CCDAYPWK BIGINT, COCUS30A BIGINT, 
CC30EST BIGINT) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' 
STORED AS TEXTFILE LOCATION '/user/pattima/drug/cocaine'
TBLPROPERTIES ('skip.header.line.count'='1');

CREATE TABLE IF NOT EXISTS heroine (CASEID BIGINT,QUESTID2 BIGINT, HEREVER BIGINT ,
HERAGE BIGINT, HERYFU BIGINT, HERMFU BIGINT, HERREC BIGINT, 
HERYRTOT BIGINT, HRTOTFG BIGINT, HRFQFLG BIGINT, HRBSTWAY BIGINT, 
HRDAYPYR BIGINT , HRDAYPMO BIGINT, HRDAYPWK BIGINT,HER30USE BIGINT, 
HR30EST BIGINT) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/heroine'
TBLPROPERTIES ('skip.header.line.count'='1');

CREATE TABLE IF NOT EXISTS QUESTION2
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE LOCATION 
'/user/natya/project/QUESTION2'

AS


select HEREVER,HERYFU,HERREC,

case

when HEREVER=1 and HERYFU=2012 or HERYFU=2013 or HERYFU=2014 and HERREC=1 then 'longest user'

when HEREVER=1 and HERYFU=2012 or HERYFU=2013 or HERYFU=2014 and HERREC>1 or HERREC=2 then 'not a frequent user'


when HEREVER=1 and HERYFU=2012 or HERYFU=2013 or HERYFU=2014 and HERREC=8 or HERREC=3 or HERREC=9 then 'moderate user'


end

from HEROIN

where HEREVER NOT IN (94,97)

and 
HERYFU NOT IN(9994,9997,9998,9999,9989)
and 
HERREC NOT IN(91,97,98);



