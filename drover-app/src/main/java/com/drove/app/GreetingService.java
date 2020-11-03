package com.drove.app;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GreetingService {

    public String greeting(String name) {
        return "Hello " + name + "! Welcome to Drover :)";
    }

}
