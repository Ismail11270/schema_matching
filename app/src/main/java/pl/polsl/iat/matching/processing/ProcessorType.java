package pl.polsl.iat.matching.processing;

import java.util.Arrays;
import java.util.Optional;

public enum ProcessorType {
    NON_ALPHABETIC_CLEANER(1, "clean_non_alphabetic", new NonAlphabeticCleaner()),
    STOP_WORDS_CLEANER(2, "clean_stop_words", StopWordsRemover.getInstance()),
    SHORT_WORDS_CHANGER(3,"short_words_changer", ShortWordsChanger.getInstance()),
    LEMMATIZER(4, "lemmatization", new Lemmatizer()),
    STEMMER(5, "stemming", new Stemmer()),
    PREFIX_CLEANER(6, "clean_prefixes", CommonPrefixRemover.getInstance()),
    PART_OF_SPEECH_TAGGER(Integer.MAX_VALUE, "part_of_speech", new PartOfSpeechTagger());


    private final String xmlName;
    private final TextProcessor<Words> processor;
    private int priority;

    ProcessorType(int priority, String xmlName, TextProcessor<Words> processor) {
        this.xmlName = xmlName;
        this.processor = processor;
        this.priority = priority;
    }

    public static Optional<ProcessorType> getFromXmlName(String xmlName) {
        return Arrays.stream(values()).filter(t -> t.xmlName.equals(xmlName)).findFirst();
    }

    public Optional<TextProcessor<Words>> getProcessor() {
        return Optional.ofNullable(processor);
    }

    public ProcessorType newPriority(int priority) {
        this.priority = priority;
        return this;
    }

    public Integer getPriority() {
        return priority;
    }

    @Override
    public String toString() {
        return String.format("[%d] -- %s -- Processor %s", priority, name(),
                processor == null ? "unavailable." : "available.");

    }
}
