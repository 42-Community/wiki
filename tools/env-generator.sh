#!/bin/bash

function generate_password() {
	chars_upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	chars_lower="abcdefghijklmnopqrstuvwxyz"
	chars_number="0123456789"
	chars_special="!@#$%^&*()"

	password=""

	# Generate a random password with at least one of each required character
	while [[ ! "$password" =~ [A-Z] ]] || [[ ! "$password" =~ [a-z] ]] || [[ ! "$password" =~ [0-9] ]] || [[ ! "$password" =~ [[:punct:]] ]]; do
	  password="$password${chars_upper:$RANDOM % ${#chars_upper}:1}${chars_lower:$RANDOM % ${#chars_lower}:1}${chars_number:$RANDOM % ${#chars_number}:1}${chars_special:$RANDOM % ${#chars_special}:1}"
	done

	# Add more random characters to reach the desired password length
	while [[ ${#password} -lt 32 ]]; do
	  password="$password${chars_upper:$RANDOM % ${#chars_upper}:1}${chars_lower:$RANDOM % ${#chars_lower}:1}${chars_number:$RANDOM % ${#chars_number}:1}${chars_special:$RANDOM % ${#chars_special}:1}"
	done

	echo "$password"
}

env_directory="$(git rev-parse --show-toplevel)/.env"

echo $env_directory

mkdir -p $env_directory

#data
DATABASE_PASSWORD=$(generate_password)
cat >  $env_directory"/database-env"  << EOF 
DATABASE_NAME=my_wiki
DATABASE_USER=wikiuser
DATABASE_PASSWORD=$DATABASE_PASSWORD
EOF

#media
ADMIN_PASSWORD=$(generate_password)
cat > $env_directory"/mediawiki-env" << EOF
SERVER_URL="http://localhost:8080"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD=$ADMIN_PASSWORD
EOF

#mysql
cat > $env_directory"/mysql-env" << EOF
MYSQL_RANDOM_ROOT_PASSWORD='yes'
EOF
