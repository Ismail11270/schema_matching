package pl.polsl.iat.matching.util;

import pl.polsl.iat.matching.matchers.result.NameMatchingResult;

import java.math.BigDecimal;

public class Utils {

    public static BigDecimal parseResult(NameMatchingResult result) {
        return BigDecimal.valueOf(result.getResult());
    }

}
