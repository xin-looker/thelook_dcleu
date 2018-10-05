view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: yesnovalue {
    type: yesno
    sql: case when ${age}>30 then yes else no end ;;
    can_filter: no
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
      day_of_month,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

#   dimension: days_per_month {
#     type: number
#     sql: case when ${created_test_month_name} in  ("January", "March", "May", "July", "August", "October", "December"
#     then 31 else 30 end;;
#   }

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
    link: {
      label:"New York"
      url:"{{users.url_test._value}}"
    }
  }

  dimension: url_test {
    type: string
    sql: case when ${state}="New York" then "https://dcleu.eu.looker.com/dashboards/24" end ;;
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

  dimension: adam {
    type: string
    sql: case when ${email} like "adam%" then ${first_name} end;;
  }

#   dimension: adam {
#     type: string
#     sql: (SELECT ${TABLE}.first_name FROM );;
#   }

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
