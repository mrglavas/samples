/*
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
*/

const yaml = require('js-yaml');
const getStdin = require('get-stdin');

function getStatus(jboss, callback) { 

  var host= jboss.metadata.annotations.host; 
  var port= jboss.metadata.annotations['app-port']; 

  var timeout= false; 

  const https = require('http')
  var options = {
    hostname: host,
    port: port,
    path: '/',
    method: 'GET',
    timeout: 1000
  }

  console.warn("Test jboss connection on "+host+":"+port);

  const req = https.request(options, res => {
    if ( res.statusCode == '200' ) { 
      jboss.status={}
      jboss.status.connection='ok';
      console.warn(new Date() + " connection is ok for "+jboss.metadata.name+" in namespace "+jboss.metadata.namespace);
	    callback(jboss)
    }
    else {
      jboss.status={}
      jboss.status.connection='error';
      console.warn(new Date() + " connection is in error for "+jboss.metadata.name+" in namespace "+jboss.metadata.namespace);
	    callback(jboss);
    }
  })

  req.on('error', error => {
    jboss.status={}
    if ( timeout ) { 
      console.warn(new Date() + " connection timed out for "+jboss.metadata.name+" in namespace "+jboss.metadata.namespace);
      jboss.status.connection='timeout';
    }
    else { 
      console.warn(new Date() + " connection is in error for "+jboss.metadata.name+" in namespace "+jboss.metadata.namespace);
      jboss.status.connection='error';
    }
    callback(jboss);
  })

  req.on('timeout', () => {
    timeout=true; 
    req.abort();
  })

  req.end()

}

(async () => {
  var stdin= await getStdin(); 

  try {
    var jboss= JSON.parse(stdin);
    getStatus(jboss,(jboss) => {console.log(JSON.stringify(jboss))});
  } catch (e) {
    console.warn(e);
    process.exit(1); 
  }
})();