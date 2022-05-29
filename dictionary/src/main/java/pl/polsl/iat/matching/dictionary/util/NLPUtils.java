package pl.polsl.iat.matching.dictionary.util;

import java.util.Optional;

public class NLPUtils {

    private static final String NLP_MODELS_DEFAULT_DIR = "resources\\nlp\\models";

    private static final String NLP_MODELS_DIR_VAR = "NLP_MODELS_DIR";

    public static final String NLP_MODELS_DIR = Optional.ofNullable(System.getenv(NLP_MODELS_DIR_VAR))
                            .orElse(NLP_MODELS_DEFAULT_DIR);

    public static final String NLP_MODEL_POS_MAXIENT = NLP_MODELS_DIR + "\\" + "en-pos-maxent.bin";

    public static final String NLP_MODEL_LEMMA = NLP_MODELS_DIR + "\\" + "en-lemmatizer.bin";

    public static final String NLP_MODEL_POS_PERCEPTRON = NLP_MODELS_DIR + "\\" + "en-pos-perceptron.bin";

}
