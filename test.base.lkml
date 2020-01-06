
include: "*.view"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

persist_with: thelook_xin_default_datagroup

explore: waterfall_chart_example {
  join: products{
    type: left_outer
    sql_on: ${products.category} = ${waterfall_chart_example.products_category} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: one_to_many
  }
  join: order_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
  }
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }
}

explore: user_pdt_with_parameter {
  join: users {
    type: left_outer
    sql: ${users.id}= ${user_pdt_with_parameter.users_id};;
    relationship: one_to_one
  }
}




explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
#   always_filter: {
#     filters: {
#       field: orders.14days_range
#       value: "yes"
#     }
#
#     filters: {
#       field: orders.range_start
#     }
#   }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: inner
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: inner
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: top3_state {
    type: left_outer
    sql_on: ${users.state} = ${top3_state.users_state} ;;
    relationship: many_to_one
  }

  join: dates {
#     type: left_outer
#     sql_on: ${orders.created_date}=${dates.series_date};;
  relationship: one_to_one
  sql: RIGHT JOIN ${dates.SQL_TABLE_NAME} on ${dates.series_date} = ${orders.created_date};;

}
}

explore: orders_test {
  from: orders
}

explore: orders {
  # cancel_grouping_fields: [users.id, orders.created_date]
#   cancel_grouping_fields: [orders.count1]
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} and
#           {% if users.gender._is_filtered %}
#           {%condition users.gender%}${users.gender}{% endcondition %}
#           {%endif%}
#           {% if users.state._is_filtered %}
#           AND {% condition users.state %}${users.state}{% endcondition %}
#           {%endif%}
#           ;;
#     relationship: many_to_one
#  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
#     AND {% if _user_attributes['name'] != null %} users.gender='m' {% else %} 1=1 {% end %} ;;
    relationship: many_to_one
  }

  join: orders_next_30 {
    from: orders
    sql_on: ${orders_next_30.created_date}>=${orders.created_date}
  and ${orders_next_30.created_date} < date_add((${orders.created_date}), interval 30 day) ;;
  }
}

#   join: order_items {
#     type: left_outer
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#     relationship: one_to_many
#   }

# explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
#     type: left_outer
  sql: left_outer join users on user_data.user_id = users.id ;;
#     relationship: many_to_one
}
}

explore: users {
#   always_filter: {
#     filters: {
#       field: gender
#       value: "m"
#     }
#
#     filters: {
#       field: created_test_date
#       value: "7 days ago for 7 days"
#     }
#   }
# sql_always_where: {{users.date_field._is_selected}} AND {{users.age._in_query}} ;;
join: dynamic_dim_dt {
  sql_on: ${users.id}=${dynamic_dim_dt.id} ;;
  relationship: one_to_one
}
}

explore: users_nn {}

explore: image {
  from: Test_Image
}

explore: test_aaa {}

explore: dates {}

explore: extended_view {}

explore: numbers {}

explore: test_ndt_parameter {
  join: users {
    type: left_outer
    sql_on: ${users.gender}=${test_ndt_parameter.gender} AND ${users.state}=${test_ndt_parameter.state} ;;
  }
}

explore: test_inner_join_order {}
explore: test_inner_join_2 {}

explore: test_user {
  from: users
  view_label: "User"
  fields: [ALL_FIELDS*,-test_user.first_name]
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
