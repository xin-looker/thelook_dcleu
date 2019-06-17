# If necessary, uncomment the line below to include explore_source.

view: dates {
  derived_table: {
    sql:  SELECT
          DATE_ADD('2018-01-01', INTERVAL numbers.number DAY)
        as series_date
      FROM ${numbers.SQL_TABLE_NAME} AS numbers ;;
      }

  dimension: series_date {
    type: date
    primary_key: yes
    sql: ${TABLE}.series_date ;;
  }

  dimension: number {
    type: number
    sql: 1;;
  }
}
