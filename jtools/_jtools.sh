_jtools() {
	case "$1" in
		'apache')
			echo "Installing apache"
			sudo apt-get -y install apache2
			sudo a2enmod vhost_alias
			sudo a2enmod rewrite
			sudo service apache2 start
			sudo update-rc.d apache2 defaults
			sudo update-rc.d apache2 enable
		;;
		'mysql')
			echo "Installing mysql"
			echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
			echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
			sudo apt-get -y update
			sudo apt-get -y install mysql-client mysql-server
			sudo service mysql restart
			sudo update-rc.d mysql defaults
			sudo update-rc.d mysql enable
		;;
		'php') 
			echo "Installing php"
			sudo apt-add-repository -y ppa:ondrej/php
			sudo apt-get -y update
			sudo apt-get -y install php5.6 php5.6-curl php5.6-mysql php5.6-xml php5.6-json php5.6-mcrypt php-xdebug php5.6-mbstring libapache2-mod-php5.6
			# sudo apt-get -y install php7.0 libapache2-mod-php7.0
			sudo service apache2 reload
		;;
		'composer')
			echo "Installing composer"
			if [ ! -f "/usr/local/bin/composer" ]; then
				curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
			fi
		;;
		'elasticsearch')
			sudo apt-get install elasticsearch -y
			sudo sed -i 's/#START_DAEMON/START_DAEMON/' /etc/default/elasticsearch
			sudo service elasticsearch restart
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
