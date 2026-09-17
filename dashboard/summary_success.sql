SELECT COUNT(*) FILTER (WHERE result = 'PASS') * 100.0 / COUNT(*) AS success_rate
FROM checks_dq
WHERE $__timeFilter(date)