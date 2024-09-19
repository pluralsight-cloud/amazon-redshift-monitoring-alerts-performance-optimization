create procedure create_fibonacci_table()
as $$
    begin
        create table my_fibonacci_table (
            id integer,
            fib_value integer
        );
    end;
$$ language plpgsql;

call create_fibonacci_table();

create procedure insert_fibonacci_numbers(number_of_fib_numbers integer)
as $$
    begin
        insert into my_fibonacci_table (id, fib_value)
        values (1, 0), (2, 1);
        for i in 3..number_of_fib_numbers loop
            insert into my_fibonacci_table (id, fib_value)
            values (i, 
                (select fib_value from my_fibonacci_table where id = i - 1) + 
                (select fib_value from my_fibonacci_table where id = i - 2)
            );
        end loop;
    end;
$$ language plpgsql;


call insert_fibonacci_numbers(20);

select * from my_fibonacci_table;

select count(*) from my_fibonacci_table;
