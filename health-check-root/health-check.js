const fastify = require("fastify")({
  logger: true,
  ignoreTrailingSlash: true,
});

fastify.get("/health", function (request, reply) {
  console.log("healthcheck");
  reply.send({ status: "OK" });
});

fastify.listen({ port: 8080, host: "0.0.0.0" }, function (err, address) {
  if (err) {
    fastify.log.error(err);
    process.exit(1);
  }
  console.log(`Server is now listening on ${address}`);
});
