package pl.polsl.iat.matching.util;

import pl.polsl.iat.matching.matchers.result.Results;

import java.math.BigDecimal;

public class Utils {

    public static BigDecimal parseResult(Results result) {
        return BigDecimal.valueOf(result.calculateResult());
    }

}
