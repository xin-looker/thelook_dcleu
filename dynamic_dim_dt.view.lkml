view: dynamic_dim_dt {
  derived_table: {
    sql: SELECT users.id as `id`,
  COUNT(*) AS `count_dt`
  FROM demo_db.{% parameter users.dynamic_param_1 %}  AS users
  GROUP BY 1
  ORDER BY COUNT(*) DESC;;
  }

#   parameter: dynamic_param_2 {
#     type: unquoted
#     allowed_value: {
#       label: "Gender"
#       value: "gender"
#     }
#     allowed_value: {
#       label: "State"
#       value: "state"
#     }
#     allowed_value: {
#       label: "Country"
#       value: "country"
#     }
#   }

  parameter: dynamic_param_2 {
    type: unquoted
    suggest_dimension: id
#     suggest_explore: users
  }

  dimension: dynamic_2 {
    type: string
    sql: users.{% parameter dynamic_2 %} ;;
  }

  dimension: dynamic {
    type: string
    sql: ${TABLE}.`dynamic_dim` ;;
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.`id` ;;
  }

  dimension: count_dt {
    type: number
    sql: ${TABLE}.`count_dt` ;;
  }

  measure: count {
    type: count
  }

 }
