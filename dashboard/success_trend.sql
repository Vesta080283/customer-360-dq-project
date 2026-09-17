SELECT date, avg(cast(metric_value as decimal))
FROM checks_dq
GROUP BY date ORDER BY date
