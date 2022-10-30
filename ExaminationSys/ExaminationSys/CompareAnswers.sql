--calc Distance between two strings
CREATE or alter FUNCTION CompareAnswer (
        -- Add the parameters for the function here
        @name_1 varchar(255),@name_2 varchar(255)
    )
    RETURNS float
    AS
    BEGIN
        

-- Declare the return variable and any needed variable here
    declare @p int = 0;
    declare @c int = 0;
    declare @br int = 0;
    declare @p_temp int = 0;
    declare @emergency_stop int = 0;
    declare @fixer int = 0;
    declare @table1_temp table (
    row_id int identity(1,1),
    str1 varchar (255));
    declare @table2_temp table (
    row_Id int identity(1,1),
    str2 varchar (255));
    declare @n int = 1;
    declare @count int = 1;
    declare @result int = 0;
    declare @total_result float = 0;
    declare @result_temp int = 0;
    declare @variable float = 0.0;
    
--clean the two strings from unwanted symbols and numbers

    set @name_1 = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@name_1,'!',''),'  ',' '),'1',''),'2',''),'3',''),'4',''),'5',''),'0',''),'6',''),'7',''),'8',''),'9','');
    set @name_2 = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@name_2,'!',''),'  ',' '),'1',''),'2',''),'3',''),'4',''),'5',''),'0',''),'6',''),'7',''),'8',''),'9','');

--check if the first string has more than one words inside. If the string does 
--not have more than one words, return 100%
set @c = charindex(' ',substring(@name_1,@p,len(@name_1)));


IF(@c = 0)
BEGIN
RETURN 100.00
END;

--main logic of the operation. This is based on sound indexing and comparing the 
--outcome. This loops through the string whole words and determines their soundex
--code and then compares it one against the other to produce a definitive number --showing the raw match between the two strings @name_1 and @name_2.
WHILE (@br != 2 or @emergency_stop = 20)
BEGIN

insert into @table1_temp(str1)
select substring (@name_1,@p,@c);
set @p = len(substring (@name_1,@p,@c))+2;
set @p = @p + @p_temp - @fixer;
set @p_temp = @p;
set @c = CASE WHEN charindex(' ',substring(@name_1,@p,len(@name_1))) = 0 THEN len(@name_1) ELSE charindex(' ',substring(@name_1,@p,len(@name_1))) END;
set @fixer = 1;
set @br = CASE WHEN charindex(' ',substring(@name_1,@p,len(@name_1))) = 0 THEN @br + 1 ELSE 0 END;
set @emergency_stop = @emergency_stop +1;
END;

set @p = 0;
set @br = 0;
set @emergency_stop = 0;
set @fixer = 0;
set @p_temp = 0;
set @c = charindex(' ',substring(@name_2,@p,len(@name_2)));

WHILE (@br != 2 or @emergency_stop = 20)
BEGIN

insert into @table2_temp(str2)
select substring (@name_2,@p,@c);
set @p = len(substring (@name_2,@p,@c))+2;
set @p = @p + @p_temp - @fixer;
set @p_temp = @p;
set @c = CASE WHEN charindex(' ',substring(@name_2,@p,len(@name_2))) = 0 THEN len(@name_2) ELSE charindex(' ',substring(@name_2,@p,len(@name_2))) END;
set @fixer = 1;
set @br = CASE WHEN charindex(' ',substring(@name_2,@p,len(@name_2))) = 0 THEN @br + 1 ELSE 0 END;
set @emergency_stop = @emergency_stop +1;
END;

WHILE((select str1 from @table1_temp where row_id = @n) is not null)
BEGIN
    set @count = 1;
    set @result = 0;
    WHILE((select str2 from @table2_temp where row_id = @count) is not null)
    BEGIN
        set @result_temp = DIFFERENCE((select str1 from @table1_temp where row_id = @n),(select str2 from @table2_temp where row_id = @count));
        IF(@result_temp > @result)
            BEGIN
                set @result = @result_temp;
                
            END;
            
        set @count = @count + 1;         
    END;
    
    set @total_result = @total_result + @result;
    set @n = @n + 1;
END;

--gather the results and transform them in a percent match.
set @variable = (select @total_result / (select max(row_count) from (
select max(row_id) as row_count from @table1_temp
union
select max(row_id) as row_count from @table2_temp) a));
RETURN FORMAT(@variable/4 * 100, 'N2');

END

select dbo.CompareAnswer ('mohamed ali hussein', 'omar khalid Mohamed')

select dbo.CompareAnswer ('mohamed ali hussein', 'Mohamed')