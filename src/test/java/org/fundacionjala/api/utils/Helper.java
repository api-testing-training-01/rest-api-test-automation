package org.fundacionjala.api.utils;

import io.restassured.response.Response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Helper {

    private List<String> endpoints;
    private Map<String, Object> data;
    private Map<String, Object> responseMap;
    private String key;

    public Helper() {
        data = new HashMap<>();
        endpoints = new ArrayList<>();
        responseMap = new HashMap<>();
    }

    public Object get(final String key) {
        return data.get(key);
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void set(final String key, final Object response) {
        data.put(key, response);
    }

    public void addEndpoint(final String endpoint) {
        endpoints.add(endpoint);
    }

    public List<String> getEndpoints() {
        return endpoints;
    }

    public void addResponse(final String key, final Response response) {
        this.key = key;
        responseMap.put(key, response);
    }

    public Map<String, Object> getResponseMap() {
        return responseMap;
    }

    public String getKey() {
        return key;
    }
}
