[FAILED] NOT_NULL (TotalCharges)
check_value: 19
Samples: [" ", " ", " "] ... [всего 19]
Impact: ETL пайплайн упадет при попытке cast к float. LTV-отчетность искажена.

[FAILED] DUPLICATE_ROW_COUNT
check_value: 41
Impact: Смещение метрик Churn Rate. Дублирующий профиль получает двойную нагрузку маркетинговых коммуникаций.

[FAILED] SCHEMA_TYPE (TotalCharges)
check_value: 21 failures
Samples: ["Invalid", " "]
Impact: Нарушение Data Contract. Потребитель данных (BI-дашборд) получит ошибку визуализации.

[FAILED] EXPRESSION (Tenure vs Charges)
check_expr: tenure == 0 AND TotalCharges != ' '
failures: 7
Impact: Риск неверного расчета юнит-экономики. Новые клиенты выглядят платящими.