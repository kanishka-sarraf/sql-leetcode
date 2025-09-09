CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      select distinct salary from (
        select *, dense_rank() over(order by salary desc) as rnk
        from employee
        ) t 
        where t.rnk = N
  );
END 

-- select getNthHighestSalary(2);