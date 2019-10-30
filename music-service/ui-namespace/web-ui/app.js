const app = require('express')()

app.get('/', (req, res) => {
  payload = "<html><head><title>Web UI - kAppNav Sample App</title></head>" +
            "<body>" +
            "<h1>Web UI</h1>"+
            "The 'web-ui' microservice developed by the UI team, part of the 'music-service' application" +
            "</body>" +
            "<footer><p><a href='https://github.com/kappnav/samples/'>kAppNav - sample application</a></p></footer>" +
            "</html>";
  res.send(payload);
});
 
module.exports.app = app;
