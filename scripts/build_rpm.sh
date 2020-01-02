#!/bin/sh
set -v
set -e

# Build process very much dislikes running as non-root so just minimize what we have to do as root
#
sudo mkdir -p /opt/chef
sudo chown $USER /opt/chef

cd ${repodir}/omnibus
${ruby_install_dir}/bin/bundle install --without development
${ruby_install_dir}/bin/bundle exec omnibus build --override base_dir:./local chef

# If we've gotten this far, a package and metadata json file will be under pkg/.
# Move the rpm into a location closely matching the repo it will wind up in
# so Evergreen can upload it to the correct place in s3

rpm=$(ls pkg/*.rpm)
metadata_file="$rpm.metadata.json"
arch=$(jq -r .arch "${metadata_file}")
platform_version=$(jq -r .platform_version "${metadata_file}")

# These correspond to s3 prefixes
if [[ -n $IS_PATCH ]]
then
  prefix="TESTRPMS-withlayout"
else
  prefix="RPMS-withlayout"
fi

rpmdir="${workdir}/${prefix}/${platform_version}/${arch}"

mkdir -p "${rpmdir}"
mv "${rpm}" "${rpmdir}/"
