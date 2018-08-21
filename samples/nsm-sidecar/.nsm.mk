# Copyright (c) 2018 Cisco and/or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file includes definitions for Docker images used by the Makefile
# and docker build infrastructure. It also contains the targets to build
# and push Docker images

DOCKER_DATAPLANE=networkservicemesh/sidecar-dataplane

#
# Target to build docker image
#
.PHONY: docker-build-sidecar-dataplane
docker-build-sidecar-dataplane: docker-build-release
	@${DOCKERBUILD} -t ${DOCKER_DATAPLANE} -f build/Dockerfile .
#
# Targets to push docker images
#

.PHONY: docker-login
docker-login:
	@echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

.PHONY: docker-push-sidecar-dataplane
docker-push-sidecar-dataplane: docker-login
	@if [ "x${TRAVIS_TAG}" != "x" ] ; then \
		export REPO=${DOCKER_DATAPLANE} ;\
		docker tag ${REPO}:${COMMIT} ${REPO}:${TRAVIS_TAG} ;\
		docker tag ${REPO}:${COMMIT} ${REPO}:travis-${TRAVIS_BUILD_NUMBER} ;\
		docker push $REPO
	fi