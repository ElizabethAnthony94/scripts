#!/bin/bash

# A shell script to add a virtual host entry and enable SSL settings
# Usage: ./addvhost.sh cert key dest
#

# Specify site SSL details
site_url=$1
cert=$2
key=$3
dest=$4

# Get default aws region
source /etc/apache2/awsdetails.cfg
region=$details_region

# Copy the SSL certificate and key file to local folder
aws s3 cp $cert /home/ubuntu/certi/$dest/ --region $region
ssl_cert=/home/ubuntu/certi/$dest/${cert##*/}
aws s3 cp $key /home/ubuntu/certi/$dest/ --region $region
ssl_key=/home/ubuntu/certi/$dest/${key##*/}

# Set paths
current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
hosts_path="/etc/hosts"
vhosts_path="/etc/apache2/sites-available/"
vhost_skeleton_path="$current_directory/vhost_ssl.skeleton.conf"
web_root="/var/www/html/"

# update vhost
vhost=`cat "$vhost_skeleton_path"`
vhost=${vhost//@site_url@/$site_url}
vhost=${vhost//@site_docroot@/$web_root}
vhost=${vhost//@ssl_cert@/$ssl_cert}
vhost=${vhost//@ssl_key@/$ssl_key}

# create vhost.conf
`touch $vhosts_path$site_url.conf`
echo "$vhost" > "$vhosts_path$site_url.conf"
echo "Updated vhosts in Apache config"

# update hosts file
echo 127.0.0.1    $site_url >> $hosts_path
echo "Updated the hosts file"

# enable site in apache
echo "Enabling site in Apache..."
echo `a2ensite $site_url`

# Enable SSL module
echo "Enabling SSL module"
echo `a2enmod ssl` 
echo "Process complete, check out the new site at https://$site_url"

exit 0