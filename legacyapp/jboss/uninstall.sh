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

kubectl delete -f jboss-controller.yaml -n jboss-controller
kubectl delete namespace jboss-controller
kubectl delete -f application.yaml -n legacyapp
kubectl delete -f helloworld.yaml -n legacyapp
kubectl delete -f configmap.action.jboss-app.helloworld.yaml -n legacyapp
kubectl delete namespace legacyapp
kubectl delete -f configmap.status-mapping.jboss-app.yaml -n kappnav 
kubectl delete -f configmap.action.jboss-app.yaml -n kappnav 
kubectl delete -f jboss-app-CRD.yaml 