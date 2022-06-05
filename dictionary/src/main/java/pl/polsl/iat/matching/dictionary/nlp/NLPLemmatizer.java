package pl.polsl.iat.matching.dictionary.nlp;

import opennlp.tools.lemmatizer.LemmatizerME;
import opennlp.tools.lemmatizer.LemmatizerModel;
import opennlp.tools.postag.POSModel;
import opennlp.tools.postag.POSTaggerME;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.util.NLPUtils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NLPLemmatizer {

    private final LemmatizerME lemmatizerME;

    public NLPLemmatizer() throws NlpMildException {
        try (InputStream modelIs = new FileInputStream(NLPUtils.NLP_MODEL_LEMMA)) {
            lemmatizerME = new LemmatizerME(new LemmatizerModel(modelIs));
        } catch (IOException e) {
            Logger.getLogger(POSTagger.class.getName())
                    .log(Level.WARNING, "[NLP] Error loading Lemmatizer model. Details: %s", e.getMessage());
            throw new NlpMildException();
        }
    }

    public String[] doTheThing(String[] words, POSTag[] tags) {
        return lemmatizerME.lemmatize(words, Arrays.stream(tags).map(POSTag::toString).toArray(String[]::new));
    }
}
