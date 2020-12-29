{{- if .Values.ingress.enabled -}}
{{- if .Values.ingress.tls -}}
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ include "pet2cattle.name" . }}-le-crt
spec:
  secretName: tls-secret
  issuerRef:
    kind: Issuer
    name: letsencrypt
{{- range .Values.ingress.hosts }}  
  commonName: {{ .host }}
  dnsNames:
  - {{ .host }}
{{- end }}  
{{- end }}
{{- end }}