view: testderivedtable {
  derived_table: {
    sql: SELECT
        TO_CHAR(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', orders.created ), 'YYYY-MM') AS "orders.created_month",
        COUNT(DISTINCT order_items.order_id ) AS "order_items.order_count",
        COALESCE(SUM(order_items.sale_price ), 0) AS "order_items.total_sale_price"
      FROM public.order_items  AS order_items
      LEFT JOIN teach_scratch.LR$KDH19A4CVN77C95XJMIEC_orders AS orders ON order_items.order_id = orders.pk

      WHERE
        (((orders.created ) >= ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,-59, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) )))) AND (orders.created ) < ((CONVERT_TIMEZONE('America/Los_Angeles', 'UTC', DATEADD(day,60, DATEADD(day,-59, DATE_TRUNC('day',CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', GETDATE())) ) ))))))
      GROUP BY 1
      ORDER BY 1 DESC
      LIMIT 500
       ;;

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_created_month {
    type: string
    sql: ${TABLE}."orders.created_month" ;;
  }

  dimension: order_items_order_count {
    type: number
    sql: ${TABLE}."order_items.order_count" ;;
  }

  dimension: order_items_total_sale_price {
    type: number
    sql: ${TABLE}."order_items.total_sale_price" ;;
  }

  set: detail {
    fields: [orders_created_month, order_items_order_count, order_items_total_sale_price]
  }
}
