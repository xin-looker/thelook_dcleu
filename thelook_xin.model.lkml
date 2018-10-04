connection: "thelook"

# include all the views
include: "*.view"
include: "test.dashboard.lookml"

datagroup: thelook_xin_default_datagroup {
  sql_trigger: SELECT count(users.email) from demo_db.users where users.email = {{ _user_attributes['name'] }};;
  max_cache_age: "1 hour"
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
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  access_filter: {
    field: yesnovalue
    user_attribute: boolean_user_attribute
  }

  join: dynamic_dim_dt {
    sql_on: ${users.id}=${dynamic_dim_dt.id} ;;
    relationship: one_to_one
  }
}

explore: users_nn {}

explore: image {
  from: Test_Image
  }

explore: extended_view {}
