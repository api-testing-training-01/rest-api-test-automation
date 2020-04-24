package org.fundacionjala.api.hooks;

import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.client.RequestManager;
import org.fundacionjala.api.utils.Helper;
import org.fundacionjala.api.utils.RequestSpecFactory;

public class SFDCHook {
    private Helper helper;
    private RequestSpecification requestSpecification =
            RequestSpecFactory.getRequestSpec("sfdc", "owner");

    public SFDCHook(final Helper helper) {
        this.helper = helper;
    }

    @Before(value = "@CreateCampaign", order = 1)
    public void createCampaign() {
        String jsonBody = "{\n"
                + "\"name\":\"my api campaing\",\n"
                + "\"description\":\"my description\",\n"
                + "\"isActive\": true,\n"
                + "\"type\": \"Conference\",\n"
                + "\"status\":\"Planned\",\n"
                + "\"startDate\":\"2020-04-22\",\n"
                + "\"endDate\":\"2020-04-22\"\n"
                + "}";
        Response response = RequestManager.post(requestSpecification, "/campaign", jsonBody);
        helper.set("Campaign", response);
    }

    @After(value = "@DeletedCampaign")
    public void deletedCampaign() {
        Response postResponse = (Response) helper.get("Campaign");
        String campaignId = postResponse.jsonPath().getJsonObject("id");
        RequestManager.delete(requestSpecification, "/campaign/" + campaignId);
    }
}
