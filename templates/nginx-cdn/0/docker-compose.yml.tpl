version: '2'
services:
  nginx-cdn:
    restart: always
    image: oorabona/nginx-cdn-config:v0.1.0
    volumes:
      - ${base_dir}:/var/www:ro
    labels:
      io.rancher.container.hostname_override: container_name
  nginx:
    restart: always
    image: nginx:latest
    labels:
      io.rancher.sidekicks: nginx-cdn
      io.rancher.container.pull_image: always
      io.rancher.container.hostname_override: container_name
{{- if eq .Values.want_global "true"}}
      io.rancher.scheduler.global: ${want_global}
{{- else}}
      io.rancher.scheduler.affinity:host_label: ${host_label}
{{- end}}
    ports:
      - 80:80
    volumes_from:
      - nginx-cdn
