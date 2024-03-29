# customer-api

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Customer Values

There are number of key values to set on a customer-specific basis:

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| .customerName | string | `""` | Customer ID, used to form the Ingress path |
| .envVars.CUSTOMER_RESPONSE | string | `""` | The response string to return |


## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` | Enable autoscaling for deployment |
| autoscaling.maxReplicas | int | `10` | Maximum number of pods to run |
| autoscaling.minReplicas | int | `2` | Minimum number of pods to run |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| envVars | object | `{}` | Environment variables to set in the main container. |
| fullnameOverride | string | `""` | Override chart fullname |
| image.pullPolicy | string | `"IfNotPresent"` | Image Pull Policy |
| image.repository | string | `"customer-api"` | Image Registry |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Specify a imagePullSecrets array |
| ingress.annotations | object | `{}` | Ingress Annotations |
| ingress.className | string | `""` | Ingress Class Name |
| ingress.enabled | bool | `false` | Enable Ingress |
| ingress.tls | list | `[]` | Ingress TLS Configuration |
| nameOverride | string | `""` | Override chart name |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` | Map of pod annotations |
| podDisruptionBudget.enabled | bool | `false` | Enable PodDisruptionBudget |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods |
| podLabels | object | `{}` | Map of pod labels |
| podSecurityContext | object | `{}` | Map of pod security context |
| port | int | `8000` | Container port to expose |
| replicaCount | int | `1` | Number of replicas (only applicable when autoscaling is not used) |
| resources | object | `{}` | Resource limits and requests |
| securityContext | object | `{}` | Map of security context |
| service.port | int | `80` | Kubernetes service port |
| service.type | string | `"ClusterIP"` | Kubernetes service type |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` | Additional volumeMounts on the output Deployment definition. |
| volumes | list | `[]` | Additional volumes on the output Deployment definition. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.12.0](https://github.com/norwoodj/helm-docs/releases/v1.12.0)