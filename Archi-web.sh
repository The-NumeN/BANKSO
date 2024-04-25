## Génération de la CA et des certificats SSL

## Mise en place d'une Autorité de Certification (CA) avec OpenSSL
   
   # Génération de la clé privée de la CA
   openssl genpkey -algorithm RSA -out ca-key.pem -aes256

   # Génération du certificat de la CA
   openssl req -new -x509 -days 365 -key ca-key.pem -out ca-cert.pem

## Installation et Configuration de HAProxy :
  
   apt update
   apt install haproxy

## Configuration de HAProxy (/etc/haproxy/haproxy.cfg)
   
   frontend http_front
       bind *:80
       default_backend backend_servers

   backend backend_servers
       balance roundrobin
       server server1 192.168.1.101:80 check
       server server2 192.168.1.102:80 check
       #remplacer ip par ceux de vos servers
  
systemctl restart haproxy

## Installation et Configuration de NGINX :

   apt install nginx

## Configuration du fichier de site NGINX (/etc/nginx/nginx.conf)
   
   server {
       listen 443 ssl;
       server_name example.com;

      ssl_certificate /etc/nginx/ssl/ca-cert.pem;
      ssl_certificate_key /etc/nginx/ssl/ca-key.pem;

       location / {
           proxy_pass http://backend_servers;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
  }


systemctl restart nginx

## Installation et Configuration de Fail2ban :

   apt install fail2ban

## Configuration de Fail2ban (/etc/fail2ban/jail.local)
   
[ssh]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3


   
service fail2ban restart
   

## Installation et Configuration de MySQL :
   
  apt-get install mysql-server

# Sécurisation de MySQL
   
   mysql_secure_installation


# Configuration de MySQL
   
   sudo mysql


   CREATE DATABASE mydatabase;
   CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
   GRANT ALL PRIVILEGES ON mydatabase.* TO 'myuser'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   

