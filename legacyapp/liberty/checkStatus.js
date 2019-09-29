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

function getStatus(liberty, callback) { 

  var host= liberty.metadata.annotations.host; 
  var port= liberty.metadata.annotations.port; 
  var timeout= false; 

  const https = require('http')
  var options = {
    hostname: host,
    port: port,
    path: '/',
    method: 'GET',
    timeout: 1000
  }

  console.warn("Test Liberty connection on "+host+":"+port); 

  const req = https.request(options, res => {
    if ( res.statusCode == '200' ) { 
      liberty.status={}
      liberty.status.connection='ok';
      console.warn(new Date() + " connection is ok for "+liberty.metadata.name+" in namespace "+liberty.metadata.namespace);
	    callback(liberty)
    }
    else {
      liberty.status={}
      liberty.status.connection='error';
      console.warn(new Date() + " connection is in error for "+liberty.metadata.name+" in namespace "+liberty.metadata.namespace);
	    callback(liberty);
    }
  })

  req.on('error', error => {
    liberty.status={}
    if ( timeout ) { 
      console.warn(new Date() + " connection timed out for "+liberty.metadata.name+" in namespace "+liberty.metadata.namespace);
      liberty.status.connection='timeout';
    }
    else { 
      console.warn(new Date() + " connection is in error for "+liberty.metadata.name+" in namespace "+liberty.metadata.namespace);
      liberty.status.connection='error';
    }
    callback(liberty);
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
    var liberty= JSON.parse(stdin);
    getStatus(liberty,(liberty) => {console.log(JSON.stringify(liberty))});
  } catch (e) {
    console.warn(e);
    process.exit(1); 
  }
})();
