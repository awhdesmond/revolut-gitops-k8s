# FluentBit

To send logs from your containers to Amazon CloudWatch Logs, you can use Fluent Bit or Fluentd.

```bash
ClusterName=eks
RegionName=eu-west-1

kubectl create configmap fluent-bit-cluster-info \
--from-literal=cluster.name=${ClusterName} \
--from-literal=http.server='On' \
--from-literal=http.port='2020' \
--from-literal=read.head='Off' \
--from-literal=read.tail='On' \
--from-literal=logs.region=${RegionName} \
-n amazon-cloudwatch \
--dry-run=client -o yaml > cm.yaml
```