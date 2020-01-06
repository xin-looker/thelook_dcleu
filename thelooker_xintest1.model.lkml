connection: "thelook"

# include all the views
include: "*.view"
include: "*.dashboard.lookml"

include: "test.base"

# datagroup: thelook_xin_default_datagroup {
#   sql_trigger: SELECT count(users.email) from demo_db.users where users.email = {{ _user_attributes['name'] }};;
#   max_cache_age: "1 hour"
# }

datagroup: test_thelook_xin {
  sql_trigger: select curdate() ;;
}

explore: orders_1 {
  from: orders
}
