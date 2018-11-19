connection: "thelook"

# include all the views
include: "*.view"
include: "test.dashboard.lookml"

datagroup: thelook_xin_default_datagroup {
  sql_trigger: SELECT count(users.email) from demo_db.users where users.email = {{ _user_attributes['name'] }};;
  max_cache_age: "1 hour"
}

access_grant: test_access_grant {
  allowed_values: ["Gavin"]
  user_attribute: first_name
}


persist_with: thelook_xin_default_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
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
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: dates {
#     type: left_outer
#     sql_on: ${orders.created_date}=${dates.series_date};;
    relationship: one_to_one
    sql: RIGHT JOIN ${dates.SQL_TABLE_NAME} on ${dates.series_date} = ${orders.created_date};;

  }
}

explore: orders {
  cancel_grouping_fields: [orders.count1]
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} and
    {% if users.gender._is_filtered %}
    {%condition users.gender%}${users.gender}{% endcondition %}
    {%endif%}
    {% if users.state._is_filtered %}
    AND {% condition users.state %}${users.state}{% endcondition %}
    {%endif%}
    ;;
    relationship: many_to_one
  }
}

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
#       field: id
#       value: "{{_user_attributes['test_multiple_value']}}"
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

explore: test_user {
  from: users
  view_label: "User"
  fields: [ALL_FIELDS*,-test_user.first_name]
}
