#!/bin/bash

# Ne pas oublier de creer un fichier data.csv avant
file="data.csv"

# Mettre les infos du ldap
LDAP_HOST="hg.local"
LDAP_PORT="389"
LDAP_USER="cn=admin,dc=hg,dc=local"
LDAP_PASSWORD="admin"
LDAP_BASE_DN="dc=hg,dc=local"

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
