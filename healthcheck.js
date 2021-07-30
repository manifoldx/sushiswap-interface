/**
 * @file healthcheck
 * @description healthcheck endpoint for service liveness and readiness
 * 
 */
const http = require("http");
const options = {
  host: "localhost",
  port: "3000",
  path: '/healthcheck', // must be the same as HEALTHCHECK in Dockerfile
  timeout: 2000,
};
const request = http.request(options, (res) => {
  console.log(`STATUS: ${res.statusCode}`);
  if (res.statusCode == 200) {
    process.exit(0);
  } else {
    process.exit(1);
  }
});
request.on("error", function (err) {
  console.log("ERROR", err);
  process.exit(1);
});
request.end();
/** @exports healthcheck */