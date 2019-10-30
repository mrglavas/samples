const app = require('express')()

app.get('/', (req, res) => {
  payload = "<html><head><title>Streaming API - kAppNav Sample App</title></head>" +
            "<body>" +
            "<h1>Streaming API</h1>"+
            "The 'streaming-api' microservice developed by the API team, part of the 'music-service' application" +
            "</body>" +
            "<footer><p><a href='https://github.com/kappnav/samples/'>kAppNav - sample application</a></p></footer>" +
            "</html>";
  res.send(payload);
});
 
module.exports.app = app;
