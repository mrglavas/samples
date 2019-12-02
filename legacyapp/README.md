# Installing a legacy component sample

Applications can include legacy components as well as new, cloud native components.  This is common during application modernization scenarios, where parts of a monolith are transformed to, or replaced by, cloud native components. This [short video](https://www.youtube.com/watch?v=h833ZN8KQy0&feature=youtu.be) demonstrates an actual example, based on the stocktrader application. 

The sample in this repository demonstrates how you can represent and include legacy components as part of your application, as displayed by Kubernetes Application Navigator. 

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

       * Use a stand-alone WebSphere Liberty server to run the `helloworld` sample application.

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
   
 # The legacyapp sample as viewed through Kubernetes Application Navigator.

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/applications.jpg)

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/components.jpg)

# Stopping components 

If you stop the WebSphere Liberty and JBoss servers, Kubernetes Application Navigator updates the status to show that the components are down:

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/stopped.jpg)

# Selecting actions 

On the component view page, you can select pre-defined actions to perform in the context of the selected component: 

## Liberty stand-alone application action - View home page 

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/liberty-action.jpg)

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/liberty-home.jpg)

## JBoss application actions

### Viewing the application configuration

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/jboss-view-config.jpg)

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/jboss-config.jpg)

### Viewing the server metrics 

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/jboss-view-metrics.jpg)

![overview](https://github.com/kappnav/samples/blob/master/legacyapp/images/jboss-metrics.jpg)

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
