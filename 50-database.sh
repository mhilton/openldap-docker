if [ -z "$DB_ROOT_DN" ]; then
	DB_ROOT_DN=cn=admin,$DB_SUFFIX
fi
if [ -z "$DB_ROOT_PASSWORD" ]; then
	DB_ROOT_PASSWORD=`dd if=/dev/urandom bs=15 count=1 2>/dev/null | base64`
	echo "Generated password for $DB_ROOT_DN: $DB_ROOT_PASSWORD" >&2 
fi
if ! echo $DB_ROOT_PASSWORD | grep "^{" > /dev/null; then
	DB_ROOT_PASSWORD=`slappasswd -s $DB_ROOT_PASSWORD`
fi
cat << EOF
dn: olcDatabase=mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcSuffix: $DB_SUFFIX
olcRootDN: $DB_ROOT_DN
olcRootPW: $DB_ROOT_PASSWORD
olcDbDirectory: /srv/ldap/data
olcDbIndex: objectClass eq
olcDbIndex: cn,uid eq
olcDbIndex: uidNumber,gidNumber eq
olcDbIndex: member,memberUid eq
olcDbMaxSize: 1073741824
olcAccess: to * by * read
EOF
