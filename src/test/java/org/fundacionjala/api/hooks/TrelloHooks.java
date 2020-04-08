package org.fundacionjala.api.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;
import org.fundacionjala.api.utils.RequestSpecFactory;


public class TrelloHooks {
    private Helper helper;
    public TrelloHooks(final Helper helper) {
        this.helper = helper;
    }

    @Before(value = "@CreateOrganization")
    public void createOrganization() {
        String jsonBody = "{\n"
                + "        \"displayName\": \"my_team\",\n"
                + "        \"name\": \"my_team\",\n"
                + "        \"teamType\":\"sales\",\n"
                + "        \"desc\":\"My team description\"\n"
                + "        }";
        RequestSpecification requestSpecification = RequestSpecFactory.getRequestSpec("trello", "owner");
        Response response = RequestManager.doRequest("POST", requestSpecification,
                "/organizations", jsonBody);
        helper.set("Org", response);
    }

    @After(value = "@deletedOrganization")
    public void deletedOrganization() {
        Response postResponse = (Response) helper.get("Org");
        String organizationId = postResponse.jsonPath().getJsonObject("id");
        RequestSpecification requestSpecification = RequestSpecFactory.getRequestSpec("trello", "owner");
        Response response = RequestManager.doRequest("DELETE", requestSpecification,
                "/organizations/" + organizationId);
    }
}
