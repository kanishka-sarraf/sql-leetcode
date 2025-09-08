# Write your MySQL query statement below
with borrowers_count as (
    select book_id, count(*) as current_borrowers
    from borrowing_records
    where return_date is null
    group by book_id
)
select lb.book_id, lb.title, lb.author, lb.genre, lb.publication_year, bc.current_borrowers
from library_books lb
join borrowers_count bc on lb.book_id = bc.book_id 
                            and lb.total_copies = bc.current_borrowers
order by bc.current_borrowers desc, lb.title asc;