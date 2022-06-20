 ARG VERSION=0.0.0.1
 
 FROM adoptopenjdk/openjdk11:ubi
 
 WORKDIR /
 
 ENV CF_PROXY_VERSION=3.1.0
 
 ADD root/demo-apps/cf-proxy2/target/cf-proxy2-$CF_PROXY_VERSION-SNAPSHOT.jar cf-proxy2.jar
 ADD CaliforniumProxy3.properties

 EXPOSE 5684
 
 CMD java -jar cf-proxy2.jar ExampleCrossProxy2 coap
 