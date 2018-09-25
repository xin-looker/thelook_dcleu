view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }

  filter: dynamic_template {
    type: string
    suggestions: ["brand","category","department"]
  }

  dimension: dynamic_dimension {
    sql: CASE WHEN {% condition dynamic_template %} 'brand' {% endcondition %} THEN ${brand}
      WHEN {% condition dynamic_template %} 'category' {% endcondition %} THEN ${category}
      WHEN {% condition dynamic_template %} 'department' {% endcondition %} THEN ${department}
      ELSE null END ;;
  }
}
