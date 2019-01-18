view: test_inner_join_order {
  derived_table:{
    sql:
    SELECT
  users.state  AS `users.state`,
  COUNT(DISTINCT orders.id ) AS `orders.count`,
  COUNT(*) AS `order_items.count`
FROM demo_db.users  AS users
INNER JOIN orders ON  orders.user_id = users.id
INNER JOIN demo_db.order_items  AS order_items ON order_items.order_id = orders.id
Where {% date_start demo_db.users.created %} and {% date_end demo_db.users.created %}
GROUP BY 1
ORDER BY COUNT(DISTINCT orders.id ) DESC
LIMIT 500 ;;
}

  dimension: state {
    type: string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: order {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  dimension: order_items {
    type: string
    sql: ${TABLE}.`order_items.count` ;;
  }
 }
