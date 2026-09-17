SELECT date, check_name, table_name, check_type, metric_value, metric_unit
 FROM checks_dq
  WHERE result = 'FAIL' 
  ORDER BY date, check_name, table_name, check_type, metric_value ASC
  LIMIT 10