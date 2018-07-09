# Shell script to add a Apache virtual host entry and enable SSL settings

## Requirements:
-	AWS CLI configured
-	AWS access key, secret key and region specified in `/etc/apache2/awsdetails.cfg`
-	SSL cert and key file stored in S3
-   Copy `vhost_ssl.skeleton.conf` in the same directory where u place the script

## Example:
```
./SCRIPT.sh SITE_URL CERT KEY DESTINATION
```

## Usage:
1. Specify the AWS config details in a file
2. When you run the script, it will:
	- Copy the SSL certificate and key file from S3 to local folder
	- Update vhost by replacing the values passed to the script in the vhost_ssl.skeleton.conf and generate a new vhost file
	- Update hosts file
	- Enable the newly created site
	- Enable SSL module

## Notes:
- The script should work in single run. If not, run it again as it is safe to do.
