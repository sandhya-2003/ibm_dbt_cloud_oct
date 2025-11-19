

WITH src AS (
    SELECT * FROM {{ source('src2', 'stg_employees') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY EMP_ID) AS employee_sk,

    EMP_ID AS employee_id,
    FIRSTNAME || ' ' || LASTNAME AS employee_name,

    STREET AS employee_address,
    CITY AS employee_city,
    STATE AS employee_state,
    ZIP AS employee_zip_code,

    MOBILE AS employee_mobile,
    {{ format_phone('FIXED') }} AS employee_fixed_line,

    EMAIL AS employee_email,
    {{ gender_full('GENDER') }} AS employee_gender,
    AGE AS employee_age,
    {{ age_group('AGE') }} AS age_group,

    POSITION AS position_type,
    DEALERSHIP_ID,
    NULL AS dealership_manager,

    SALARY AS employee_salary,
    REGION AS employee_region,

    {{ date_to_key('HIRE_DATE') }} AS hired_date_key,
    {{ date_to_key('DATE_ENTERED') }} AS insert_dk,
    {{ date_to_key('DATE_ENTERED') }} AS update_dk

FROM src
