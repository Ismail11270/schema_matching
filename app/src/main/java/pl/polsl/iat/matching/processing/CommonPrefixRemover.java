package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.util.MatcherSettings;

import java.io.IOException;
import java.util.Optional;

class CommonPrefixRemover extends AbstractWordsRemover {

    private static TextProcessor<Words> instance;

    static TextProcessor<Words> getInstance() {
        return Optional.ofNullable(instance).orElseGet(CommonPrefixRemover::init);
    }

    private static TextProcessor<Words> init() {
        try {
            instance = new CommonPrefixRemover();
            return instance;
        } catch (IOException e) {
            return null;
        }
    }

    private CommonPrefixRemover() throws IOException {
        super(MatcherSettings.PREFIXES_FILE_PATH);
    }

    @Override
    public Words process(Words words) {
        if(getWordsToRemove() == null || getWordsToRemove().isEmpty() || words.size() < 2) {
            return words;
        }
        if(getWordsToRemove().contains(words.get(0).toString())) {
            words.remove(0);
        }
        return words;
    }
}
