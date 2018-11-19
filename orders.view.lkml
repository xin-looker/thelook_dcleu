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

  dimension_group: created_1 {
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

  filter: date_picker_template {
    type: date
    label: "Date Picker_template"
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
      value: "0 day from now for 10 days"
    }
  }

  measure: normal_count {
    type: count
  }

  measure: normal_percentile {
    type: number
    sql: ntile(20) over ${normal_count} order by ${normal_count} ;;
  }

  dimension: full_calendar {
    type: date
    sql:  {{date_picker_template._value}};;
  }

  dimension: created_date_everyday {
    type: date
    sql: {% parameter date_picker %} ;;
  }

  measure: increase_last_quarter {
    type: count
    filters:{
      field: created_quarter
      value: "this quarter"
    }
  }

  measure: target {
    type: count
    sql: case when ${created_date}<now() then ${id} else ${count}+12*${created_date};;
  }

  dimension: report_start {
    type: date_time
    sql: ${created_month} ;;
  }

  dimension: count1 {
    type: number
    sql: count(${id}) ;;
  }

  dimension: report_finish {
    type: date_time
    sql: ${created_month} ;;
  }
}
