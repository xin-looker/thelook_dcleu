view: top3_state {
  derived_table: {
    sql: SELECT
        users.state  AS `users.state`,
        COALESCE(count(orders.user_id),0)  AS `orders.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      WHERE
        (((orders.created_at ) >= ((DATE_ADD(TIMESTAMP(DATE(DATE_ADD(DATE(NOW()),INTERVAL (0 - MOD((DAYOFWEEK(DATE(NOW())) - 1) - 1 + 7, 7)) day))),INTERVAL -1 week))) AND (orders.created_at ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(DATE(DATE_ADD(DATE(NOW()),INTERVAL (0 - MOD((DAYOFWEEK(DATE(NOW())) - 1) - 1 + 7, 7)) day))),INTERVAL -1 week),INTERVAL 1 week)))))
      GROUP BY 1
      ORDER BY COALESCE(count(orders.user_id),0)  DESC
      LIMIT 3
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_state {
    type: string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  set: detail {
    fields: [users_state, orders_count]
  }
}
