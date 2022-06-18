package pl.polsl.iat.matching.util;

public class Logger {

    public enum LogLevel {
        SCHEMA, TABLE, COLUMN
    }

    private static final LogLevel LOG_LEVEL = MatcherSettings.getSettings().getLogLevel();

    public static void info(String s, String... args) {
        System.out.printf("[INFO]\t%s%n", String.format(s, args));
    }

    public static void table(String s, String... args) {
        if(LOG_LEVEL == LogLevel.TABLE || LOG_LEVEL == LogLevel.COLUMN) {
            System.out.printf("\t[TABLE]\t%s%n", String.format(s, args));
        }
    }

    public static void column(String s, String... args) {
        if(LOG_LEVEL == LogLevel.COLUMN) {
            System.out.printf("\t\t[COLUMN]\t%s%n", String.format(s, args));
        }
    }

    public static void schema(String s, String... args) {
        System.out.printf("[SCHEMA]\t%s%n", String.format(s, args));
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
