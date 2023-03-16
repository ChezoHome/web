FROM arm64v8/amazoncorretto:17
ADD . .
CMD java -jar build/libs/ContainerTest-0.0.1-SNAPSHOT.jar