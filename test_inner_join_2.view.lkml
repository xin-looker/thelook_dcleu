view: test_inner_join_2 {
  sql_table_name: (SELECT
  users.state  AS `users.state`,
  COUNT(DISTINCT orders.id ) AS `orders.count`,
  COUNT(*) AS `order_items.count`
FROM demo_db.users  AS users
INNER JOIN orders ON  orders.user_id = users.id
INNER JOIN demo_db.order_items  AS order_items ON order_items.order_id = orders.id
WHERE (order_items.returned_at  IS NULL) AND (order_items.sale_price  < 20) AND ((((orders.created_at ) >= ((TIMESTAMP('2018-01-01'))) AND (orders.created_at ) < ((DATE_ADD(TIMESTAMP('2018-01-01'),INTERVAL 1 year))))))
GROUP BY 1
ORDER BY COUNT(DISTINCT orders.id ) DESC
LIMIT 500) ;;

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
