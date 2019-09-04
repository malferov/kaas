server {
  listen 80;
  server_name ${app}.${domain};
  root /usr/share/nginx/html;
  index vk-felix.htm;
}
