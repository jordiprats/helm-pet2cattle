{{- if .Values.ingress.enabled -}}
{{- if .Values.ingress.tls -}}
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ include "pet2cattle.name" . }}-cert-https
spec:
  secretName: {{ include "pet2cattle.name" . }}-cert-https
  issuerRef:
    kind: ClusterIssuer
    name: letsencrypt
  commonName: {{ index .Values.ingress.tls.hosts 0 }}
  dnsNames:
{{- range .Values.ingress.tls.hosts }}
  - {{ . }}
{{- end }}  
{{- end }}
{{- end }}