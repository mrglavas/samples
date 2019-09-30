# Legacy Component Sample

Applications can include legacy components as well as new, cloud native components.  This is common during application modernization scenarios, where parts of a monolith are transformed to, or replaced by, cloud native components. This [short video](https://www.youtube.com/watch?v=Air32LCcj0c&feature=youtu.be) demonstrates an actual example, based on the stocktrader application. 

The sample in this repository demonstrates how you can represent and include legacy components as part of your application, as displayed by Kubernetes Application Navigator. 

# Overview 

In this sample, we will assume a fictious application named 'legacyapp', comprised of two legacy components.  One component is a webapp running on a standalone WebSphere Liberty server, running on a virtual machine; the second component is a webapp (helloworld) running on a JBoss server, also running on a virtual machine. The following diagram depicts our sample application:

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/overview.jpg)

Our sample application, 'legacyapp', shows depicts an application comprised of only legacy components.  This is for illustrative purposes only. In typical circumstances, an application undergoing modernization is more likely to be comprised of by legacy (un-modernized) and cloud native (modernized) components.  The Application custom resource definition used by kAppNav fully supports this. 

# Install 

To install and explore the sample, perform the following steps: 

1. pre-reqs 
   1. [install kAppNav](https://github.com/kappnav/README).
   1. [install WebSphere Liberty](https://developer.ibm.com/wasdev/downloads/#asset/runtimes-wlp-webProfile8) and create default server.  

      Create and start default server with these commands: 

      ```
      $LIBERTY_HOME/bin/server create
      $LIBERTY_HOME/bin/server start 
      ```

      Be sure to install the WebSphere Liberty server on a VM that is network accessible from the Kubernetes cluster running kAppNav. Note you can alternatively use [OpenLiberty](https://openliberty.io/). 

   1. [install JBoss EAP 7.2](https://developers.redhat.com/products/eap/download?sc_cid=701f2000000RmA9AAK&gclid=EAIaIQobChMIwaCv_6v35AIV0cDACh3ZUAIDEAAYASAAEgLzifD_BwE&gclsrc=aw.ds) and [install helloworld sample application](https://developers.redhat.com/products/eap/hello-world#fndtn-macos).

      Be sure to install the JBoss server on a VM that is network accessible from the Kubernetes cluster running kAppNav. Also be sure to use standalone server to run the helloworld sample. Note you must tweak the JBOSS standalone server to listen on all interfaces in order to be accessible for this sample. Make the following change to $JBOSS_HOME/standalone/configuration/standalone.xml: 

      From: 
      ```
      <interfaces>
        <interface name="management">
            <inet-address value="${jboss.bind.address.management:127.0.0.1}"/>
        </interface>
        <interface name="public">
            <inet-address value="${jboss.bind.address:127.0.0.1}"/>
        </interface>
      </interfaces>
      ```

      To: 
      ```
      <interfaces>
        <interface name="management">
            <any-address/>
        </interface>
        <interface name="public">
            <any-address/>
        </interface>
      </interfaces>
      ```

      Finally, start the standlone server using this command: 

      ```
      $JBOSS_HOME/bin/standalone.sh 
      ```

1. install Liberty Standalone App 

   ```
   git clone https://github.com/kappnav/samples.git
   cd kappnav/samples/legacyapp/liberty
   ./install.sh \<hostname\>
   ```

   Where hostname is the hostname of the VM on which you installed and started the WebSphere Liberty server. 

1. install JBoss App

   ```
   cd ../jboss
   ./install.sh \<hostname\>
   ```
   
   Where hostname is the hostname of the VM on which you installed and started the JBoss server, hosting the helloworld sample.


