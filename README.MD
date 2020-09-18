# Migrate data from one column to another

## Why

Example: The transactionId in a service seems increasing and during test there was out of range exception.

## How to run migration

The script to update in batches is committed via flyway already.
Just run `docker-compose up --build` to run the migration.


## Configurations FYI

`.env` File - Customize the values.

`pgpass.conf` File - Please provide the "_hostname:db_name:user:password_" and do not commit. 

`sql_function.sql` File - Needs to be commited to the database.
