include: "users.view.lkml"

view: extended_view{
  sql_table_name: demo_db.users ;;

  extends: [users]

#   dimension: country {
#     type: string
#     map_layer_name: countries
#     hidden: yes
#     sql: ${TABLE}.country ;;
#   }

  dimension: country {

    hidden: yes
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
