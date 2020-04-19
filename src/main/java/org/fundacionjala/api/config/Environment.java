package org.fundacionjala.api.config;

import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import org.json.simple.JSONObject;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public final class Environment {

    private static final String CONFIG_JSON_PATH = "config.json";
    private static final String GRADLE_PROP_PATH = "gradle.properties";
    private static final String THREAD_COUNT_VAR_NAME = "cucumberThreadCount";
    private static Environment instance = new Environment();

    private Properties gradleProp;
    private DocumentContext jsonContext;

    private Environment() {
        JSONObject jsonObject = JsonHelper.getJsonObject(CONFIG_JSON_PATH);
        jsonContext = JsonPath.parse(jsonObject);
        try {
            FileInputStream fileInputStream = new FileInputStream(GRADLE_PROP_PATH);
            gradleProp = new Properties();
            gradleProp.load(fileInputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Environment getInstance() {
        return instance;
    }

    public String getValue(final String keyJsonPath) {
        return jsonContext.read(keyJsonPath);
    }

    public String getThreadCount() {
        return getEnvVariable(THREAD_COUNT_VAR_NAME);
    }

    private String getEnvVariable(final String name) {
        String prop = System.getProperty(name);
        if (prop == null) {
            return gradleProp.getProperty(name);
        }
        return prop;
    }
}
