select nname,agentid,concat(datepart(week,answeredtimeUTC),
 datepart(YY,answeredtimeUTC)) AS WeekNo,convert(date,answeredtimeUTC) AS AnsweredDate,convert(time,cansweredtimeUTC) AS AnsweredTime ,(CASE 
 when '01:00'<convert(time,answeredtimeUTC) and convert(time,answeredtimeUTC)<'09:00' then 'Early Morning'
 when '09:01:00'<convert(time,answeredtimeUTC) and convert(time,answeredtimeUTC)<'12:00' then 'Late Morning'
 when '12:01:00'<convert(time,answeredtimeUTC) and convert(time,answeredtimeUTC)<'15:00' then 'Early Afternoon'
 when '15:01:00'<convert(time,answeredtimeUTC) and convert(time,answeredtimeUTC)<'18:00' then 'Late Afternoon'
 else 'Evening' end ) AS Zone
from CallHistoryView
where Sales=1  
group by nname,agentid,answeredtimeUTC
	  

