view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

#   dimension: yesnovalue {
#     type: yesno
#     sql: case when ${age}>30 then yes else no end ;;
#     can_filter: no
#   }

  dimension: age {
    # label: "{% if _user_attributes['language'] == 'zh_CN' %} 年龄 {% else %} age {% endif %}"
    label: "age"
    type: number
    sql: ${TABLE}.age ;;
  }

  measure: average_age {
    label: "average_age"
    type: average
    sql: ${age} ;;
  }

  dimension: city {
    label: "city"
    type: string
    sql: ${TABLE}.city ;;
    order_by_field: zip
  }

  dimension: long_text{
    type: string
    sql: "this is a very long text, this is a very long text, this is a very long text, this is a very long text, this is a very long text, this is a very long text." ;;
    html: <span style="font-size:20px">{{value}}</span> ;;
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
#     label: "very long long long long long long long long long label"
    alias: [like]
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      week_of_year,
      day_of_month,
      month,
      month_name,
      month_num,
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

  dimension: gender1 {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: gender_replace {
    type: string
    case: {
      when: {
        label: "m"
        sql: ${gender}="m" ;;
      }
      when: {
        label: "f"
        sql: ${gender}="f";;
      }
    }
  }

  dimension: gender_customise_dup {
    type: string
    case: {
      when: {
        label: "Category one - 5th and 95th percentile"
        sql: ${gender}="m";;
      }
      when: {
        label: "Category one - 45th percentile"
        sql: ${gender}="m";;
      }
      when: {
        label: "Category two - 5th and 95th percentile"
        sql: ${gender}="f" ;;
      }
      when: {
        label: "Category two - 45th percentile"
        sql: ${gender}="f";;
      }
    }
  }

#   dimension: gender_html_link {
#     type: string
#     sql: case when ${state}="California" then '{{users.state._label}}'
#       else "other state" end;;
#     link: {
#       label: "{{users.state._label}}"
#       url: "https://{% if value == 'Users State' %}google.com{% else %}looker.com{% endif %}?q={{value}}"
#     }

#     html: {% if value == 'm' %}
#     <a href="https://www.website.com" >Linked Text</a>
#     {% else %}
#     <a href="https://www.website2.com" >Linked Text2</a>
#     {% endif %};;
#   }

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
#     link: {
#       label:"test state"
#       url:"https://dcleu.eu.looker.com/looks/72?toggle=dat,vis&f[users.state]={{value |  url_encode }}&f[users.gender]={{users.gender._value}}"
#     }
  }

  parameter: currency_based_on_state {
    suggest_dimension: state
  }

  parameter: currency {
    type: unquoted
    allowed_value: {
      label: "dollar"
      value: "dollar"
    }
    allowed_value: {
      label: "euro"
      value: "euro"
    }
    allowed_value: {
      label: "pound"
      value: "pound"
    }
  }

  measure: dollor {
    type: count
    value_format: "$0"
  }

  measure: pound {
    type: count
    value_format: "£0"
  }

  measure: euro {
    type: count
    value_format: "€0"
  }

  measure: local_currency {
    type: number
    sql: ${euro};;
  }

  dimension: full_name {
    type: string
    sql: concat(${first_name},' ', ${last_name});;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: test_pivoted_dimension{
    sql: case when ${created_test_year} = 2015 then ''
    when ${created_test_year} = 2016 then ''
    when ${created_test_year} = 2017 then '2017'
    when ${created_test_year} = 2018 then '2018'
    when ${created_test_year} = 2019 then '2019'
    end;;
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

  parameter: parameter_field {
    type: unquoted
    allowed_value: {
      label: "male"
      value: "m"
    }
    allowed_value: {
      label: "female"
      value: "f"
    }
  }

#   dimension: adam {
#     type: string
#     sql: (SELECT ${TABLE}.first_name FROM );;
#   }

#   measure: count_test {
#     type: count
#     drill_fields: [detail*]
#     filters: {
#       field: testing
#       value: "Yes"
#     }
#   }

#   measure: growth1 {
#     type: count
#     filters: {
#       field: created_test_year
#       value: "{{created_test_year}}"
#     }
#   }

  parameter: dynamic_param_1 {
    type: unquoted
    allowed_value: {
      label: "Gender"
      value: "gender"
    }

    allowed_value: {
      label: "State"
      value: "state"
    }

    allowed_value: {
      label: "Country"
      value: "country"
    }
  }
#
#   measure: count_param {
#     type: count_distinct
#     sql: case when {% parameter dynamic_param_2 %}='m' then ${gender}
#     when {% parameter dynamic_param_2 %}='f' then ${state}
#     else null end;;
#   }

  measure: running_total {
    type: running_total
    sql: ${count} ;;
    direction: "column"
  }



  measure: count_multiple_filtervalue{
    type: count
    filters: {
      field: gender
      value: "m, f"
    }
  }

  measure: count_wtd {
    type: count_distinct
    sql: ${first_name} ;;
    filters: {
      field: created_test_date
      value: "this week"
    }
  }

  measure: count_mtd {
    type: count_distinct
    sql: ${first_name} ;;
    filters: {
      field: created_test_date
      value: "this month"
    }
  }

  parameter: time_frame_param {
    type: unquoted
    allowed_value: {
      label: "mtd"
      value: "count_mdt"
    }

    allowed_value: {
      label: "wtd"
      value: "count_wdt"
    }
  }

  measure: test_dynamic {
    type: number
    sql: case when '{% parameter time_frame_param %}' ='count_mdt' then ${count_mtd}
    when '{% parameter time_frame_param %}' ='count_wdt' then ${count_wtd}
    end;;
  }

  dimension: week_td {
    type: yesno
#     default_value: "yes"
    sql: ${created_test_week}=extract(week from curdate()) and ${created_test_day_of_week}<= dayofweek(curdate());;
  }

  dimension: month_td {
    type: yesno
#     default_value: "yes"
    sql: ${created_test_month_num}=extract(month from curdate()) and ${created_test_day_of_month}<= extract(day from curdate()) ;;
  }

  parameter: test_frame_param2 {
    type: unquoted
    allowed_value: {
      value: "week_td"
      label: "wtd"
    }

    allowed_value: {
      value: "month_td"
      label: "mtd"
    }
  }

  dimension: test_dynamic2 {
     type: yesno
    sql: {% if test_frame_param2._parameter_value == 'month_td' %}
    ${month_td}
    {% elsif test_frame_param2._parameter_value == 'week_td' %}
    ${week_td}
    {% endif %};;
  }

#   parameter: state_param {
#     type: unquoted
#     suggest_dimension: state
#   }

#   filter: state_param {
#     type: string
#     sql: ${state} ;;
#   }
#
#   dimension: yesno_state {
#     type: yesno
#     sql: {% condition state_param %}${state}{% endcondition %};;
#   }

#   measure: user_per_state {
#     type: number
#     sql: case when orders.state = {% parameter state_param %} then ${count} else null end ;;
#   }

# measure: user_per_state {
#   type: count
#   filters: {
#     field: yesno_state
#     value: "yes"
#   }
# }

  filter: date_field {
    type: date
    sql: {% if created_test_date._in_query %}
    {% endif %};;
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
