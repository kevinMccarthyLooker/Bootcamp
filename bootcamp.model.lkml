connection: "events_ecommerce"

include: "*.view" # include all the views

include: "*.dashboard" # include all the dashboards


explore: inventory_items {
  description: "Basic product and inventory information"

  join: distribution_centers {
    type: left_outer
    sql_on: ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}
explore: order_items {

#To Do: Add distribution_centers join to this explore
description: "Information about orders including user information"
join: users {
  type: left_outer
  sql_on: ${order_items.user_id} = ${users.id} ;;
  relationship: many_to_one
}

join: inventory_items {
  type: left_outer
  sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  relationship: many_to_one
}

}

################################
#### Explore Filters example ###
# #   sql_always_where: ${inventory_items.product_brand}='Calvin Klein' ;;
#
# #   always_filter: {
# conditionally_filter: {
#   unless: [inventory_items.product_name]
#   filters: {
#     field: inventory_items.product_brand
#     value: "Calvin Klein"
#   }
# }
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^#
