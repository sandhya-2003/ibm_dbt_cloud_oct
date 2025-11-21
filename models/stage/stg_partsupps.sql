WITH source AS (
    SELECT * FROM {{ source('src', 'partsupps') }}
),
changed AS (
    SELECT


        {{ dbt_utils.generate_surrogate_key(['ps_partkey','ps_suppkey']) }} part_supplier_id,
        ps_partkey AS part_id,
        ps_suppkey AS supplier_id,
        ps_comment AS comment,
        ps_availqty AS available_quantity,
        ps_supplycost AS cost
    FROM source
)
SELECT * FROM changed
