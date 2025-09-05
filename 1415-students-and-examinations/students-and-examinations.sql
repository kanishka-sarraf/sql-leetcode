# Write your MySQL query statement below
select 
    s.student_id, 
    s.student_name, 
    s.subject_name, 
    count(e.student_id) as attended_exams 
from (select *
      from students, subjects) s
left join examinations e 
          on s.student_id = e.student_id 
              and s.subject_name = e.subject_name
group by s.student_id, s.student_name, s.subject_name
order by s.student_id, s.subject_name;
