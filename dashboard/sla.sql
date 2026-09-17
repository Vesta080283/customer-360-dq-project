WITH ordered AS ( 
SELECT 
table_name,  
check_name,  
result,  
date, 
MIN(CASE WHEN result = 'PASS' THEN date END) OVER ( 
PARTITION BY table_name, check_name  
ORDER BY date 
ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING 
) AS fixed_at 
FROM checks_dq 
	) 
SELECT 
ROUND(AVG(EXTRACT(EPOCH FROM (fixed_at - date)) / 3600)::numeric, 2) AS mttr_hours, 
ROUND(COUNT(*) FILTER (WHERE EXTRACT(EPOCH FROM (fixed_at - date)) / 3600 <= 24) * 100.0 / COUNT(*), 2) AS sla_24h_pct 
FROM ordered 
WHERE result = 'FAIL' AND fixed_at IS NOT NULL;
