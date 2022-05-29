package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.item.POS;
import edu.mit.jwi.morph.WordnetStemmer;
import opennlp.tools.stemmer.PorterStemmer;

public class NLPStemmer {
    private WordnetStemmer stemmer;

    public NLPStemmer(WordnetStemmer stemmer) {
        this.stemmer = stemmer;
    }

    public String doTheThing(String word) {
        PorterStemmer stemmer = new PorterStemmer();
        return stemmer.stem(word);
//        stemmer.findStems(word, POS.TAG_ADJECTIVE_SATELLITE)
//        return "";
    }

}
