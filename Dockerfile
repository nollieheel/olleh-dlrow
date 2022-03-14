# Build the JAR
FROM amazoncorretto:17.0.2-alpine3.15 as builder
ARG HDIR=/home/spring
RUN addgroup -S spring && adduser -S spring -G spring

WORKDIR ${HDIR}
USER spring:spring

ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"
COPY --chown=spring:spring . ./
RUN ./gradlew build --no-daemon

# Run the JAR
FROM amazoncorretto:17.0.2-alpine3.15
ARG HDIR=/home/spring
RUN addgroup -S spring && adduser -S spring -G spring

WORKDIR ${HDIR}
USER spring:spring

COPY --from=builder --chown=spring:spring ${HDIR}/build/libs/ollehdlrow-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE 8080/tcp
ENTRYPOINT ["java","-jar","./app.jar"]
