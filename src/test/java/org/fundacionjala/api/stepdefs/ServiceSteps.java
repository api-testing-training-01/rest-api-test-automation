package org.fundacionjala.api.stepdefs;

import io.cucumber.java.en.Given;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.utils.Helper;
import org.fundacionjala.api.utils.RequestSpecFactory;

public class ServiceSteps {

    private Helper helper;

    public ServiceSteps(final Helper helper) {
        this.helper = helper;
    }

    @Given("I use the {string} service and the {string} account")
    public void iUseTheService(final String serviceName, final String accountName) {
        RequestSpecification requestSpecification = RequestSpecFactory.getRequestSpec(serviceName, accountName);
        helper.set("REQUEST_SPEC", requestSpecification);
    }
}
