SELECT
table_name,
ROUND(COUNT(*) FILTER (WHERE result = 'PASS') * 100.0 / COUNT(*), 2) AS dq_score,
CASE WHEN COUNT(*) FILTER (WHERE result = 'PASS') * 100.0 / COUNT(*) >= 95
THEN 'YES' ELSE 'NO' END AS is_quality
FROM checks_dq
WHERE $__timeFilter(date)
GROUP BY table_name
ORDER BY dq_score