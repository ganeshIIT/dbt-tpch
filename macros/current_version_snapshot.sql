{% macro current_version_snapshot(ss_ref, output_load_ts = true) %}

SELECT
    * EXCLUDE (DBT_SCD_ID, DBT_VALID_FROM, DBT_VALID_TO, DBT_UPDATED_AT)
    {% if output_load_ts %}, DBT_UPDATED_AT as SS_LOAD_TS_UTC {% endif%}
FROM {{ ss_ref }}
WHERE DBT_VALID_TO is null

{% endmacro %}