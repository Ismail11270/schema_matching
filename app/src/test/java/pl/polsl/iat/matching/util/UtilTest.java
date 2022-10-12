package pl.polsl.iat.matching.util;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import pl.polsl.iat.matching.processing.ProcessorType;

import java.util.List;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class UtilTest {

    private final MatcherSettings settings = MatcherSettings.getSettings();

    @Test
    public void testMatcherSettings() {
        List<ProcessorType> availablePreProcessors = settings.getAvailablePreProcessors();
        availablePreProcessors.stream().forEach(Logger::test);
    }
}
