view: test_aaa {
  derived_table: {
    sql: SELECT
        users.id  AS `users.id`,
        users.first_name  AS `users.first_name`,
        users.last_name  AS `users.last_name`,
        users.email  AS `users.email`,
        COUNT(DISTINCT orders.id ) AS `orders.count`,
        COUNT(order_items.id) AS `order_items.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      GROUP BY 1,2,3,4
      ORDER BY users.id
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
    primary_key: yes
  }

  dimension: users_first_name {
    type: string
    sql: ${TABLE}.`users.first_name` ;;
  }

  dimension: users_last_name {
    type: string
    sql: ${TABLE}.`users.last_name` ;;
  }

  dimension: users_email {
    type: string
    sql: ${TABLE}.`users.email` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  measure: evg_items {
    type: average
    sql: ${order_items_count} ;;
  }

  measure: tot_items {
    type: sum
    sql: ${order_items_count};;
  }

  set: detail {
    fields: [
      users_id,
      users_first_name,
      users_last_name,
      users_email,
      orders_count,
      order_items_count
    ]
  }
}
