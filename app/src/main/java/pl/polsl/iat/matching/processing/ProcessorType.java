package pl.polsl.iat.matching.processing;

import java.util.Arrays;
import java.util.Optional;

public enum ProcessorType {
    STOP_WORDS_CLEANER("clean_stop_words", StopWordsRemover.getInstance()),
    NON_ALPHABETIC_CLEANER("clean_non_alphabetic", null),
    LEMMATIZER("lemmatization", null),
    STEMMER("stemming", null),
    PREFIX_CLEANER("clean_prefixes", null);

    private final String xmlName;
    private final TextProcessor<Words> processor;
    ProcessorType(String xmlName, TextProcessor<Words> processor) {
        this.xmlName = xmlName;
        this.processor = processor;
    }

    public static Optional<ProcessorType> getFromXmlName(String xmlName) {
        return Arrays.stream(values()).filter(t -> t.xmlName.equals(xmlName)).findFirst();
    }

    public TextProcessor<Words> getProcessor() {
        return processor;
    }
}
