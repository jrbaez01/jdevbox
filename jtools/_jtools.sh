_jtools() {
	case "$1" in
		'apache')
			echo "Installing apache"
			sudo apt-get -y install apache2
			sudo a2enmod vhost_alias
			sudo a2enmod rewrite
			sudo service apache2 reload
			sudo update-rc.d apache2 defaults
			sudo update-rc.d apache2 enable
		;;
		'mysql')
			echo "Installing mysql"
			echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
			echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
			apt-get -y install mysql-client mysql-server
			sudo service mysql restart
			sudo update-rc.d mysql defaults
			sudo update-rc.d mysql enable
		;;
		'php') 
			echo "Installing php"
			sudo apt-get -y install php5 php5-curl php5-mysql php5-sqlite php-pear
			sudo service apache2 reload
		;;
		'composer')
			echo "Installing composer"
			if [ ! -f "/usr/local/bin/composer" ]; then
				curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
			fi
		;;
		'git')
			echo "Installing git"
			sudo apt-get -y install git
		;;
		'essential')
			echo "Installing build-essential"
			sudo apt-get update
			sudo apt-get -y install build-essential binutils-doc
		;;
	esac
}
