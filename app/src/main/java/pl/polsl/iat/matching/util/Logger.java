package pl.polsl.iat.matching.util;

public class Logger {

    public static void info(String s, String... args) {
        System.out.printf("[INFO]\t%s%n", String.format(s, args));
    }

    public static void error(String s, String... args) {
        System.err.printf("[ERROR]\t%s%n", String.format(s, args));
    }

    public static void warn(String s, String... args) {
        System.err.printf("[WARN]\t%s%n", String.format(s, args));
    }

    public static void test(Object o) {
        System.out.printf("[TEST]\t%s%n", o);
    }
}
