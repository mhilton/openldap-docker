for schema in /etc/ldap/schema/*.ldif; do
	if [ "$schema" != "/etc/ldap/schema/core.ldif" ]; then
		echo include: file://$schema
	fi
done
