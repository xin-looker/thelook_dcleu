# If necessary, uncomment the line below to include explore_source.
# include: "thelook_xin.model.lkml"

view: test_ndt_parameter {
  derived_table: {
    explore_source: order_items {
      column: count { field: orders.count }
      column: gender { field:users.gender }
      column: state { field: users.state}
      derived_column: derived_column {
        sql:  {% if test_param._parameter_value == 'gd' %}
    gender
    {% else %}
    state
    {% endif %};;
      }
#       column: dynamic_dim { field: users.dynamic_dim}
#       filters: {
#         field: users.dynamic_param_1
#         value: "state"
#       }

#       bind_filters: {
#         to_field: test_ndt_parameter.dynamic_dim
#         from_field: users.dynamic_param_1
#       }
    }
  }

  parameter: test_param {
    type: unquoted
    allowed_value: {
      label: "gender"
      value: "gd"
    }

    allowed_value: {
      label: "state"
      value: "state"
    }
  }

#   dimension: test_parameterised_dim {
#     type: string
#     sql: {% if test_param._parameter_value == 'gd' %}
#     ${gender}
#     {% else %}
#     ${state}
#     {% endif %};;
#   }

  measure: count {
    type: count
  }
  dimension: gender {}
  dimension: state {}
  dimension: derived_column {}

  filter: test {
    type: string
  }
}
