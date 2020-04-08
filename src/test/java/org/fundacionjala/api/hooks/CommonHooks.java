package org.fundacionjala.api.hooks;

import io.cucumber.java.After;

import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;

import java.util.List;


public class CommonHooks {

    private Helper helper;

    public CommonHooks(final Helper helper) {
        this.helper = helper;
    }

    @After(value = "@cleanData")
    public void afterScenario() {
        RequestSpecification requestSpec = (RequestSpecification) helper.get("REQUEST_SPEC");
        List<String> endpoints = helper.getEndpoints();
        for (String endpoint : endpoints) {
            RequestManager.delete(requestSpec, endpoint);
        }
    }
}
