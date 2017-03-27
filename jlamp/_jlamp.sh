#! /bin/bash
# source "$PWD/jtools/_jtools.sh"

_SUFFIX="jbox"
_APACHE_VHOSTS="/etc/apache2/sites-available/vhostname.${_SUFFIX}.conf"
_PUBLIC_DIR="/mnt/c/Users/Public"

_jlamp() {
	case "$1" in
		'install')
			echo "Installing jlamp"
			_jtools "apache"
			_jtools "mysql"
			_jtools "php"
		;;
		'up')
			echo "Starting wlsamp"
		;;
		'dowm') 
			echo "Shuting down wlsamp"
		;;
		'vhost')
			echo "Setting vhost"
			if [ ! -f "${_APACHE_VHOSTS/vhostname/$2}" ]; then
				sudo touch "${_APACHE_VHOSTS/vhostname/$2}"
				sudo cat << EOF > "${_APACHE_VHOSTS/vhostname/$2}"
<VirtualHost *:80>
	ServerName "${2}.${_SUFFIX}"
	ServerAlias "*.${2}.${_SUFFIX}"
	VirtualDocumentRoot /mnt/c/Users/Public/%2/%1/web
	DirectoryIndex index.html index.php
	SetEnv APP_ENV "dev"
	<Directory ${_PUBLIC_DIR}/%2/%1/web>
		Options Indexes FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>
EOF
				sudo a2ensite "${2}.${_SUFFIX}"
				sudo service apache2 reload
			fi
		;;
	esac
}
