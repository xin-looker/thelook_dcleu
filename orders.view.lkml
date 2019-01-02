view: orders {
#   sql_table_name: demo_db.orders ;;

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
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: yes
  }

  dimension: test_datetime {
    type: date_time
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

#   measure: count {
#     type: number
#     drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
#     sql: COALESCE(count(${user_id}),0) ;;
#   }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
#     sql: COALESCE(count(${user_id}),0) ;;
  }

  measure: count_order_with_sum_distinct {
    type: sum_distinct
    sql_distinct_key: ${id} ;;
    sql: ${user_id} ;;
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

  dimension: report_finish {
    type: date_time
    sql: ${created_month} ;;
  }


  # create a dimension combines MoM, YoY and WoW

  measure: count_this_month {
    type: count
    filters: {
      field: created_month
      value: "this month"
    }
  }

  measure: count_last_month {
    type: count
    filters: {
      field: created_month
      value: "last month"
    }
  }

  measure: count_2018 {
    type: count
    filters: {
      field: created_year
      value: "2018"
    }
  }

  measure: count_2017 {
    type: count
    filters: {
      field: created_year
      value: "2017"
    }
  }

  measure: count_this_week{
    type: count
    filters: {
      field: created_week
      value: "this week"
    }
  }

  measure: count_last_week {
    type: count
    filters: {
      field: created_week
      value: "last week"
    }
  }

  measure: yoy_delta {
    type: number
    sql: (${count_2018}-${count_2017})/${count_2017} ;;
    value_format_name: percent_2
  }

  measure: mom_delta {
    type: number
    sql: (${count_this_month}-${count_last_month})/${count_last_month} ;;
    value_format_name: percent_2
  }

  measure: wow_delta {
    type: number
    sql: (${count_this_week}-${count_last_week})/${count_last_week} ;;
    value_format_name: percent_2
  }

   #transpose measure for yoy, mom and wow
  dimension: delta {
    case: {
      when: {
        label: "yoy"
        sql: 1=1 ;;
      }

      when: {
        label: "mom"
        sql: 1=1 ;;
      }

      when: {
        label: "wow"
        sql: 1=1 ;;
      }
    }
  }
}
