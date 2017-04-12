#! /bin/bash
# source "$PWD/jtools/_jtools.sh"

_SUFFIX="jbox"
_APACHE_CONFIG="/etc/apache2/apache2.conf"
_APACHE_VHOSTS="/etc/apache2/sites-available/VHOSTNAME.${_SUFFIX}.conf"
_WINDOW_DIR="/mnt/c/Users/Public/${_SUFFIX}/"
_WINDOW_HOSTS="/mnt/c/Windows/System32/drivers/etc/hosts"

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
			echo "Setting vhost..."
			if [ ! -f "${_APACHE_VHOSTS/VHOSTNAME/$2}" ]; then
				mkdir -p "${_WINDOW_DIR}$2"
				touch "${_APACHE_VHOSTS/VHOSTNAME/$2}"
				sudo cat << EOF > "${_APACHE_VHOSTS/VHOSTNAME/$2}"
<VirtualHost *:80>
	ServerName "${2}.${_SUFFIX}"
	ServerAlias "*.${2}.${_SUFFIX}"
	VirtualDocumentRoot ${_WINDOW_DIR}%2/%1/web
	DirectoryIndex index.html index.php
	SetEnv APP_ENV "dev"
	<Directory ${_WINDOW_DIR}%2/%1/web>
		Options Indexes FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>
EOF

		sudo cat << EOF >> "${_APACHE_CONFIG}"

<Directory ${_WINDOW_DIR}>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
EOF
		sudo cat << EOF >> "${_WINDOW_HOSTS}"
127.0.0.1	$2.${_SUFFIX}
EOF
				sudo a2ensite "${2}.${_SUFFIX}"
				sudo service apache2 reload
			fi
		;;
	esac
}
