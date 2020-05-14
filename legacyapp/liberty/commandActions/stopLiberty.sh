###############################################################################
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
# limitations under the License.
###############################################################################

echo Stopping Liberty

host=$1
user=$2
password=$3
libertydir=$4
servername=$5

sshpass -p ''$password'' ssh -o StrictHostKeyChecking=no $user@$host ''sh $libertydir/bin/server stop $servername''
