package org.fundacionjala.api.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;
import org.fundacionjala.api.utils.RequestSpecFactory;
import org.testng.SkipException;


public class TrelloHooks {
    private static final int TOO_MANY_REQUESTS_STATUS_CODE = 429;
    private Helper helper;
    private RequestSpecification requestSpecification =
            RequestSpecFactory.getRequestSpec("trello", "owner");

    public TrelloHooks(final Helper helper) {
        this.helper = helper;
    }

    @Before(value = "@CreateOrganization", order = 1)
    public void createOrganization() {
        String jsonBody = "{\n"
                + "        \"displayName\": \"my_team\",\n"
                + "        \"name\": \"my_team\",\n"
                + "        \"teamType\":\"sales\",\n"
                + "        \"desc\":\"My team description\"\n"
                + "        }";
        Response response = RequestManager.post(requestSpecification, "/organizations", jsonBody);
        helper.set("Org", response);
    }
    @Before(value = "@CreateMemberInAnOrganization", order = 2)
    public void createMemberInAnOrganization() {
        Response postResponse = (Response) helper.get("Org");
        String organizationId = postResponse.jsonPath().getJsonObject("id");
        String jsonBody = "{\n"
                + "        \"email\": \"trello.apiXXXXXXXXXXX@mailinator.com\",\n"
                + "        \"type\":\"normal\"\n"
                + "        }";
        Response response = RequestManager.put(
                requestSpecification, "/organizations/" + organizationId + "/members", jsonBody);
        if (TOO_MANY_REQUESTS_STATUS_CODE == response.statusCode()) {
            throw new SkipException(
                    "Looks like you've exceeded your invitation quota. Please wait 60 minutes and try again");
        }
        String memberId = response.jsonPath().getJsonObject("memberships[1].id");
        helper.set("MemberId", memberId);
    }

    @After(value = "@deletedOrganization")
    public void deletedOrganization() {
        Response postResponse = (Response) helper.get("Org");
        String organizationId = postResponse.jsonPath().getJsonObject("id");
        Response response = RequestManager.delete(requestSpecification,
                "/organizations/" + organizationId);
    }
}
