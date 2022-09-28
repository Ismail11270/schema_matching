package pl.polsl.iat.matching.dictionary.nlp;

import opennlp.tools.postag.POSModel;
import opennlp.tools.postag.POSTaggerME;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.util.NLPUtils;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class POSTagger {

    private final POSTaggerME tagger;

    public POSTagger() throws NlpMildException {
        try (InputStream modelIs = new FileInputStream(NLPUtils.NLP_MODEL_POS_MAXIENT)) {
            tagger = new POSTaggerME(new POSModel(modelIs));
        } catch (IOException e) {
            Logger.getLogger(POSTagger.class.getName())
                    .log(Level.WARNING, "[NLP] Error loading POS tagging model. Details: %s", e.getMessage());
            throw new NlpMildException();
        }
    }

    public List<POSTag> tag(String... words) {
        return POSTag.valueOf(tagger.tag(words));
    }
}
