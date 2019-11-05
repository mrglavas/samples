# Installing a legacy component sample

Applications can include legacy and cloud-native components. During application modernization scenarios, different parts of a monolithic application can either be transformed into cloud-native components or replaced by them.
 

# Overview 

The sample `legacyapp` application consists of two legacy components. The `webapp` component runs on a stand-alone WebSphere Liberty server that runs on a virtual machine. The `helloworld` component runs on a JBoss server that also runs on a virtual machine.

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/overview.jpg)

  An application that is modernized usually contains legacy and cloud-native components. For more information, see the [PRISM demonstration](https://www.youtube.com/watch?v=Air32LCcj0c&feature=youtu.be).

# Prerequisites



   1. [Install kAppNav](https://github.com/kappnav/README).
   1. [Install WebSphere Liberty](https://developer.ibm.com/wasdev/downloads/#asset/runtimes-wlp-webProfile8) to create the default server.  

      > **Important**: You must have a Java Runtime Environment that is installed separately.

      1. Create and start the default server with the following commands: 

      ```
      $LIBERTY_HOME/bin/server create
      $LIBERTY_HOME/bin/server start 
      ```

      2. Install the WebSphere Liberty server on a VM that is network accessible with the Kubernetes cluster that runs Kubernetes Application Navigator.
          * You can also use [OpenLiberty](https://openliberty.io/).
 

   1. [Install JBoss EAP 7.2](https://developers.redhat.com/products/eap/download?sc_cid=701f2000000RmA9AAK&gclid=EAIaIQobChMIwaCv_6v35AIV0cDACh3ZUAIDEAAYASAAEgLzifD_BwE&gclsrc=aw.ds).

      > **Important**: You must have a Java Runtime Environment that is installed separately.

      * Install the JBoss server on a VM that is network accessible from the Kubernetes cluster that runs Kubernetes Application Navigator. 
      > **Important**: You must configure the JBOSS stand-alone server to listen on all interface to be accessible for the sample. 

      * Make the following change to the `$JBOSS_HOME/standalone/configuration/standalone.xml` file: 
      
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

       Use the following command to start the stand-alone server: 

      ```
      $JBOSS_HOME/bin/standalone.sh 
      ```
    1. [Install a helloworld sample application](https://developers.redhat.com/products/eap/hello-world#fndtn-macos).

       * Use a stand-alone WebSphere Liberty server to run the `helloworld` sample.

# Installing the sample application

1. Install a Liberty stand-alone application

   ```
   git clone https://github.com/kappnav/samples.git
   cd kappnav/samples/legacyapp/liberty
   ./install.sh \<hostname\>
   ```

   Hostname is the hostname of the VM that you installed and started the WebSphere Liberty server with.

1. Install a JBoss application.

   ```
   cd ../jboss
   ./install.sh \<hostname\>
   ```
   
   Hostname is the hostname of the VM that you installed and started the JBoss server with and hosts the `helloworld` sample.
   

# Uninstalling the sample application

Use the following `uninstall.sh` scripts to uninstall the sample application with Kubernetes: 

```
cd kappnav/samples/legacyapp/liberty
./uninstall.sh 
```

```
cd ../jboss
./uninstall.sh 
```
