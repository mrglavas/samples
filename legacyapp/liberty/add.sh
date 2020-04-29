###############################################################################
# Copyright 2019 IBM Corporation
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
# limitations under the License.
###############################################################################
# syntax:  install.sh <servername> <hostname> <port>
# hostname cannot be localhost
# hostname must be dot-qualified hostname - e.g. myhost.com
# port default value is 9080
servername=$1
hostname=$2
port=$3

if [ x$servername == x ]; then
	echo Must specify servername
	exit 1 
fi

if [ x$hostname == x ]; then
	echo Must specify hostname
	exit 1 
fi

if [ x$port == x ]; then
	echo Port defaulted to 9080
	port="9080"
fi

cat webapp.yaml | sed "s|SERVERNAME|$servername|" | sed "s|HOSTNAME|$hostname|" | sed "s|PORT|$port|" | kubectl apply -f - -n legacyapp
