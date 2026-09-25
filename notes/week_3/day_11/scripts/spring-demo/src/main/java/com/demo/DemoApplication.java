package com.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import java.util.List;
import java.util.Map;

@SpringBootApplication
@RestController
public class DemoApplication {

    @Autowired
    private JdbcTemplate jdbc;

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping("/health")
    public String health() {
        return "ok";
    }

    @GetMapping("/customer/{name}")
    public List<Map<String, Object>> customer(@PathVariable String name) {
        return jdbc.queryForList(
            "SELECT id, name, email FROM customers WHERE name = ?", name
        );
    }
}   