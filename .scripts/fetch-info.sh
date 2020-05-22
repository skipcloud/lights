#!/bin/sh -

dir=$(dirname $0)
info_dir=$dir/../.info
light_file=$info_dir/lights
scene_file=$info_dir/scenes
group_file=$info_dir/groups

die() {
  echo "error: $1" >&2
  exit 1 
}

if [ -z "$HUE_IP_ADDRESS" ]; then 
  die "HUE_IP_ADDRESS not set"
fi

if [ -z "$HUE_API_KEY" ]; then
  die "HUE_API_KEY not set"
fi

api=http://$HUE_IP_ADDRESS/api/$HUE_API_KEY

# GET to get data on light set up
resp=$(curl -si $api 2>&1 | sed 's/\r$//')
http_code=$(echo "$resp" | awk 'BEGIN { RS=""}; NR == 1 {print $2}')

# if not a 200 response then die
if [ "$http_code" != "200" ]; then
  die "Hue Bridge returning $http_code"
fi

# split the body from the HTTP headers
body=$(echo "$resp" | awk 'BEGIN { RS=""}; NR == 2')

# the API can return a 200 but also still return errors
# so check for errors before proceeding
err=$(echo "$body" | jq -e '.[].error.description')
if [ $? = 0 ]; then
  die "$err"
fi

[ ! -d $info_dir ] && mkdir $info_dir

# save various parts of information in the .info dir
echo $body | jq '.lights' > $light_file
echo $body | jq '.scenes' > $scene_file
echo $body | jq '.groups' > $group_file

echo "update complete"

