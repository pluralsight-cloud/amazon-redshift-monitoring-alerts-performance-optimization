-- Look over the users table and current compression settings

select * from pg_table_def where tablename = 'users';

-- Lets see what Redshift says we should be doing
-- Look at compression recommendations for the table

analyze compression users;

-- Let's compare the current compression settings to some others
create table users_phone_encoding_test (
    phoneraw char(14) encode raw,
    phonebytedict char(14) encode bytedict,
    phonelzo char(14) encode lzo,
    phonerunlength char(14) encode runlength,
    phonezstd char(14) encode zstd
);

-- Insert the same data into the new table
-- Run this ~10 times
insert into users_phone_encoding_test
select
    phone as phoneraw,
    phone as phonebytedict,
    phone as phonelzo,
    phone as phonerunlength,
    phone as phonezstd
from users;

-- Check to make sure the data was loaded
select count(*) from users_phone_encoding_test;
-- Should be ~750,000 for it to start showing a difference in next query

-- Check to see which is the most optimial encoding

SELECT col, attname, COUNT(*) AS "mbs"
FROM stv_blocklist bl
JOIN stv_tbl_perm perm
  ON bl.tbl = perm.id AND bl.slice = perm.slice
LEFT JOIN pg_attribute attr ON
  attr.attrelid = bl.tbl
  AND attr.attnum-1 = bl.col
WHERE perm.name = 'users_phone_encoding_test'
  AND col < 5
GROUP BY col, attname
ORDER BY col;

-- shows result like this
-- 0    phoneraw        12
-- 1    phonebytedict   12
-- 2    phonelzo        8
-- 3    phonerunlength  12
-- 4    phonezstd       8

drop table users_phone_encoding_test;
