package pl.polsl.iat.matching.dictionary;

import edu.mit.jwi.item.POS;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.dictionary.nlp.POSTag;
import pl.polsl.iat.matching.dictionary.nlp.POSTagger;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) throws DictionaryException, IOException, NlpMildException {
//        LexicalDictionary dict = new DictionaryFactory().getLexicalDictionary(null, false);
//
//        dict.getNumberOfSynonyms("good");
        NLPTools.init(false);
        LexicalDictionary dict = NLPTools.getLexicalDictionary();
        POSTagger posTagger = NLPTools.getPOSTagger();
        List<POS> tags = posTagger.tag("student").stream().map(POSTag::getWordnetPos).collect(Collectors.toList());
        System.out.println(tags);
//        int id = dict.getNumberOfSynonyms("pupil", tags.get(0));
        List<String> pupil = new ArrayList<>(dict.getRelatedSynsetIds("good", POS.ADJECTIVE));
        List<String> student = dict.getRelatedSynsetIds("category", POS.NOUN);
        System.out.println("Size a = " + pupil.size() + " size b = " + student.size());
        int init_size = pupil.size();
        pupil.removeAll(student);
        int new_size = pupil.size();
        System.out.println(new_size);


//        JwiWordnet wordnet = new JwiWordnet();

    }
}
