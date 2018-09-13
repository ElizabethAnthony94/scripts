# Shell script to delete images from GCP whose number of images for a specific prefix is greater than 51
## Requirements:
-	GCLOUD CLI installed and configured with appropriate permissions to delete images
-   ACCOUNT : Email ID for login into GCP account
-   PROJECT : Project name from which you need to delete images

## Example:
```
./SCRIPT.sh
```

## Usage:
1. Specify the prefixes in the script according to your requirements 
2. When you run the script, it will:
	- Get the number of images for a specific prefix
	- Check if the images count is greater than 51
  If YES:
	- Get a list of existing images for a specific prefix sorted by creation time
	- Get the image names
  - Delete the images
  If NO:
  - Proceed with other image prefix

## Notes:
- The script should work in single run. If not, run it again as it is safe to do.
