create user 'dekana'@'localhost';

grant select on belajar_mysql.* to 'dekana'@'localhost';

show grants for 'dekana'@'localhost';

set password for 'dekana'@'localhost' = 'dekana';

-- DROP USER (User)
-- Revoke (Hak Akses) ON (Database) FROM (User)
--  