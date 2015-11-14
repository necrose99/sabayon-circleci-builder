#!/bin/bash

set -o nounset
set -o errexit


git clone git://github.com/Sabayon/build.git ~/sabayon-build
mv ~/sabayon-build/conf/intel/portage ~/portage
pushd ~/portage
mv make.conf.amd64 make.conf
mv package.env.amd64 package.env
popd
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.keywords ~/portage/package.keywords/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.unmask ~/portage/package.unmask/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.env ~/portage/package.env/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.mask ~/portage/package.mask/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.use ~/portage/package.use/
cat "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.make >> ~/portage/make.conf

pwd

ls -liah "$HOME/$CIRCLE_PROJECT_REPONAME"
echo "$HOME/$CIRCLE_PROJECT_REPONAME"
docker run -e BUILDER_PROFILE -e BUILDER_JOBS -e PRESERVED_REBUILD -e EMERGE_DEFAULTS_ARGS \
-v $CIRCLE_ARTIFACTS/:/usr/portage/packages \
-v $HOME/portage:/etc/portage \
-t sabayon/builder-amd64 $BUILD_ARGS

#-v $HOME/portage:/opt/sabayon-build/conf/intel/portage \

#
