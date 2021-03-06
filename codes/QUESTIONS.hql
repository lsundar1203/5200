1)Comparison between age of first cig smoked to which age group smokes cig more

hive>DROP TABLE IF EXISTS smoke_stat;
    >CREATE TABLE IF NOT EXISTS smoke_stat
    >ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
    >STORED AS TEXTFILE LOCATION '/user/pattima/drug/smoke_stat'
    >AS
    >select CIGFREQUENCY.CASEID,CIGFREQUENCY.CIGAGE,FIRSTCIGSMOKE.CIGTRY,
    >case
    >when CIGFREQUENCY.CIGAGE=FIRSTCIGSMOKE.CIGTRY OR CIGFREQUENCY.CIGAGE<FIRSTCIGSMOKE.CIGTRY then'HIGHRISK' 
    >else 'LOWRISK'
    >end
    >from CIGFREQUENCY, FIRSTCIGSMOKE
    >where CIGFREQUENCY.CASEID=FIRSTCIGSMOKE.CASEID ;


2)Comparison of people used marijuana in a week to that of a month detecting the useage levels

DROP TABLE IF EXISTS marijuana;
CREATE TABLE IF NOT EXISTS marijuana
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/marijuana'
AS
select questid,mrdaypwk,mjday30a,
case
when mrdaypwk<8 and mrdaypwk>=mjday30a then 'LOWLEVEL USAGE' 
when mRdaypwk <8 AND mjday30a>20 then 'HIGHLEVEL USAGE'
else 'MEDICORE USAGE'
end
from Mari 
where mrdaypwk < 8 
AND MJDAY30A <32 ;


3)Frequency of first cig smoke to  the estimate of time when last cig was smoked

DROP TABLE IF EXISTS QUESTION3;
CREATE TABLE IF NOT EXISTS QUESTION3
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/Question3'
AS
select cigfrequency.caseid,cigestimate.cigrec,
cigfrequency.cigdlyfu,cigfrequency.cigdlmfu
from cigfrequency,cigestimate
where cigdlyfu in (2012,2013,2014)
AND cigdlmfu <=12 
AND CIGESTIMATE.CIGREC IN (1,2);

--If the first cig smoked year and month responses is less than the last cig smoke
time then that person is non smoker else smoker.

DROP TABLE IF EXISTS QUEST3;
CREATE TABLE IF NOT EXISTS QUEST3
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/Quest3'
AS
select *,
case 
when cigdlyfu=2012 or cigdlyfu=2013 or cigdlyfu=2014 And cigrec=1 then 'SMOKER'
when CIGDLMFU=12 And cigrec =1 THEN 'SMOKER'
when cigdlyfu=2012 or cigdlyfu=2013 or cigdlyfu=2014 and cigrec=2 THEN 'NONSMOKER'
when cigdlmfu=12 and cigrec =2 THEN 'NONSMOKER'
END
from question3;



4)MOST FRQUENTLY UsED CIG BRANDs IN A MONTH 
Grouping all light,ultra light,medium and flavoured brands.


DROP TABLE IF EXISTS QUESTION4;
CREATE TABLE IF NOT EXISTS QUESTION4
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/Question4'
AS
select questid,brandmostused,30daybrand,
case 
when 30daybrand=1 then 'Light brand' 
when 30daybrand=2 then 'Ultra light'
when 30daybrand=3 then 'Medium'
when 30daybrand=4 then 'full flavoured'
end
from cigbrand
where brandmostused NOT IN (9991,9993,9998,9997,9994)
AND 30daybrand NOT IN (91,94,97,98,93)
group by brandmostused,30daybrand,QUESTID;

5)-- People who take only cocaine but not alcohol in past 12 months.

CREATE TABLE only_cocaine
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/result1'
AS
select c.caseid,c.questid2,c.COCYRTOT 
from cocaine c full outer join alcohol a 
on(c.questid2=a.questid2) 
where a.alcyrtot is NULL and c.cocever=1 and c.COCYRTOT<993;


6)--Interest of people in alcohol

CREATE TABLE Alcoholic_range
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
STORED AS TEXTFILE LOCATION '/user/pattima/drug/result2'
AS
select *,alctry AS alcoholic_range, 
IF((alctry) > 50, 'Shows More interest',
IF((alctry) < 50, 'Common Interest', IF((alctry)=994,'No interest','Dont know'))) As Interest_Level,
IF((alcrec) = 1, 'Drank within month', 
IF((alcrec) >2, 'Drank 12 months ago',0)) AS Last_Drank
from alcohol; 



7)--Reasons for not taking heroine

hive>CREATE TABLE Heroine_reasons
    >ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
    >STORED AS TEXTFILE LOCATION '/user/pattima/drug/result3'
    >AS
    >SELECT *,IF((hrdaypmo)<20,'Teenagers',IF((hrdaypmo)>20,'Adults','0')) As Age_of_ppl,
    >IF((HRDAYPWK=91),'not even a week','1 week') As No_of_days_per_week,
    >CASE 
    >WHEN HERYRTOT=997 THEN 'refused'
    >WHEN HERYRTOT=991 THEN 'hate heroine'
    >ELSE 'Dont Know'
    >END AS Reason
    >FROM heroine;

8)Who are the frequent users of heroin
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





