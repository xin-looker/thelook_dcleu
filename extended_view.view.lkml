include: "base_view.view.lkml"

view: extended_view{
  sql_table_name: demo_db.users ;;

  extends: [base_view]

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created_test {
    alias: [like]
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }
  }
