#!/bin/bash


if [ -n "$BUILD_ARGS" ]; then
docker run \
	-e BUILDER_PROFILE -e BUILDER_JOBS -e PRESERVED_REBUILD -e EMERGE_DEFAULTS_ARGS \
	-v $CIRCLE_ARTIFACTS/:/usr/portage/packages \
	-v custom.mask:/etc/portage/package.mask/custom.mask \
        -v custom.use:/etc/portage/package.use/custom.use \
        -v custom.keywords:/etc/portage/package.keywords/custom.keywords \
        -v custom.unmask:/etc/portage/package.unmask/custom.unmask \
        -v custom.env:/etc/portage/package.env/custom.env \
	-t sabayon/builder-amd64 $BUILD_ARGS
fi

