#!/bin/bash

set -e

new_ver=$1

echo "new versio: $new_ver"

docker tag nginx:1.23.3 ccoepol/nginx:$new_ver

docker tag nginx:1.23.3 ccoepol/nginx:$new_ver

temp_dir=$(mktemp -d)
echo $temp_dir

git clone git@github.com:Anisrahmanm/argocd-app-of-apps-tt.git $temp_dir

sed -i '' -e "s/ccoepol\nginx:.*/ccoepol\/nginx:$new_ver/g" $temp_dir/my-app/1-deployment.yaml

cd $temp_dir
git add .
git commit -m "Update image to $new_ver"
git push

rm -rf $temp_dir
