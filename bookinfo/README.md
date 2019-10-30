# BookInfo Sample

Follow these instructions to install the BookInfo sample application.

# Install

1. Clone the sample repository: `git clone https://github.com/kappnav/samples.git`
1. Create the bookinfo sample namespace: `kubectl create namespace bookinfo`
   * The namespace will be created:
   ```
   # kubectl create namespace bookinfo
   namespace/bookinfo created
   ```
1. Deploy the BookInfo sample application: `kubectl create -f samples/bookinfo -n bookinfo`
   * The application will be created:
   ```
   # kubectl create -f samples/bookinfo -n bookinfo
   application "bookinfo" created
   ingress "gateway" created
   application "details-app" created
   service "details" created
   deployment "details-v1" created
   application "productpage-app" created
   service "productpage" created
   deployment "productpage-v1" created
   networkpolicy "productpage-egress" created
   application "ratings-app" created
   service "ratings" created
   deployment "ratings-v1" created
   networkpolicy "reviews-egress" created
   application "reviews-app" created
   service "reviews" created
   deployment "reviews-v1" created
   deployment "reviews-v2" created
   deployment "reviews-v3" created
   ```
1. Ensure the BookInfo application has started.
   * You can watch the application be deployed in the kAppNav UI. The BookInfo application will appear and the status will go from Unknown, to Problem, then to Normal.
   * You can also check the install progress with `kubectl get pods -n bookinfo`
   * All pods should be runnning:
   ```
   # kubectl get pods -n bookinfo
   NAME                              READY     STATUS    RESTARTS   AGE
   details-v1-5f476fb494-mqb4t       1/1       Running   0          29s
   productpage-v1-5bf49cd846-9z6hd   1/1       Running   0          29s
   ratings-v1-76bb9ff569-kchls       1/1       Running   0          29s
   reviews-v1-5dcbcf4fbb-p2rpg       1/1       Running   0          29s
   reviews-v2-54dbcc67b5-2zsh9       1/1       Running   0          29s
   reviews-v3-856b8db896-nn8qc       1/1       Running   0          29s
   ```

