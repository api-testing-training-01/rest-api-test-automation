package org.fundacionjala.api.utils;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.api.config.Environment;

import java.util.HashMap;
import java.util.Map;
import java.util.function.Supplier;

public final class RequestSpecFactory {

    private static final Environment ENV = Environment.getInstance();

    private RequestSpecFactory() {
        // Default constructor for utility class.
    }

    private static RequestSpecification getRequestSpecPivotal(final String account) {
        RequestSpecification requestSpecification = new RequestSpecBuilder()
                .setBaseUri(ENV.getValue("pivotal.baseUri"))
                .addHeader("X-TrackerToken", ENV.getValue(String.format("pivotal.credentials.%s.token", account)))
                .build();
        return requestSpecification
                .log().method()
                .log().uri()
                .log().params()
                .log().body();
    }

    private static RequestSpecification getRequestSpecTrello(final String account) {
        RequestSpecification requestSpecification = new RequestSpecBuilder()
                .setBaseUri(ENV.getValue("trello.baseUri"))
                .addQueryParam("key", ENV.getValue(String.format("trello.credentials.%s.key", account)))
                .addQueryParam("token", ENV.getValue(String.format("trello.credentials.%s.token", account)))
                .build();
        return requestSpecification
                .log().method()
                .log().uri()
                .log().params()
                .log().body();
    }

    private static RequestSpecification getRequestSpecTodoist(final String account) {
        RequestSpecification requestSpecification = new RequestSpecBuilder()
                .setBaseUri(ENV.getValue("todoist.baseUri"))
                .addHeader("Authorization",
                        "Bearer " + ENV.getValue(String.format("todoist.credentials.%s.token", account)))
                .build();
        return requestSpecification
                .log().method()
                .log().uri()
                .log().params()
                .log().body();
    }

    private static Map<String, Supplier<RequestSpecification>> getRequestSpecMap(final String account) {
        Map<String, Supplier<RequestSpecification>> requestSpecMap = new HashMap<>();
        requestSpecMap.put("pivotal", () -> getRequestSpecPivotal(account));
        requestSpecMap.put("trello", () -> getRequestSpecTrello(account));
        requestSpecMap.put("todoist", () -> getRequestSpecTodoist(account));
        return requestSpecMap;
    }

    public static RequestSpecification getRequestSpec(final String serviceName, final String account) {
        return getRequestSpecMap(account).get(serviceName).get();
    }
}
