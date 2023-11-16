#!/bin/sh -eux

BRANCH="v2.2.0"
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/$BRANCH/aqua-installer | bash
