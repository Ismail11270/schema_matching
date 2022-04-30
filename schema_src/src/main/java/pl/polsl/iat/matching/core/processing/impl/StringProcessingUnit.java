package pl.polsl.iat.matching.core.processing.impl;

import pl.polsl.iat.matching.core.processing.StringProcessor;
import pl.polsl.iat.matching.core.util.MatcherSettings;

import java.util.List;

public class StringProcessingUnit {

    private final List<StringProcessor> processors = MatcherSettings.getSettings().getAvailableStringProcessors();

    public ProcessedString process(String value) {
        Pieces processed = new Pieces(value);
        var result = new ProcessedString(value, processed);
        for (StringProcessor processor : processors) {
            processed = processor.process(processed);
        }

        return result;
    }
}
