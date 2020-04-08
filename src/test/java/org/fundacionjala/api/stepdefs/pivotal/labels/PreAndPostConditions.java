package org.fundacionjala.api.stepdefs.pivotal.labels;

import io.cucumber.java.After;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;

import java.util.List;

public class PreAndPostConditions {
    private Helper helper;

    public PreAndPostConditions(final Helper helper) {
        this.helper = helper;
    }

    @After(value = "@deleteProject")
    public void deleteProject() {
        RequestSpecification requestSpec = (RequestSpecification) helper.get("REQUEST_SPEC");
        List<String> endpoints = helper.getEndpoints();
        for (String endpoint : endpoints) {
            RequestManager.delete(requestSpec, endpoint);
        }
    }
}
