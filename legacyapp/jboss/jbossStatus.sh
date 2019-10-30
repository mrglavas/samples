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

if [ x$JBOSS_CONTROLLER == 'x' ]; then 
    # set this env var for local testing
	JBOSS_CONTROLLER=/jboss-controller
fi	
while true 
do
    kubectl get jboss-apps --all-namespaces | while read l; do 
        namespace=$(echo $l | awk '{ print $1 }')
        name=$(echo $l | awk '{ print $2 }')
        if [ $namespace != 'NAMESPACE' ]; then
            echo check status for jboss-app $name in namespace $namespace 
            kubectl get jboss-app $name -n $namespace -o json | node $JBOSS_CONTROLLER/checkStatus.js | kubectl apply -f -
            rc=$?
            if [ $rc != 0 ]; then
                echo Could not update jboss-app $name in namespace $namespace - rc=$rc 
            fi
        fi
    done

    sleep 5 

done 
