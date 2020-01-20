connection: "thelook"

# include all the views
include: "*.view"
include: "*.dashboard.lookml"

# include: "test.base"

# datagroup: thelook_xin_default_datagroup {
#   sql_trigger: SELECT count(users.email) from demo_db.users where users.email = {{ _user_attributes['name'] }};;
#   max_cache_age: "1 hour"
# }

datagroup: test_thelook_xin {
  sql_trigger: select curdate() ;;
}

explore: order_items {
  join: orders {
    sql_on: ${orders.id}=${order_items.order_id} ;;
  }
}

explore: order_items_2 {
  view_name: order_items
  join: inventory_items {
    sql_on: ${order_items.inventory_item_id}=${inventory_items.id} ;;
  }
}


explore: extended {
  extends: [order_items_2, order_items]
}
