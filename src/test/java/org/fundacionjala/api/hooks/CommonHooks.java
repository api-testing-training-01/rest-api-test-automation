package org.fundacionjala.api.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;
import org.testng.SkipException;

import java.util.List;

public class CommonHooks {

    private static final int SKIP_ORDER = 0;

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

    @Before(value = "@skipTest", order = SKIP_ORDER)
    public void skipScenario() {
        throw new SkipException("Scenario skipped.");
    }
}
