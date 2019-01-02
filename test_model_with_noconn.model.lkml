connection: "thelook"

# include all the views
include: "*.view"
include: "*.explore"
include: "*.dashboard.lookml"

# datagroup: thelook_xin_default_datagroup {
#   sql_trigger: SELECT count(users.email) from demo_db.users where users.email = {{ _user_attributes['name'] }};;
#   max_cache_age: "1 hour"
# }


persist_with: thelook_xin_default_datagroup

explore: events1 {
  from: events
  join: users {
    type: left_outer
    sql_on: ${events1.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
