view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
#     hidden:  yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: inventory_item_id {
    hidden: yes
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    hidden: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    group_label: "Date Created"
    type: time
    timeframes: [raw,date,week,month,month_name,year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: returned {
    group_label: "Date Returned"
    type: time
    timeframes: [raw,date,month,month_name,year]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd
  }

  measure: total_sale_price {
    type: sum
    value_format_name: usd
    sql: ${sale_price} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [id, users.id, inventory_items.id, users.first_name, users.last_name, inventory_items.product_name]
  }

}

#Example Liquid formatting for Status
# html:
# {% if value == 'Complete' %}
# <span style ="color: darkgreen">{{ value }}</span>
# {% elsif value == 'Cancelled' %}
# <span style  ="color: darkred">{{ value }}</span>
# {% elsif value == 'Returned' %}
# <span style ="color: darkred">{{ value }}</span>
# {% else %}
# <span style  ="color: goldenrod">{{ value }}</span>
# {% endif %} ;;


#Example Link parameters for Status with liquid
# link: {
#   label: "List {{_field._name}} = {{ value }} items"
# ## Can Link to any website like:
# #     url: "http://www.google.com/"
# ## Can link to Looker sites with dynamic filtering like:
#   url: "https://teach.corp.looker.com/explore/bootcamp/order_items?fields=order_items.detail*&f[order_items.status]={{ value }}"
# ## Optional Icon:
#   icon_url: "http://looker.com/favicon.ico"
# }
# ## Can add multiple links:
# link: {
#   label: "List Users who purchased {{_field._name}} = {{ value }} items"
#   url: "https://teach.corp.looker.com/explore/{{_model._name}}/{{_explore._name}}?fields=users.detail*&f[{{_field._name}}]={{ value }}"
#   icon_url: "http://looker.com/favicon.ico"
# }

# Example custom URL linking
## Example for Status field to go to detail* set with filter on the clicked value
#     html: <a href="/explore/bootcamp/order_items?fields=order_items.detail*&f[order_items.status]={{ value }}">{{ value }}</a>;;
## Example for any dimension field to go to detail* set
#     html: <a href="/explore/{{_model._name}}/{{_explore._name}}?fields={{_view._name}}.detail*&f[{{_field._name}}]={{ value }}">{{ value }}</a>;;


# Example HTML Paramater for Count
# html:
# {% if value > 1500 %}
# <p style="color: darkgreen">{{ value }}</p>
# {% elsif value > 1000 %}
# <p style="color: goldenrod">{{ value }}</p>
# {% else %}
# <p style="color: darkred">{{ value }}</p></b>
# {% endif %} ;;



#### Example of liquid and user attributes to compare user ####
# dimension: is_my_brand {
#   type: yesno
#   sql: ${inventory_items.product_brand} = '{{_user_attributes["brand"]}}';;
# }
#
# measure: my_brand_count {
#   type: count
#   filters: {
#     field: is_my_brand
#     value: "Yes"
#   }
# }
#
# measure: average_sale_price {
#   type: average
#   value_format_name: usd
#   sql: ${sale_price} ;;
# }
#
# measure: my_brand_average_sale_price {
#   type: average
#   value_format_name: usd
#   sql: ${sale_price} ;;
#   filters: {
#     field: is_my_brand
#     value: "Yes"
#   }
# }
