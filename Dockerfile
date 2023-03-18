FROM arm64v8/amazoncorretto:17
WORKDIR /app

ARG JAR_FILE
CMD ${JAR_FILE} app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]