package pl.polsl.iat.matching.util;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.processing.ProcessorType;
import pl.polsl.iat.matching.processing.TextProcessor;
import pl.polsl.iat.matching.processing.Words;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class UtilTest {

    private final MatcherSettings settings = MatcherSettings.getSettings();

    @Test
    public void testMatcherSettings() {
        List<ProcessorType> availablePreProcessors = settings.getAvailablePreProcessors();
        availablePreProcessors.stream().forEach(Logger::test);
    }
}
