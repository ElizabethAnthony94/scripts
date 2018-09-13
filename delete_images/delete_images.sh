#!/bin/bash
#
#Shell script to delete images from GCP whose number of images for a specific prefix is greater than 51
#./scriptname region date
#./delete_images.sh
#

# Declare all the prefix prefix
declare -a arr=("web-tier-" "contacts-" "backup-" "web-" "app-" "infra-dns-" "infra-perf-" "jfrog-rp-" "infra-nat-" "api-gw-v2-" "asset" "cops-" "sport-")

# Now loop through the above array
for prefix in "${arr[@]}"
do
  # Get the number of images for a specific prefix
  IMAGES_COUNT="$(gcloud compute images list --filter="name~'.*${prefix}*.'"  | wc -l)"
  echo "Count of Images for $prefix : $IMAGES_COUNT"

  # Check if the images count is not zero and greater than 51
  if [ "$IMAGES_COUNT" -ne 0 ] && [ "$IMAGES_COUNT" -gt 1 ];
    then
    if [ "$IMAGES_COUNT" -gt 1 ];
      then
      count="$(bc -l <<< "$IMAGES_COUNT"-51)"
    fi

    # get a list of existing images for a specific prefix
    IMAGES_LIST="$(gcloud compute images list --filter="name~'.*${prefix}*.'" --sort-by=~creationTimestamp --uri | tail -n $count)"

    # loop through the images
    echo "${IMAGES_LIST}" | while read line ; do

    # get the image name from full URL that google returns
    IMAGE_NAME="${line##*/}"

    echo "To be deleted : ${IMAGE_NAME}"

    # delete the image
    echo "$(gcloud compute images delete ${IMAGE_NAME} --quiet)"

    done
  fi
done
