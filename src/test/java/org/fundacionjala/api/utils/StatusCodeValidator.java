package org.fundacionjala.api.utils;

import java.util.Arrays;
import java.util.List;

public class StatusCodeValidator {
    private static final List<Integer> OK_STATUS_CODE = Arrays.asList(200, 201);

    public StatusCodeValidator() {
    }

    public boolean codeIsValid(final int toValidate) {
        boolean isValid = OK_STATUS_CODE.contains(toValidate);
        return isValid;
    }
}
