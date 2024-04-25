#!/bin/bash

# Ne pas oublier de creer un fichier data.csv avant
file="data.csv"

# Mettre les infos du ldap
LDAP_HOST="ldap.example.com"
LDAP_PORT="389"
LDAP_USER="cn=admin,dc=example,dc=com"
LDAP_PASSWORD="admin_password"
LDAP_BASE_DN="dc=example,dc=com"

while IFS=, read -r username email
do
    ldapadd -x -h "$LDAP_HOST" -p "$LDAP_PORT" -D "$LDAP_USER" -w "$LDAP_PASSWORD" <<EOF
dn: uid=$username,$LDAP_BASE_DN
objectClass: inetOrgPerson
cn: $username
sn: $username
mail: $email
EOF
    
    if [ $? -eq 0 ]; then
        echo "User $username added successfully."
    else
        echo "Failed to add user $username."
    fi
done < "$file"
