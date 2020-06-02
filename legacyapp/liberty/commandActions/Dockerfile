###########################################################################
# Copyright 2020 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# imitations under the License.
###########################################################################

FROM ubuntu

RUN apt-get update -y \
    && apt-get install -y sshpass

RUN mkdir /scripts

COPY startLiberty.sh /scripts
COPY stopLiberty.sh /scripts

RUN chmod +x /scripts/startLiberty.sh \
    && chmod +x /scripts/stopLiberty.sh
