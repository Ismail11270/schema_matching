package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.io.*;
import java.util.Optional;

class StopWordsRemover extends AbstractWordsRemover {

    private static TextProcessor<Words> instance;
    static TextProcessor<Words> getInstance() {
        return Optional.ofNullable(instance).orElseGet(StopWordsRemover::init);
    }

    private static TextProcessor<Words> init() {
        try {
            instance = new StopWordsRemover();
            return instance;
        } catch (IOException e) {
            return null;
        }
    }

    private StopWordsRemover() throws IOException {
        super(MatcherSettings.STOP_WORDS_FILE_PATH);
    }

    @Override
    public Words process(Words words) {
        return getWordsToRemove() == null || getWordsToRemove().isEmpty()
                ? words
                : words.filter(word -> !getWordsToRemove().contains(word.toString()));
    }
}
