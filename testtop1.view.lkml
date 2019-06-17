view: testtop1 {
  derived_table: {
    sql: SELECT
        DATE(orders.created_at ) AS `orders.created_date`,
        users.state AS `users.state`,
        users.id  AS `users.id`,
        row_num AS `rownumber`
      FROM demo_db.order_items  AS order_items
      INNER JOIN orders ON order_items.order_id = orders.id
      INNER JOIN demo_db.users  AS users ON orders.user_id = users.id

      {% if temp._is_filtered %}
      WHERE
        {% condition temp %}users.id{% endcondition %}
      {% endif %}
      GROUP BY 1,2,3
      ORDER BY DATE(orders.created_at ) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: row_number {
    type: number
    sql: ${TABLE}.`rownumber`;;
  }

  filter: temp {
    type: number
  }

  dimension: state {
    type:  string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: orders_created_date {
    type: date
    sql: ${TABLE}.`orders.created_date` ;;
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  set: detail {
    fields: [orders_created_date, users_id]
  }
}
