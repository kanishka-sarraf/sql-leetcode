# Write your MySQL query statement below
with score_details as (
    select *,
        first_value(score) over w as first_score,
        last_value(score) over w as latest_score
    from scores
    window w as (partition by student_id, subject 
                    order by exam_date asc 
                        rows between unbounded preceding and unbounded following)
)
select student_id, subject, first_score, latest_score
from score_details
group by student_id, subject
having count(*)>=2 and latest_score > first_score
order by student_id, subject; 