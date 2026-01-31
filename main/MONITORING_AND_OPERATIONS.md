# Monitoring & Operations

### Metrics to Monitor
* **USE Method:** Utilization (CPU/RAM), Saturation, and Errors.
* **Application:** HTTP 500 error rates and response latency (p99).
* **Infrastructure:** Pod restart counts (indicates crash loops).

### Alerts
* **Critical:** API Error rate > 1% for 5 minutes.
* **Critical:** High Latency (> 2000ms).
* **Warning:** Disk usage > 80%.

### Logs
* Application logs (console output).
* Ingress access logs (traffic patterns).