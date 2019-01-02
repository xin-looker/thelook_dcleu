view: waterfall_chart_example {
  derived_table: {
    sql: select test.`products.category`, test.`sales_year`, test.`order_items.count` from  (SELECT
            products.category  AS `products.category`,
            year(orders.created_at ) As `sales_year`,
            COUNT(*) AS `order_items.count`
            FROM demo_db.order_items  AS order_items
            LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
            LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
            LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

            WHERE ((((orders.created_at ) >= (TIMESTAMP('2017-01-01')) AND (orders.created_at ) < (TIMESTAMP('2018-11-27'))))) AND ((products.category  IN ('Jeans', 'Outerwear & Coats', 'Shorts', 'Blazers & Jackets')))
            GROUP BY 1,2
            UNION
            SELECT YEAR(orders.created_at),YEAR(orders.created_at),
              COUNT(*)
            FROM demo_db.order_items  AS order_items
            LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
            LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
            LEFT JOIN demo_db.products  AS products ON inventory_items.product_id = products.id

            WHERE ((((orders.created_at ) >= ((TIMESTAMP('2017-01-01'))) AND (orders.created_at ) < ((DATE_ADD(TIMESTAMP('2017-01-01'),INTERVAL 1 year)))) OR ((orders.created_at ) >= ((TIMESTAMP('2018-01-01'))) AND (orders.created_at ) < ((DATE_ADD(TIMESTAMP('2018-01-01'),INTERVAL 1 year)))))) AND ((products.category  IN ('Jeans', 'Outerwear & Coats', 'Shorts', 'Blazers & Jackets')))
            GROUP BY 1
            ) as `test`
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: products_category {
    primary_key: yes
    type: string
    sql: ${TABLE}.`products.category` ;;
  }

  dimension: sales_year {
    type: string
    sql: ${TABLE}.sales_year ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  measure: sales_2017 {
    type: sum
    sql: ${TABLE}.`order_items.count` ;;
    filters: {
      field: sales_year
      value: "2017"
    }
  }

  measure: sales_2018 {
    type: sum
    sql: ${TABLE}.`order_items.count` ;;
    filters: {
      field: sales_year
      value: "2018"
    }
  }

  set: detail {
    fields: [products_category, sales_year, order_items_count]
  }
}
