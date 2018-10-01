view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

#   measure: city {
#     type: string
#     sql: ${TABLE}.city ;;
#   }

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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    suggestable: no
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: dynamic_dim {
    type: string
    sql: ${TABLE}.{% parameter dynamic_param_1  %} ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: firstdate {
    type: date
    sql: min(${created_test_date}) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

#   measure: count_orders {
#     type: number
#     sql: ${orders.count} ;;
#   }

  parameter: field {
    type: date
  }

  dimension: testing {
    type:  yesno
    sql: DATEDIFF('day', {% parameter field %}, ${created_test_date}) = 7 ;;
  }

  measure: count_test {
    type: count
    drill_fields: [detail*]
    filters: {
      field: testing
      value: "Yes"
    }
  }

#   parameter: dynamic_param_1 {
#     type: unquoted
#     allowed_value: {
#       label: "Gender"
#       value: "gender"
#     }
#
#     allowed_value: {
#       label: "State"
#       value: "state"
#     }
#
#     allowed_value: {
#       label: "Country"
#       value: "country"
#     }
#   }

  parameter: dynamic_param_1 {
    type: unquoted
    suggest_dimension: state
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
