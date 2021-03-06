view: orders {
#   sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    label: "created_test"
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
#     convert_tz: no
  }

  measure: min_time {
    type: date_time
    sql: min(${created_time}) ;;
  }

  dimension: casewhentest {
    case: {
      when: {
        label: "hey"
        sql: id=1 ;;
      }
      when: {
        label: "heyhey"
        sql: id=2 ;;
      }
      else: ""
    }
  }

  parameter: range_start {
    type: date
    required_fields: [14days_range]
  }

  filter: 14days_range {
    type: yesno
    sql: ${created_date}<={{range_start._parameter_value}} AND ${created_date} > date_add({{ range_start._parameter_value }}, interval -14 day) ;;
  }

  dimension: test_datetime {
    type: date_time
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension: user_id_render {
    type: number
    sql: ${TABLE}.id ;;
#     html: <span title="This is {{users.count}}">{{rendered_value}}</span> ;;
  }

  parameter: date_picker {
    type: number
    label: "Date Picker"
  }

  parameter: timeframe {
    type: string
    allowed_value: {
      label: "week"
      value: "created_week"
    }

    allowed_value: {
      label: "year"
      value: "created_year"
    }
  }

  dimension: test_slice {
    type: string
    sql: {% assign frame=timeframe._parameter_value | slice:0,4 %} "{{frame}}" ;;
  }

  dimension: text {
    type: string
    sql: "hello" ;;
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

  measure: order_count {
    type: count
    drill_fields: [created_month, status, order_count]
    link: {
      label: "By Status"
      url: "{% assign vis= '{\"color_application\":{\"collection_id\":\"b6347139-8179-43dd-9c1b-edf08aba97e0\",
\"palette_id\":\"34e02186-1753-4e63-b444-7e65ac62561b\",
\"options\":{\"steps\":5}},
\"x_axis_gridlines\":false,
\"y_axis_gridlines\":true,
\"show_view_names\":false,
\"y_axes\":[{\"label\":\"\",
\"orientation\":\"left\",
\"series\":[{\"axisId\":\"orders.count\",
\"id\":\"cancelled - orders.count\",
\"name\":\"cancelled\"},
{\"axisId\":\"orders.count\",
\"id\":\"complete - orders.count\",
\"name\":\"complete\"},
{\"axisId\":\"orders.count\",
\"id\":\"pending - orders.count\",
\"name\":\"pending\"}],
\"showLabels\":true,
\"showValues\":true,
\"maxValue\":10000,
\"unpinAxis\":false,
\"tickDensity\":\"default\",
\"tickDensityCustom\":5,
\"type\":\"log\"}],
\"show_y_axis_labels\":true,
\"show_y_axis_ticks\":true,
\"y_axis_tick_density\":\"default\",
\"y_axis_tick_density_custom\":5,
\"show_x_axis_label\":true,
\"show_x_axis_ticks\":true,
\"y_axis_scale_mode\":\"linear\",
\"x_axis_reversed\":false,
\"y_axis_reversed\":false,
\"plot_size_by_field\":false,
\"trellis\":\"pivot\",
\"stacking\":\"\",
\"limit_displayed_rows\":false,
\"legend_position\":\"left\",
\"point_style\":\"none\",
\"series_colors\":{},
\"show_value_labels\":false,
\"label_density\":25,
\"x_axis_scale\":\"auto\",
\"y_axis_combined\":true,
\"trend_lines\":[],
\"show_null_points\":true,
\"interpolation\":\"monotone\",
\"type\":\"looker_line\"}' %}

{{link}}&pivots=orders.status&vis={{vis | encode_uri}}"
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

#   dimension: future_30_days {
#     type: yesno
#     sql: ${created_date}>=${created_date} and ${created_date} <= date_add(${created_date}, interval 30 day) ;;
#   }

  measure: count_future_30 {
    type: number
    sql: (select count(o.id) from orders as o
    left join users on o.user_id=${users.id}
  where
  DATE(o.created_at)>=${created_date}
  and DATE(o.created_at) < date_add((${created_date}), interval 30 day)
  and {% condition users.gender %}${users.gender}{% endcondition %}
  ) ;;
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
