package pl.polsl.iat.matching.util;

import java.util.Arrays;

public class ResultUtil {
    public static Float combineResults() {
        return null;
    }

    public static Float combineWordsResults(int total, Float... results) {
        return Arrays.stream(results).reduce(0f, Float::sum) / total;
    }

}
