#!/bin/bash

sed -i '/DocumentRoot/s,html,html/htdocs,'  /etc/apache2/sites-available/000-default.conf

# Préparation des variables avec une valeur par défaut
LDAP_URL="${LDAP_URL:=ldap://1.2.3.4:port}"
LDAP_STARTTLS="${LDAP_STARTTLS:=false}"
LDAP_BINDDN="${LDAP_BINDDN:=admin}"
LDAP_BINDPW="${LDAP_BINDPW:=adminpass}"
LDAP_BASE="${LDAP_BASE:=dc=domain,dc=com}"
LDAP_USER_BASE="${LDAP_USER_BASE:=ou=users},${LDAP_BASE}"
LDAP_USER_FILTER="${LDAP_USER_FILTER:=(objectClass=user)}"
LDAP_SIZE_LIMIT="${LDAP_SIZE_LIMIT:=100}"


# Traitement du fichier de config pour application de nos variables
sed \
    -e "/__LDAP_URL/s@__LDAP_URL@${LDAP_URL}@" \
    -e "/__LDAP_STARTTLS/s@__LDAP_STARTTLS@${LDAP_STARTTLS}@" \
    -e "/__LDAP_BINDDN/s@__LDAP_BINDDN@${LDAP_BINDDN}@" \
    -e "/__LDAP_BINDPW/s@__LDAP_BINDPW@${LDAP_BINDPW}@" \
    -e "/__LDAP_BASE/s@__LDAP_BASE@${LDAP_BASE}@" \
    -e "/__LDAP_USER_BASE/s@__LDAP_USER_BASE@${LDAP_USER_BASE}@" \
    -e "/__LDAP_USER_FILTER/s@__LDAP_USER_FILTER@${LDAP_USER_FILTER}@" \
    -e "/__LDAP_SIZE_LIMIT/s@__LDAP_SIZE_LIMIT@${LDAP_SIZE_LIMIT}@" \
  /config.inc.template > /var/www/html/conf/config.inc.php
chown root:www-data  /var/www/html/conf/config.inc.php
chmod 440            /var/www/html/conf/config.inc.php



. /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
