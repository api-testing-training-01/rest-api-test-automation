package org.fundacionjala.api.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Helper {

    private List<String> endpoints;
    private Map<String, Object> data;

    public Helper() {
        data = new HashMap<>();
        endpoints = new ArrayList<>();
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
}
