package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class StopWordsRemover implements TextProcessor<Words> {

    private List<String> stopWords;

    private static TextProcessor<Words> instance;
    public static TextProcessor<Words> getInstance() {
        return Optional.ofNullable(instance).orElseGet(StopWordsRemover::init);
    }

    private static TextProcessor<Words> init() {
        try {
            return (instance = new StopWordsRemover());
        } catch (IOException e) {
            return null;
        }
    }

    private StopWordsRemover() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(MatcherSettings.STOP_WORDS_FILE))) {
            stopWords = reader.lines().collect(Collectors.toList());
        } catch (FileNotFoundException e) {
            Logger.warn("Stop words file not found at location - ", MatcherSettings.STOP_WORDS_FILE);
            throw e;
        } catch (IOException e) {
            Logger.warn("Error reading stop words file.. Details:\n\t", e.getMessage());
            throw e;
        }
    }

    @Override
    public Words process(Words words) {
        return stopWords == null || stopWords.isEmpty()
                ? words
                : words.filter(word -> stopWords.contains(word.toString()));
    }
}
