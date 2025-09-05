# Write your MySQL query statement below
delete from person 
where id not in(select id from (
    select 
        id, email,
        row_number() over(partition by email order by id asc) as rnk
    from person
) t
where t.rnk = 1);


/*
delete from person p1
where p1.id != (select min(id)
                from person p2
                where p2.email = p1.email);
*/
