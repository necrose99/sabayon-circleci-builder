#!/bin/bash

set -o nounset
set -o errexit


git clone git://github.com/Sabayon/build.git ~/sabayon-build
pushd ~/sabayon-build/conf/intel/portage
mv make.conf.amd64 make.conf
mv package.env.amd64 package.env
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.keywords ./package.keywords/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.unmask ./package.unmask/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.env ./package.env/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.mask ./package.mask/
cp -rfv "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.use ./package.use/
cat "$HOME/$CIRCLE_PROJECT_REPONAME"/custom.make >> ./make.conf
popd

ls -liah "$HOME/$CIRCLE_PROJECT_REPONAME"
ls -liah ~/sabayon-build
docker run -e BUILDER_PROFILE -e BUILDER_JOBS -e PRESERVED_REBUILD -e EMERGE_DEFAULTS_ARGS \
-v $CIRCLE_ARTIFACTS/:/usr/portage/packages \
-v $HOME/sabayon-build:/opt/sabayon-build \
-t sabayon/builder-amd64 $BUILD_ARGS

#-v $HOME/portage:/opt/sabayon-build/conf/intel/portage \

#
