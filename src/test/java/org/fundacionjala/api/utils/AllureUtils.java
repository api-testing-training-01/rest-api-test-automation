package org.fundacionjala.api.utils;

import io.qameta.allure.Allure;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public final class AllureUtils {

    private static final String CONTENT_TYPE = "text/plain";
    private static final String FILE_EXTENSION = "txt";

    private AllureUtils() {

    }

    public static void attachStepContent(final String name, final String content) {
        InputStream text = new ByteArrayInputStream(content.getBytes(StandardCharsets.UTF_8));
        Allure.addAttachment(name, CONTENT_TYPE, text, FILE_EXTENSION);
    }
}
