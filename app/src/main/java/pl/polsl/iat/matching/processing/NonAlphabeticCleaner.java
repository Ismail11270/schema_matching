package pl.polsl.iat.matching.processing;

import java.util.regex.Pattern;

class NonAlphabeticCleaner implements TextProcessor<Words>{

    private final static Pattern nonAlphabeticPattern = Pattern.compile("\\W|\\d");

    NonAlphabeticCleaner() {

    }

    @Override
    public Words process(Words words) {
        words.remove(nonAlphabeticPattern);
        return words;
    }
}
