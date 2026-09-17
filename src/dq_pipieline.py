import pandas as pd
import logging
from datetime import datetime

logging.basicConfig(filename='logs/dq_run.log', level=logging.INFO)

def run_customer_profile_checks(df: pd.DataFrame):
    results = {}
    
    # Проверка дубликатов по телефону
    phone_duplicates = df[df.duplicated(subset=['phone'], keep=False)]
    results['phone_duplicates'] = len(phone_duplicates)
    
    # Проверка формата email
    valid_email_mask = df['email'].str.contains(r'^[^@]+@[^@]+\.[^@]+')
    results['invalid_emails'] = df.shape[0] - valid_email_mask.sum()
    
    # Проверка аномалий возраста
    results['age_anomalies'] = ((df['age'] < 10) | (df['age'] > 120)).sum()
    
    log_results(results)
    return results

def log_results(res: dict):
    timestamp = datetime.now().isoformat()
    status = "SUCCESS" if all(v==0 for v in res.values()) else "FAILURE"
    logging.info(f"{timestamp} | Status: {status} | Metrics: {res}")