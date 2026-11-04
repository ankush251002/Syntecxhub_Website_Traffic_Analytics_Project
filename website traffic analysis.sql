use website_traffic_db;
describe traffic_data;

SELECT * FROM traffic_data
LIMIT 5;

SELECT 
    COUNT(*) - COUNT(session_primary_channel_group) AS session_channel_nulls,
    COUNT(*) - COUNT(date_hour) AS date_hour_nulls,
    COUNT(*) - COUNT(users) AS users_nulls,
    COUNT(*) - COUNT(sessions) AS sessions_nulls,
    COUNT(*) - COUNT(engaged_sessions) AS engaged_sessions_nulls,
    COUNT(*) - COUNT(average_engagement_time_per_session) AS avg_engagement_time_nulls,
    COUNT(*) - COUNT(engaged_sessions_per_user) AS engaged_sessions_per_user_nulls,
    COUNT(*) - COUNT(events_per_session) AS events_per_session_nulls,
    COUNT(*) - COUNT(engagement_rate) AS engagement_rate_nulls,
    COUNT(*) - COUNT(event_count) AS event_count_nulls
FROM traffic_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE traffic_data
SET session_primary_channel_group = TRIM(session_primary_channel_group)
where session_primary_channel_group is not null;

select * from traffic_data limit 5;

ALTER TABLE traffic_data
RENAME COLUMN `session_primary_channel_group_(default_channel_group)`
TO session_primary_channel_group;

ALTER TABLE traffic_data 
ADD COLUMN formatted_date DATE,
ADD COLUMN hour_of_day INT,
ADD COLUMN day_name VARCHAR(15);

ALTER TABLE traffic_data
RENAME COLUMN `date_+_hour_(yyyymmddhh)` TO date_hour;

UPDATE traffic_data
set formatted_date = STR_TO_DATE(LEFT(date_hour, 8), '%Y%m%d')
    hour_of_day = CAST(RIGHT(date_hour, 2) AS UNSIGNED),
    day_name = DAYNAME(STR_TO_DATE(LEFT(date_hour, 8), '%Y%m%d'));

SELECT 
    SUM(users) AS total_users,
    SUM(sessions) AS total_sessions,
    ROUND(AVG(engagement_rate) * 100, 2) AS overall_engagement_rate_pct
FROM traffic_data;

SELECT 
    session_primary_channel_group,
    SUM(users) AS total_users,
    SUM(sessions) AS total_sessions,
    ROUND(AVG(engagement_rate), 2) AS avg_engagement_rate
FROM traffic_data
GROUP BY session_primary_channel_group
ORDER BY total_users DESC;

Select
    hour_of_day,
    SUM(users) AS total_users,
    SUM(sessions) AS total_sessions
FROM traffic_data
GROUP BY hour_of_day
ORDER BY total_users DESC;

WITH RankedTraffic AS (
    Select 
        session_primary_channel_group,
        hour_of_day,
        SUM(users) AS total_users,
        DENSE_RANK() OVER (PARTITION BY session_primary_channel_group ORDER BY SUM(users) DESC) AS rank_num
    FROM traffic_data
    GROUP BY session_primary_channel_group, hour_of_day
)
SELECT session_primary_channel_group, hour_of_day, total_users
FROM RankedTraffic
WHERE rank_num = 1;

select * from traffic_data;