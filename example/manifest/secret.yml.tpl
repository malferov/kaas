apiVersion: v1
data:
  tls.crt: ${cer}
  tls.key: ${key}
kind: Secret
metadata:
  name: app-tls
#  namespace: default
type: Opaque
