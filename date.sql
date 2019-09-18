select campaignname,agentid,concat(datepart(week,callansweredtimeUTC),
 datepart(YY,callansweredtimeUTC)) AS WeekNo,convert(date,callansweredtimeUTC) AS AnsweredDate,convert(time,callansweredtimeUTC) AS AnsweredTime ,(CASE 
 when '01:00'<convert(time,callansweredtimeUTC) and convert(time,callansweredtimeUTC)<'09:00' then 'Early Morning'
 when '09:01:00'<convert(time,callansweredtimeUTC) and convert(time,callansweredtimeUTC)<'12:00' then 'Late Morning'
 when '12:01:00'<convert(time,callansweredtimeUTC) and convert(time,callansweredtimeUTC)<'15:00' then 'Early Afternoon'
 when '15:01:00'<convert(time,callansweredtimeUTC) and convert(time,callansweredtimeUTC)<'18:00' then 'Late Afternoon'
 else 'Evening' end ) AS Zone
from CallHistoryView
where Sales=1  
group by campaignname,agentid,callansweredtimeUTC
	  

