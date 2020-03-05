SELECT DATEADD(DAY, -5 - (DATEPART(weekday, getdate()) % 7), getdate())
