view: user_pdt_with_parameter {
  derived_table: {
    sql: SELECT
        users.id  AS `users.id`,
        users.gender  AS `users.gender`,
        COUNT(*) AS `users.count`
      FROM demo_db.users  AS users

      GROUP BY 1,2
      ORDER BY COUNT(*) DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  dimension: users_gender {
    type: string
    sql: ${TABLE}.`users.gender` ;;
  }

  dimension: users_count {
    type: number
    sql: ${TABLE}.`users.count` ;;
  }

  set: detail {
    fields: [users_id, users_gender, users_count]
  }
}
