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