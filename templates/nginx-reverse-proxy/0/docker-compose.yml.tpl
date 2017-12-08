version: '2'
services:
  nginx-rp:
    image: oorabona/nginx-rancher-rp:${NGINX_VERSION}
    labels:
      io.rancher.container.network: true
      io.rancher.container.hostname_override: container_name
#      io.rancher.scheduler.global: 'true'
      io.rancher.service.selector.link: web_rp=true
    environment:
      RANCHER_VERSION: ${rancher_version}
      IP_FIELD: ${ip_field_policy}
#    ports:
#      - "80:80"
    volumes:
      - nginx-conf:/etc/nginx
  #    - '${base_dir}/certs:/etc/nginx/certs:ro'
      - nginx-html:/usr/share/nginx/html'

  lb:
    image: rancher/lb-service-haproxy
    ports:
    - 443
volumes:
  nginx-conf:
    driver: ${CONF_VOLUME_DRIVER}
  nginx-html:
    driver: ${HTML_VOLUME_DRIVER}
