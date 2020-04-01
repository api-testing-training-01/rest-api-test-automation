package org.fundacionjala.api.config;

import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import org.json.simple.JSONObject;

public final class Environment {

    private static final String CONFIG_JSON_PATH = "config.json";
    private static Environment instance = new Environment();

    private DocumentContext jsonContext;

    private Environment() {
        JSONObject jsonObject = JsonHelper.getJsonObject(CONFIG_JSON_PATH);
        jsonContext = JsonPath.parse(jsonObject);
    }

    public static Environment getInstance() {
        return instance;
    }

    public String getValue(final String keyJsonPath) {
        return jsonContext.read(keyJsonPath);
    }
}
