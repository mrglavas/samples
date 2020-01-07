#!/bin/bash
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
arg=$1
# make sure running in build directory 
if [ $(echo $PWD | awk '{ n=split($0,d,"/"); print d[n] }') != 'samples' ]; then 
    echo 'Error: $kappnav/sample dir must be current dir.'
    echo ''
    arg="--?"
fi

if [ x$arg == x'--?' ]; then
    echo "Install {k}AppNav samples from current directory."
	echo 
	echo "syntax:" 
	echo 
	echo "install.sh [sample list]"
	echo 
	echo "E.g. 'install.sh stocktrader bookinfo'.  Default is all samples."
    echo 
    echo "Available samples:"
    for d in $(ls); do 
        if [ -d $d ]; then 
            echo $d 
        fi
    done
	exit 1
fi

# install samples 

samples=''
if [ x$arg != 'x' ]; then
    samples=$@
else
    for d in $(ls); do 
        if [ -d $d ]; then 
            samples="$samples $d" 
        fi
    done
fi

for s in $samples; do
    nsf=$s/'NAMESPACE' 
    if [ -e $nsf ]; then 
        ns=$(cat $nsf)
    else
        ns='default'
    fi
    echo Install sample $s to namespace $ns
    kubectl create namespace $ns 
    echo kubectl apply -f $s -n $ns 
    kubectl apply -f $s -n $ns 
done