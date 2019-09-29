#*****************************************************************
#*
#* Copyright 2019 IBM Corporation
#*
#* Licensed under the Apache License, Version 2.0 (the "License");
#* you may not use this file except in compliance with the License.
#* You may obtain a copy of the License at

#* http://www.apache.org/licenses/LICENSE-2.0
#* Unless required by applicable law or agreed to in writing, software
#* distributed under the License is distributed on an "AS IS" BASIS,
#* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#* See the License for the specific language governing permissions and
#* limitations under the License.
#*
#*****************************************************************

# Stage 1: build using node
FROM node:8.11.4 as build

COPY *.sh /jboss-controller/
COPY *.js /jboss-controller/
COPY package.json /jboss-controller

RUN cd /jboss-controller; npm install

# Stage 2: Run node server
FROM registry.access.redhat.com/ubi7/nodejs-8:1-47

USER root
RUN yum -y remove mariadb-devel

# install kubectl

RUN  ARCH=$(uname -p) \
   && if [ "$ARCH" != "ppc64le" ] && [ "$ARCH" != "s390x" ]; then \
     ARCH="amd64" ; \
   fi \
   && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/${ARCH}/kubectl \
   && chmod ug+x ./kubectl \
   && mv ./kubectl /usr/local/bin/kubectl

COPY --from=build --chown=1001:0 /jboss-controller /jboss-controller 
COPY --from=build --chown=1001:0 /jboss-controller/node_modules /jboss-controller/node_modules/

RUN chmod -R 770 /jboss-controller/*.sh
USER 1001

CMD /jboss-controller/jbossStatus.sh