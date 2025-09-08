# Write your MySQL query statement below
with session_details as (
    select 
        book_id, 
        count(session_id) as total_session,
        count(case when session_rating >= 4 then 1 else null end) as high_rating_sessions,
        count(case when session_rating <= 2 then 1 else null end) as low_rating_sessions,
        max(session_rating) as highest_rating,
        min(session_rating) as lowest_rating
    from reading_sessions
    group by book_id
    having total_session >= 5 and high_rating_sessions >= 1 and low_rating_sessions >= 1
),
polarization_details as (
    select b.*, 
        highest_rating - lowest_rating as rating_spread,
        round((high_rating_sessions + low_rating_sessions ) / total_session,2) as polarization_score
    from session_details s
    join books b on s.book_id = b.book_id
)
select * 
from polarization_details
where polarization_score >= 0.6
order by polarization_score desc, title desc;
