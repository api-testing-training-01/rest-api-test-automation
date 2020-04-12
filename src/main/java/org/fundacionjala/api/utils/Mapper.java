package org.fundacionjala.api.utils;

import io.restassured.response.Response;

import java.util.Map;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public final class Mapper {

    private static final String DATA_MATCHER_REGEX = "\\{[0-9A-Za-z._\\-\\[\\]]+}";
    private static final String CAP_REGEX = "[{}]";
    private static final String EMPTY_VAL = "";
    private static final String DOT_REGEX = "\\.";
    private static final int SPLIT_LIMIT = 2;

    private Mapper() {
        // Default constructor for utility class.
    }

    public static String replaceData(final Map<String, Object> context, final String endPoint) {
        Pattern pattern = Pattern.compile(DATA_MATCHER_REGEX);
        Matcher matcher = pattern.matcher(endPoint);
        StringBuffer result = new StringBuffer();
        while (matcher.find()) {
            String valueMapped = getElementResponse(context, matcher.group().replaceAll(CAP_REGEX, EMPTY_VAL));
            if (Objects.isNull(valueMapped)) {
                continue;
            }
            matcher.appendReplacement(result, valueMapped);
        }
        matcher.appendTail(result);
        return result.toString();
    }

    public static Map<String, String> replaceBodyData(final Map<String, Object> data, final Map<String, String> body) {
        return body.entrySet().stream()
                .collect(Collectors.toMap(Map.Entry::getKey, e -> Mapper.replaceData(data, e.getValue())));
    }

    private static String getElementResponse(final Map<String, Object> context, final String element) {
        String[] elementSplit = element.split(DOT_REGEX, SPLIT_LIMIT);
        Response response = (Response) context.get(elementSplit[0]);
        return response.jsonPath().getString(elementSplit[1]);
    }

    public static String getEndPointBuilt(final Map<String, Object> context, final String element) {
        return context.isEmpty() ? element : replaceData(context, element);
    }
}
