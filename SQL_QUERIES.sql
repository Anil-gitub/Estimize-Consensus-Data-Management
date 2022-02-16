-- Table creation and table structures
-- ----------------------------------------------------------------------------------------------------------------------------
create table analyst_data (
analyst_name	 varchar(200),
User_Name	varchar(200),
Role	varchar(200),
Join_Date	DATE,
Analyst_Confidence	decimal(5,2),
Error_Rate decimal(5,2),
Accuracy_Percentile decimal(5,2),
Points INT,
Points_Estimate decimal(5,2),
Stocks INT,
Pending_Estimates INT
);
-- truncate table analyst_data
select * from analyst_data;

create table eps_data (
ID	integer,
Ticker_name	varchar(200),
reported_earnings	decimal(5,2),
estimiza_consensus	decimal(5,2),
estimized_mean	decimal(5,2),
Wall_street_consensus	decimal(5,2),
user_name	varchar(200),
final_username	varchar(200),
eps_value decimal(5,2)
);

create table ticker_data (
Ticker	 varchar(200),
Company_name	varchar(200),
sector_name	varchar(200),
Industries	varchar(200),
followers	varchar(200),
analysts varchar(200)
);

ALTER TABLE ticker_data
ADD PRIMARY KEY (ticker);

ALTER TABLE eps_data
ADD PRIMARY KEY (ticker_name,user_name);

ALTER TABLE analyst_data
ADD PRIMARY KEY (analyst_name);

create table scored_estimates (
name	varchar(200),
userName	varchar(200),
ticker	varchar(100),
quarter	varchar(200),
reported	varchar(200),
ranks	varchar(20),
epsPoints	decimal(5,2),
revenuePoints decimal(5,2),	
totalPoints decimal(5,2)
);

create table pending_estimates (
name	varchar(200),
userName	varchar(200),
ticker	varchar(100),
quarter	varchar(200),
reported	varchar(200),
published	varchar(20),
epsPoints	decimal(5,2),
revenuePoints decimal(5,2)
);

create table stocks_covered (
name	varchar(200),
userName	varchar(200),
ticker	varchar(100),
reports	varchar(200),
quarter	varchar(200),
points	decimal(5,2),
pointsPerEstimate	decimal(5,2),
errorRate	decimal(5,2),
accuracy decimal(5,2)
)
;
ALTER TABLE pending_estimates 
ADD PRIMARY KEY (userName,quarter,ticker);

ALTER TABLE scored_estimates
ADD PRIMARY KEY (userName,quarter);

truncate table stocks_covered;

ALTER TABLE stocks_covered
ADD PRIMARY KEY (userName,quarter,reports,ticker);
-- --------------------------------------------------SQL QUERIES----------------------------------------------------------------------------
-- Given a ticker, how many analysts have made estimations for its EPS? Rank them
-- by their confidence score, total points, error rate or accuracy percentile? [10%]

select Ticker_name,count(1) as 'Number of Analysts'
from eps_data
group by ticker_name
order by Ticker_name;

select e.ticker_name as 'Ticker',e.eps_value as 'EPS VALUE',e.user_name as 'Analyst Name'
,a.Analyst_Confidence as 'confidence score',a.Points as 'Total Points',a.Error_Rate as 'Error Rate',a.Accuracy_Percentile as 'Accuracy Percentile'
from eps_data e,analyst_data a
where e.final_username=a.User_Name
order by e.ticker_name,a.Analyst_Confidence desc,a.Points desc,a.Error_Rate desc,a.Accuracy_Percentile desc;

--  Given a industry, how many companies are covered, 
--  the average number of analysts, the average bias between the Estimize Consensus and the Reported Earnings

select b.*,c.avg_reported_earnings,c.avg_estimiza_consensus, abs(c.avg_reported_earnings-c.avg_estimiza_consensus) as 'Bias Between Reported and Estimize'
from
(
select Industries,count(1) as 'Companies Covered',round(avg(analysts)) as 'Average Number of Analysts'
from ticker_data 
group by Industries
) b,
(
select t.Industries,avg(a.reported_earnings) avg_reported_earnings,avg(a.estimiza_consensus) avg_estimiza_consensus
from ticker_data t,
(select e.Ticker_name,e.reported_earnings,e.estimiza_consensus
from eps_data e
group by e.Ticker_name) a
where a.Ticker_name=t.Ticker
group by Industries
) c
where b.Industries=c.Industries;

	-- Which company have the largest number of analysts with confidence score greater
	-- than 7?

select e.ticker_name as 'Ticker', count(1) as 'Number of analysts'
from eps_data e,analyst_data a
where e.final_username=a.User_Name and a.Analyst_Confidence>7
group by e.Ticker_name
order by count(1) DESC 
LIMIT 1;

-- Who has the largest number of followers?
select ticker 'Ticker' ,company_name as 'Company Name' , followers as 'Followers'
from ticker_data
order by followers desc
limit 1;
----------------------------------------------------- 
