resource "google_monitoring_alert_policy" "alert_policy" {
  display_name          = var.monitoring_alert_policy.display_name
  combiner              = var.monitoring_alert_policy.combiner
  enabled               = var.monitoring_alert_policy.enabled
  notification_channels = var.monitoring_alert_policy.notification_channels
  alert_strategy        = var.monitoring_alert_policy.alert_strategy
  documentation         = var.monitoring_alert_policy.documentation
  user_labels           = var.monitoring_alert_policy.user_labels

  dynamic "conditions" {
    for_each = { for i in local.monitoring_alert_policy.monitoring_alert_policy : i.display_name => i }
    content {
      display_name = conditions.display_name
      condition_threshold {
        filter          = conditions.condition_threshold.filter
        duration        = conditions.condition_threshold.duration
        comparison      = conditions.condition_threshold.comparison
        threshold_value = conditions.condition_threshold.threshold_value
        trigger         = condition_threshold.trigger
        dynamic "aggregations" {
          count = condition_threshold.aggregations
          content {
            alignment_period   = aggregations.alignment_period
            per_series_aligner = aggregations.per_series_aligner
          }

        }
      }
    }
  }

}
