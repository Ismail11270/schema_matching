package pl.polsl.iat.matching.processing.impl_;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.List;

@Deprecated(forRemoval = true)
public class StringProcessingUnit {

    private final List<StringProcessor_> processors = null; //MatcherSettings.getSettings().getAvailableStringProcessors();

    public ProcessedString process(String value) {
        Pieces processed = new Pieces(value);
        var result = new ProcessedString(value, processed);
        for (StringProcessor_ processor : processors) {
            processed = processor.process(processed);
        }

        return result;
    }
}
