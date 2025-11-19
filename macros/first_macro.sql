{% macro jodo(col1,col2) %}
    {{col1}} || ' ' || {{col2}}
{% endmacro %}

{% macro momo(col1,col2) %}
    {{col1}} || ' ' || {{col2}}
{% endmacro %}

{% macro employee() %}

    {% set results = run_query("select employee_name from " ~ ref('stg_employees1')) %}
    {% if execute %}
        {% for row in results.rows %}
            {{ print(row[0]) }}
        {% endfor %}
    {% endif %}
{% endmacro %}


{% macro format_phone(phone) %}
    case
        when {{ phone }} is null then 'N/A'
        else
            '(' || substr({{ phone }}::string, 1, 3) || ') '
                 || substr({{ phone }}::string, 4, 3) || '-'
                 || substr({{ phone }}::string, 7, 4)
    end
{% endmacro %}

{% macro date_to_key(date_column) %}
    to_char({{ date_column }}, 'YYYYMMDD')::number
{% endmacro %}

{% macro gender_full(gender) %}
    case
        when {{ gender }} = 'M' then 'Male'
        when {{ gender }} = 'F' then 'Female'
        else 'Other'
    end
{% endmacro %}



{% macro age_group(age) %}
    case
        when {{ age }} < 35 then 'YOUNGSTER'
        when {{ age }} < 60 then 'MIDDLE AGED'
        else 'SENIOR'
    end
{% endmacro %}


{% macro unload() %}

    {% do run_query("CREATE OR REPLACE STAGE analytics_stage") %}

    {% do run_query("
        COPY INTO @analytics_stage/nations/
        FROM stg_nations
        PARTITION BY (region_id)
        FILE_FORMAT = (TYPE = CSV COMPRESSION = NONE NULL_IF=(' '))
        HEADER = TRUE
    ") %}

{% endmacro %}
