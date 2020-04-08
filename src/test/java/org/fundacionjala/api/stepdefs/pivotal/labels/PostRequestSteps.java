package org.fundacionjala.api.stepdefs.pivotal.labels;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.apache.commons.lang3.StringUtils;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;
import org.fundacionjala.api.utils.Mapper;
import org.testng.Assert;

import java.io.File;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;

public class PostRequestSteps {

    private Helper helper;
    private Response response;

    public PostRequestSteps(final Helper helper) {
        this.helper = helper;
    }

    @When("I send a {string} request to {string} with the next json body")
    public void saveRequestToDelete(final String httpMethod, final String endPoint, final String jsonBody) {
        RequestSpecification requestSpecification = (RequestSpecification) helper.get("REQUEST_SPEC");
        String endPointBuilt = Mapper.getEndPointBuilt(helper.getResponseMap(), endPoint);
        String builtEndpoint = Mapper.replaceData(helper.getData(), endPointBuilt);
        response = RequestManager.doRequest(httpMethod, requestSpecification, builtEndpoint,
                Mapper.replaceData(helper.getData(), jsonBody));
        helper.set("LAST_ENDPOINT", builtEndpoint);
        helper.set("LAST_RESPONSE", response);
    }

    @Then("I save the request to delete")
    public void saveResponse() {
        String lastEndpoint = (String) helper.get("LAST_ENDPOINT");
        String lastResponseId = ((Response) helper.get("LAST_RESPONSE")).jsonPath().getString("id");
        String finalEndpoint = String.format("%s/%s", lastEndpoint, lastResponseId);
        helper.addEndpoint(finalEndpoint);
    }

    @Then("I validate the response status code, should be {int}")
    public void validateResponseStatusCoce(final int statusCode) {
        Assert.assertEquals(statusCode, response.getStatusCode());
    }

    @Then("The Response body should match with {string} json schema")
    public void validateJsonSchema(final String pathSchema) {
        File schemaFile = new File(pathSchema);
        response.then().assertThat().body(matchesJsonSchema(schemaFile));
    }

    @Then("The Response contains should be:")
    public void validateExcpectedResponseBody(final Map<String, String> expectedBodyValues) {
        Map<String, Object> responseMap = response.jsonPath().getMap(".");
        for (Map.Entry<String, String> data : expectedBodyValues.entrySet()) {
            if (responseMap.containsKey(data.getKey())) {
                Assert.assertEquals(String.valueOf(responseMap.get(data.getKey())),
                                    StringUtils.lowerCase(data.getValue()));
            }
        }
    }

    @Then("The Response contains should not be:")
    public void validateNotExpectedResponseBody(final Map<String, String> notExpectedBodyValues) {
        Map<String, Object> responseMap = response.jsonPath().getMap(".");
        for (Map.Entry<String, String> data : notExpectedBodyValues.entrySet()) {
            if (responseMap.containsKey(data.getKey())) {
                Assert.assertNotEquals(String.valueOf(responseMap.get(data.getKey())),
                                       StringUtils.lowerCase(data.getValue()));
            }
        }
    }

    @And("I store the response as {string}")
    public void storeResponse(final String key) {
        helper.addResponse(key, response);
    }
}
