- dashboard: test_dashboard
  title: test_lookml_dashboard_filter
  layout: newspaper
  elements:
  - title: test_lookml_dashboard_filter
    name: test_lookml_dashboard_filter
    model: thelook_xin
    explore: order_items
    type: looker_line
    fields:
    - users.gender
    - orders.created_date
    - order_items.count
    pivots:
    - users.gender
    fill_fields:
    - orders.created_date
    filters:
      orders.created_year: 2018/01/01 to 2018/09/09
    sorts:
    - users.gender 0
    - orders.created_date
    limit: 500
    column_limit: 50
    dynamic_fields:
    - measure: order_before_march
      based_on: order_items.count
      type: count_distinct
      label: order before march
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
      filter_expression: "${orders.created_date}< date(2018,3,1)"
    - measure: order_after_march
      based_on: order_items.count
      type: count_distinct
      label: order after march
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
      filter_expression: "${orders.created_date}>date(2018,2,28)"
    - table_calculation: calculation_3
      label: Calculation 3
      expression: if(${orders.created_date}=date(2018,3,1), 60,null)+${order_items.count}*0
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    query_timezone: UTC
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_colors:
      f - order_items.count: "#f54282"
      m - order_items.count: "#50a2ef"
      f - calculation_3: "#0f0f0f"
    series_types:
      f - calculation_3: column
    limit_displayed_rows: false
    hidden_series:
    - m - order_after_march
    - m - order_before_march
    - m - calculation_3
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: f - order_items.count
        name: f - Order Items Count
        axisId: order_items.count
        __FILE: thelook_xin/test.dashboard.lookml
        __LINE_NUM: 75
      - id: m - order_items.count
        name: m - Order Items Count
        axisId: order_items.count
        __FILE: thelook_xin/test.dashboard.lookml
        __LINE_NUM: 78
      showLabels: true
      showValues: true
      unpinAxis: false
      tickDensity: default
      type: linear
      __FILE: thelook_xin/test.dashboard.lookml
      __LINE_NUM: 72
    - label:
      orientation: right
      series:
      - id: f - calculation_3
        name: f - Calculation 3
        axisId: calculation_3
        __FILE: thelook_xin/test.dashboard.lookml
        __LINE_NUM: 89
      - id: m - calculation_3
        name: m - Calculation 3
        axisId: calculation_3
        __FILE: thelook_xin/test.dashboard.lookml
        __LINE_NUM: 92
      showLabels: false
      showValues: false
      maxValue:
      minValue:
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 0
      type: linear
      __FILE: thelook_xin/test.dashboard.lookml
      __LINE_NUM: 86
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: []
    trend_lines: []
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    listen:
      Untitled Filter: users.gender
    row: 0
    col: 0
    width: 24
    height: 8
  filters:
  - default_value: m
    name: Untitled Filter
    field: users.gender
    title: Untitled Filter
    allow_multiple_values: true
    required: false
    explore: users
    listens_to_filters: []
    model: thelook_xin
    type: field_filter
