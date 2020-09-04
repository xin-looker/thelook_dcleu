connection: "thelook"

# include all the views
include: "*.view"

datagroup: thelook_felix_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: thelook_felix_default_datagroup

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# explore: order_extends {
#   join: orders {
#     relationship: one_to_one
#     sql_on: ${order_extends.id}=${orders.id} ;;
#   }
# }

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
    view_label: "Order_yes"
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
}

explore: orders_yes {

  from: orders
  fields: [orders_yes.count_90days,orders_yes.created_date]
#   sql_always_where:
#   {% if orders_yes.count_complete._in_query %}
#   orders.status = 'complete'
#   {% elsif orders_yes.count_pending._in_query %}
#   orders_yes.status = 'pending'
#   {% else %}
#   1=1
#   {% endif %};;
  join: users {
    type: left_outer
    sql_on: ${orders_yes.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

explore: sql_runner_query {}
