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

kubectl apply -f jboss-app-CRD.yaml 
kubectl apply -f application.yaml 
kubectl apply -f helloworld.yaml
kubectl apply -f configmap.action.jboss-app.helloworld.yaml
kubectl apply -f configmap.status-mapping.jboss-app.yaml -n kappnav 
kubectl apply -f configmap.action.jboss-app.yaml -n kappnav 
kubectl create namespace jboss-controller
kubectl apply -f jboss-controller.yaml -n jboss-controller