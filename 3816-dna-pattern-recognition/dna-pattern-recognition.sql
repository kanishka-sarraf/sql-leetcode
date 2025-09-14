# Write your MySQL query statement below
select *,
-- case when dna_sequence like 'ATG%' then 1 else 0 end as has_start,
case when regexp_like(dna_sequence,'^ATG') then 1 else 0 end as has_start,
case when regexp_like(dna_sequence,'(TAA|TAG|TGA)$') then 1 else 0 end as has_stop,
case when regexp_like(dna_sequence,'ATAT') then 1 else 0 end as has_atat,
case when regexp_like(dna_sequence,'G{3,}') then 1 else 0 end as has_ggg
from samples;