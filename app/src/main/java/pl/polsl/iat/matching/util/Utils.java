package pl.polsl.iat.matching.util;

import pl.polsl.iat.matching.matchers.result.PartialResult;

import java.math.BigDecimal;

public class Utils {

    public static BigDecimal parseResult(PartialResult result) {
        return BigDecimal.valueOf(result.getResult());
    }

}
