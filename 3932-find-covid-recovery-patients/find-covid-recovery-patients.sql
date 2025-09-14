# Write your MySQL query statement below
/*
-- not working for cases when test results are positive - negative - negative 
with recovery_details as (
    select 
        patient_id,
        min(case when result = 'Positive' then test_date else null end)as positive_date,
        max(case when result = 'Negative' then test_date else null end) as negative_date
    from covid_tests
    group by patient_id
    having positive_date < negative_date
)
select 
    p.*, 
    datediff(rd.negative_date, rd.positive_date) as recovery_time 
from recovery_details rd
join patients p on rd.patient_id = p.patient_id
where rd.positive_date is not null and rd.negative_date is not null
order by recovery_time asc, p.patient_name asc;
*/


select 
    p.*, 
    datediff(min(ct2.test_date), min(ct1.test_date)) as recovery_time 
-- min(ct1.test_date) as positive_date, min(ct2.test_date) as negative_date
from covid_tests ct1
join covid_tests ct2 on ct1.patient_id = ct2.patient_id 
                        and ct1.result = 'Positive' 
                        and ct2.result = 'Negative' 
                        and ct1.test_date < ct2.test_date
join patients p on ct1.patient_id = p.patient_id
group by ct1.patient_id
order by recovery_time asc, p.patient_name asc;