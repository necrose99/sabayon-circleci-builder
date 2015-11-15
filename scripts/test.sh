#!/bin/bash

set -o nounset
set -o errexit

docker run -e BUILDER_PROFILE -e BUILDER_JOBS -e PRESERVED_REBUILD -e EMERGE_DEFAULTS_ARGS -e USE_EQUO \
		-v $CIRCLE_ARTIFACTS/:/usr/portage/packages \
		-v "$HOME/$CIRCLE_PROJECT_REPONAME"/conf/custom.keywords:/opt/sabayon-build/conf/intel/portage/package.keywords/custom.keywords \
		-v "$HOME/$CIRCLE_PROJECT_REPONAME"/conf/custom.unmask:/opt/sabayon-build/conf/intel/portage/package.unmask/custom.unmask \
		-v "$HOME/$CIRCLE_PROJECT_REPONAME"/conf/custom.env:/opt/sabayon-build/conf/intel/portage/package.env/custom.env \
		-v "$HOME/$CIRCLE_PROJECT_REPONAME"/conf/custom.mask:/opt/sabayon-build/conf/intel/portage/package.mask/custom.mask \
		-v "$HOME/$CIRCLE_PROJECT_REPONAME"/conf/custom.use:/opt/sabayon-build/conf/intel/portage/package.use/custom.use \
		-t sabayon/builder-amd64 $BUILD_ARGS || true

docker commit $(docker ps -aq | xargs echo | cut -d ' ' -f 1) sabayon/builder-amd64
