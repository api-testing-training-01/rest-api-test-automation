package org.fundacionjala.api.stepdefs;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.apache.commons.lang3.StringUtils;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.config.JsonHelper;
import org.fundacionjala.api.utils.AllureUtils;
import org.fundacionjala.api.utils.Helper;
import org.fundacionjala.api.utils.Mapper;
import org.json.simple.JSONObject;
import org.testng.Assert;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;

public class RequestSteps {

    private Response response;
    private Helper context;
    private static final int[] OK_STATUS_CODE = {200, 201, 204};

    public RequestSteps(final Helper context) {
        this.context = context;
    }

    @Given("I send a {string} request to {string} with json body")
    public void iSendARequestToWithJsonBody(final String httpMethod, final String endpoint,
                                            final String jsonBody) {
        RequestSpecification requestSpecification = (RequestSpecification) context.get("REQUEST_SPEC");
        String builtEndpoint = Mapper.replaceData(context.getData(), endpoint);
        response = RequestManager.doRequest(httpMethod, requestSpecification, builtEndpoint,
                Mapper.replaceData(context.getData(), jsonBody));
        AllureUtils.attachStepContent("Request body:", jsonBody);
        context.set("LAST_ENDPOINT", builtEndpoint);
        context.set("LAST_RESPONSE", response);
    }

    @Given("I send a {string} request to {string} with json file {string}")
    public void iSendARequestToWithJsonFile(final String httpMethod, final String endpoint,
                                            final String jsonPath) {
        RequestSpecification requestSpecification = (RequestSpecification) context.get("REQUEST_SPEC");
        JSONObject jsonBody = JsonHelper.getJsonObject(jsonPath);
        String builtEndpoint = Mapper.replaceData(context.getData(), endpoint);
        response = RequestManager.doRequest(httpMethod, requestSpecification, builtEndpoint,
                Mapper.replaceData(context.getData(), jsonBody.toJSONString()));
        AllureUtils.attachStepContent("Request body:", jsonBody.toJSONString());
        context.set("LAST_ENDPOINT", builtEndpoint);
        context.set("LAST_RESPONSE", response);
    }

    @Given("I send a {string} request to {string} with datatable")
    public void iSendARequestTo(final String httpMethod, final String endpoint, final Map<String, String> body) {
        RequestSpecification requestSpecification = (RequestSpecification) context.get("REQUEST_SPEC");
        String builtEndpoint = Mapper.replaceData(context.getData(), endpoint);
        Map<String, String> bodyProcessed = Mapper.replaceBodyData(context.getData(), body);
        response = RequestManager.doRequest(httpMethod, requestSpecification, builtEndpoint, bodyProcessed);
        context.set("LAST_ENDPOINT", builtEndpoint);
        context.set("LAST_RESPONSE", response);
    }

    @When("I send a {string} request to {string}")
    public void iSendARequestTo(final String httpMethod, final String endpoint) {
        RequestSpecification requestSpecification = (RequestSpecification) context.get("REQUEST_SPEC");
        String builtEndpoint = Mapper.replaceData(context.getData(), endpoint);
        response = RequestManager.doRequest(httpMethod, requestSpecification, builtEndpoint);
        context.set("LAST_ENDPOINT", builtEndpoint);
        context.set("LAST_RESPONSE", response);
    }

    @When("I save the response as {string}")
    public void iSaveTheResponseAs(final String key) {
        AllureUtils.attachStepContent("Response body:", response.getBody().asString());
        context.set(key, response);
    }

    @When("I save the request endpoint for deleting")
    public void iSaveTheRequestEndpointForDeleting() {
        if (IntStream.of(OK_STATUS_CODE).anyMatch(n -> n == response.getStatusCode())) {
            String lastEndpoint = (String) context.get("LAST_ENDPOINT");
            String lastResponseId = ((Response) context.get("LAST_RESPONSE")).jsonPath().getString("id");
            String finalEndpoint = String.format("%s/%s", lastEndpoint, lastResponseId);
            context.addEndpoint(finalEndpoint);
        }
    }

    @Then("I validate the response has status code {int}")
    public void iValidateTheResponseHasStatusCode(int expectedStatusCode) {
        int statusCode = response.getStatusCode();
        Assert.assertEquals(statusCode, expectedStatusCode);
    }

    @Then("I validate the response has no to be status code {int}")
    public void iValidateTheResponseHasNotoHaveStatusCode(int expectedStatusCode) {
        int statusCode = response.getStatusCode();
        Assert.assertNotEquals(statusCode, expectedStatusCode);
    }

    @Then("I validate the response contains:")
    public void iValidateTheResponseContains(final Map<String, String> validationMap) {
        if (IntStream.of(OK_STATUS_CODE).anyMatch(n -> n == response.getStatusCode())) {
            Map<String, Object> responseMap = response.jsonPath().getMap(".");
            Map<String, String> entryProcessed = Mapper.replaceBodyData(context.getData(), validationMap);
            for (Map.Entry<String, String> data : entryProcessed.entrySet()) {
                if (entryProcessed.containsKey(data.getKey())) {
                    Assert.assertEquals(String.valueOf(responseMap.get(data.getKey())), data.getValue());
                }
            }
        }
    }

    @Then("I validate the response contains, ignoring lower and upper case:")
    public void iValidateTheResponseContainsIgnoringLowerUpperCase(final Map<String, String> validationMap) {
        Map<String, Object> responseMap = response.jsonPath().getMap(".");
        for (Map.Entry<String, String> data : validationMap.entrySet()) {
            if (responseMap.containsKey(data.getKey())) {
                String actual = String.valueOf(responseMap.get(data.getKey()));
                Assert.assertEquals(StringUtils.lowerCase(actual),
                        StringUtils.lowerCase(data.getValue()));
            }
        }
    }

    @Then("Response body should match with {string} json schema")
    public void responseBodyShouldMatchWithJsonSchema(final String pathSchema) {
        if (IntStream.of(OK_STATUS_CODE).anyMatch(n -> n == response.getStatusCode())) {
            File schemaFile = new File(pathSchema);
            response.then().assertThat().body(matchesJsonSchema(schemaFile));
        }
    }

    @Then("I validate the response should not contain:")
    public void iValidateTheResponseShouldNotContains(final Map<String, String> validationMap) {
        Map<String, Object> responseMap = response.jsonPath().getMap(".");
        for (Map.Entry<String, String> data : validationMap.entrySet()) {
            if (responseMap.containsKey(data.getKey())) {
                Assert.assertNotEquals(String.valueOf(responseMap.get(data.getKey())), data.getValue());
            }
        }
    }

    @Then("I validate responses contain:")
    public void iValidateTheResponseLabelContains(final Map<String, String> validationMap) {
        Response res = (Response) context.get("LAST_RESPONSE");
        List<Object> responseList = res.jsonPath().getList(".");

        for (Map.Entry<String, String> data : validationMap.entrySet()) {
            for (Object o : responseList) {
                String value = (String) ((Map) o).get(data.getKey());
                if (!value.isEmpty()) {
                    Assert.assertEquals(value, StringUtils.lowerCase(data.getValue()));
                }
            }
        }
    }

    @Then("I validate responses contain, should not be:")
    public void iValidateTheResponseLabelContainsShouldNotBe(final Map<String, String> validationMap) {
        Response res = (Response) context.get("LAST_RESPONSE");
        List<Object> responseList = res.jsonPath().getList(".");

        for (Map.Entry<String, String> data : validationMap.entrySet()) {
            for (Object o : responseList) {
                String value = (String) ((Map) o).get(data.getKey());
                if (!value.isEmpty()) {
                    Assert.assertNotEquals(value, StringUtils.lowerCase(data.getValue()));
                }
            }
        }
    }

    @Then("I validate the response should not have status code")
    public void iValidateTheResponseShouldNotHaveStatusCode(final List expectedStatusCode) {
        int statusCode = response.getStatusCode();
        for (Object code : expectedStatusCode) {
            Assert.assertNotEquals(statusCode, Integer.parseInt(code.toString()));
        }
    }
}
