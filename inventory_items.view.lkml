view: inventory_items {
  sql_table_name: public.inventory_items ;;

  dimension: id {
#     hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: product_distribution_center_id {
    hidden: yes
    type: number
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    label: "Brand"
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  filter: brand_select {
    type: string
    suggest_dimension: product_brand
  }

  filter: category_select {
    type: string
    suggest_dimension: product_category
  }

  # dimension: product_category_competitor {
  #   type: string
  #   sql: CASE
  #   when {% condition brand_select %} ${product_brand} {% endcondition %} and {% condition category_select %} ${product_category} {% endcondition %}
  #   THEN ${product_brand} ||' '|| ${product_category}
  #   when {% condition brand_select %} ${product_brand} {% endcondition %}
  #   then 'Rest of Brand'
  #   when {% condition category_select %} ${product_category} {% endcondition %}
  #   then 'Rest Of Categories' {% endcondition %}
  #   else 'All Other Brands'
  #   END;;
  # }

  dimension: product_category {
    label: "Category"
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    label: "Department"
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    label: "Retail Price"
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: product_sku {
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.sold_at ;;
  }

  measure: total_cost  {
    type: sum
    sql: ${cost} ;;
    value_format_name: usd
  }

  measure: count {
    type: count
    drill_fields: [id, product_name, products.id, products.name, order_items.count]
  }
}

#### Example of using liquid and user attributes to make a user specific dimension ###
#   dimension: my_brand_or_others {
#     type: string
#     sql: case when '{{ _user_attributes["brand"] }}' = ${product_brand} then ${product_brand} else 'Other' END ;;
#   }

## Example of using a link parameter with liquid
# dimension: product_name_with_link{
#   type: string
#   sql: ${TABLE}.product_name ;;link: {
#     label: "Google Search: {{ value }}"
#     url: "http://www.google.com/search?q={{ value }}"
#     icon_url: "http://google.com/favicon.ico"
#   }
# }
