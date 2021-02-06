{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "labels" -}}
app.kubernetes.io/version: {{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ template "name" . }}
app.kubernetes.io/instance: {{ template "fullname" . }}
{{- end }}

{{- define "zwave.name" -}}
{{- printf "%s-zwave" (include "name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "zwave.fullname" -}}
{{- printf "%s-zwave" (include "fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "zwave.podLabels" -}}
app.kubernetes.io/name: {{ template "zwave.name" . }}
app.kubernetes.io/instance: {{ template "zwave.fullname" . }}
{{- end }}

{{- define "zwave.labels" -}}
{{ template "zwave.podLabels" . }}
app.kubernetes.io/component: zwave
{{ template "labels" . }}
{{- end }}

{{- define "zigbee.name" -}}
{{- printf "%s-zigbee" (include "name" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "zigbee.fullname" -}}
{{- printf "%s-zigbee" (include "fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "zigbee.podLabels" -}}
app.kubernetes.io/name: {{ template "zigbee.name" . }}
app.kubernetes.io/instance: {{ template "zigbee.fullname" . }}
{{- end }}

{{- define "zigbee.labels" -}}
{{ template "zigbee.podLabels" . }}
app.kubernetes.io/component: zigbee
{{ template "labels" . }}
{{- end }}