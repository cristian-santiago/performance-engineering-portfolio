Connect the Spring Boot app in Docker to the Oracle XE 

Using this structure in the week_3:day_11

spring-demo/
├── pom.xml
├── src/main/java/com/demo/DemoApplication.java
└── src/main/resources/application.properties

Adding Dependencies

spring-boot-starter-web: A convenient starter dependency for building web applications and REST APIs using Spring Boot

spring-boot-starter-jdbc: Spring Boot starter dependency that provides all the necessary library to connect and interact with relational DB using JDBC (Java Database Connectivity)

ojdbc11: Oficial Oracle Database JDBC drive compiled for using with modern Java application

Properties Configuration (/src/main/resources/application.properties)

spring.datasource.url=jdbc:oracle:thin:@oracle-xe:1521/XEPDB1
spring.datasource.username=system
spring.datasource.password=Oracle123
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver

Endpoint Configuration (DemoApplication.Java)

@GetMapping("/customer/{name}")
public List<Map>String, Object>> customer(@PathVariable String name) {
    return jdbc.queryForList(
        "SELECT id, name, email FROM customers WHERE name = ?", name
        );
}

Set the Docker Network
Both containers must be in the same Network to assure the communication through the name.

--
docker network create pe-net
docker network connect pe-net oracle-xe
docker run --rm -it -p 8080:8080 --network pe-net -v "$(pwd)":/app -w /app eclipse-temurin:17 java -jar target/spring-demo-0.0.1-SNAPSHOT.jar
--

How to test 

curl http://localhost:8080/customer/User%205000
