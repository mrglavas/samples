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
# syntax:  install.sh <hostname> <port>
# hostname cannot be localhost
# hostname must be dot-qualified hostname - e.g. myhost.com
# port default value is 9080
hostname=$1
port=$2

if [ x$hostname == x ]; then
	echo Must specify hostname
	exit 1 
fi

if [ x$port == x ]; then
	echo Port defaulted to 9080
	port="9080"
fi

kubectl apply -f liberty-sa-app-CRD.yaml 
kubectl create namespace legacyapp
kubectl apply -f application.yaml -n legacyapp
cat webapp1.yaml | sed "s|HOSTNAME|$hostname|" | sed "s|PORT|$port|" | kubectl apply -f - -n legacyapp
kubectl apply -f configmap.action.liberty-sa-app.yaml -n kappnav
kubectl apply -f configmap.status-mapping.liberty-sa-app.yaml -n kappnav
kubectl create namespace liberty-controller
kubectl apply -f liberty-controller.yaml -n liberty-controller