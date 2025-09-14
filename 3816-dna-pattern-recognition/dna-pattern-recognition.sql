# Write your MySQL query statement below
/*
-- solution1
select *,
case when regexp_like(dna_sequence,'^ATG') then 1 else 0 end as has_start,
case when regexp_like(dna_sequence,'(TAA|TAG|TGA)$') then 1 else 0 end as has_stop,
case when regexp_like(dna_sequence,'ATAT') then 1 else 0 end as has_atat,
case when regexp_like(dna_sequence,'G{3,}') then 1 else 0 end as has_ggg
from samples;
*/

SELECT
    sample_id,
    dna_sequence,
    species,
    
    -- Check start codon (first 3 chars = ATG)
    CASE WHEN LEFT(dna_sequence, 3) = 'ATG' 
         THEN 1 ELSE 0 END AS has_start,
    
    -- Check stop codon (last 3 chars = TAA / TAG / TGA)
    CASE WHEN RIGHT(dna_sequence, 3) IN ('TAA','TAG','TGA')
         THEN 1 ELSE 0 END AS has_stop,
    
    -- Check substring "ATAT"
    CASE WHEN dna_sequence LIKE '%ATAT%'
         THEN 1 ELSE 0 END AS has_atat,
    
    -- Check substring "ggg" (case-sensitive unless collation is case-insensitive)
    CASE WHEN dna_sequence LIKE '%ggg%'
         THEN 1 ELSE 0 END AS has_ggg

FROM Samples;