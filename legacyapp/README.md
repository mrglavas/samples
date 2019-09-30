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
1.1. install kAppNav 
1.1. install WebSphere Liberty and create default server 
1.1. install JBoss and install helloworld sample application 
1. install Liberty 
1. install JBoss
