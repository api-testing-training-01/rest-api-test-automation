package org.fundacionjala.api.config;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

public final class JsonHelper {

    private static final Logger LOGGER = LogManager.getLogger(JsonHelper.class);

    private JsonHelper() {
        // Default constructor for utility class.
    }

    public static JSONObject getJsonObject(final String configJsonPath) {
        LOGGER.info("Reading json config object.");
        JSONObject jsonObject = null;
        JSONParser parser = new JSONParser();
        try (InputStream inputStream = new FileInputStream(configJsonPath)) {
            Reader fileReader = new InputStreamReader(inputStream);
            jsonObject = (JSONObject) parser.parse(fileReader);
        } catch (IOException | ParseException e) {
            LOGGER.error("Cannot read json config file.");
            LOGGER.error(e.getMessage());
        }
        return jsonObject;
    }
}
