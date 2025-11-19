with nation_info as (
    select 
        n.name as n_name,
        n.region_id as n_regionid,
        n.nation_id,
        r.comment as r_comment,
        n.comment as n_comment,
        r.region_id,
        r.name as r_name
    from {{ ref('stg_nations') }} n
    join {{ ref('stg_regions') }} r
        on n.region_id = r.region_id
)

select * 
from nation_info
