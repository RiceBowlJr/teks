locals {
  values_metrics_server = <<VALUES
image:
  tag: ${var.metrics_server["version"]}
args:
  - --logtostderr
  - --kubelet-preferred-address-types=InternalIP,ExternalIP
VALUES
}

resource "helm_release" "metrics_server" {
  count     = "${var.metrics_server["enabled"] ? 1 : 0 }"
  name      = "metrics-server"
  chart     = "stable/metrics-server"
  version   = "${var.metrics_server["chart_version"]}"
  values    = ["${concat(list(local.values_metrics_server),list(var.metrics_server["extra_values"]))}"]
  namespace = "${var.metrics_server["namespace"]}"
}
