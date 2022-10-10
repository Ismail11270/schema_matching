package pl.polsl.iat.matching.dictionary.nlp;

import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;

import java.util.Optional;

public class NLPTools {

    private static final NLPTools instance = new NLPTools();

    private final static String DEFAULT_DICTIONARY_LOCATION = "resources\\nlp\\dict";
    private final static String DICTIONARY_LOCATION_VAR = "WORDNET_DICTIONARY_DIR";

    //Available NLP Tools
    private Wordnet wordnet;
    private LexicalDictionary dictionary;
    private NLPStemmer stemmer;
    private NLPLemmatizer lemmatizer;
    private POSTagger posTagger;
    /**
     * Needs to be initialzied
     * @see NLPTools::init
     */
    private boolean initialized;


    private NLPTools() {
    }

    public static NLPTools init(boolean loadToRam) throws NlpMildException {
        if (instance.initialized) {
            return instance;
        }

        String dictionaryLocation = Optional.ofNullable(System.getenv(DICTIONARY_LOCATION_VAR))
                .orElse(DEFAULT_DICTIONARY_LOCATION);
        instance.wordnet = new JwiWordnet(dictionaryLocation, loadToRam, getWordnetDepth());
        instance.dictionary = new LexicalDictionaryImpl(instance.wordnet);
        instance.stemmer = new NLPStemmer(instance.wordnet.getStemmer());
        instance.lemmatizer = new NLPLemmatizer();
        instance.posTagger = new POSTagger();
        instance.initialized = true;
        return instance;
    }

    private static int getWordnetDepth() {
        return Integer.parseInt(System.getenv().getOrDefault("WORDNET_DEPTH", "4"));
    }

    public static LexicalDictionary getLexicalDictionary() {
        if (instance.initialized) {
            return instance.dictionary;
        }
        throw new DictionaryException("NLP tools were not initialized! Use NLPTools::init to initialize.");
    }

    static Wordnet getWordnet() {
        if (instance.initialized) {
            return instance.wordnet;
        }
        throw new DictionaryException("NLP tools were not initialized! Use NLPTools::init to initialize.");
    }

    public static NLPStemmer getStemmer() {
        if (instance.initialized) {
            return instance.stemmer;
        }
        throw new DictionaryException("NLP tools were not initialized! Use NLPTools::init to initialize.");

    }

    public static NLPLemmatizer getLemmatizer() {
        if (instance.initialized) {
            return instance.lemmatizer;
        }
        throw new DictionaryException("NLP tools were not initialized! Use NLPTools::init to initialize.");
    }

    public static POSTagger getPOSTagger() {
        if (instance.initialized) {
            return instance.posTagger;
        }
        throw new DictionaryException("NLP tools were not initialized! Use NLPTools::init to initialize.");
    }

}
