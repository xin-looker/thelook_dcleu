view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
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
    convert_tz: no
  }

  parameter: date_picker {
    type: date
    label: "Date Picker"
    suggest_dimension: created_date
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: number
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
    sql: COALESCE(count(${user_id}),0) ;;
  }

  measure: count_filtered {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
    filters: {
      field: created_date
      value: "5 days"
    }
  }

  measure: increase_last_quarter {
    type: count
    filters:{
      field: created_quarter
      value: "this quarter"
    }
  }

  dimension: report_start {
    type: date_time
    sql: ${created_month} ;;
  }

  dimension: report_finish {
    type: date_time
    sql: ${created_month} ;;
  }
}
