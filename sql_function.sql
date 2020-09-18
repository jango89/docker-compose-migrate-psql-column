SET SCHEMA 'commonsarvatobig';

CREATE OR REPLACE FUNCTION migrate_transaction_id_to_new_transaction_id_column(start_val integer, batch_count integer)
    RETURNS void
    language plpgsql
as
$$
declare
    row_count_affected integer;
    end_val            integer := start_val + batch_count;
BEGIN

    RAISE NOTICE 'Starting the migration from id = % to id = % ', start_val, end_val;

    LOOP

        update yourbb.score_check_response
        set new_transaction_id=transaction_id
        where new_transaction_id is null
          and transaction_id is not null
          and id >= start_val and id <= end_val;

        GET DIAGNOSTICS row_count_affected = ROW_COUNT;

        RAISE NOTICE 'The rows affected = % for ids from % to %', row_count_affected, start_val, end_val;

        -- Exit condition
        if row_count_affected < 1 then
            RAISE NOTICE 'Ending the migration successfully.';
            return;
        end if;

        start_val = start_val + batch_count;
        end_val = end_val + batch_count;

    END LOOP;
END
$$
