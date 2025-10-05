{{- define "guestbook.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "guestbook.fullname" -}}
{{- printf "%s-%s" (include "guestbook.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "guestbook.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "guestbook.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: Helm
{{- end -}}

{{- define "guestbook.selectorLabels" -}}
app.kubernetes.io/name: {{ include "guestbook.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
