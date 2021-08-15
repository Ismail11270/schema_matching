package pl.polsl.iat.matching.dictionary.impl;

import edu.mit.jwi.Dictionary;
import edu.mit.jwi.IDictionary;
import edu.mit.jwi.item.*;
import edu.mit.jwi.morph.WordnetStemmer;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import java.util.stream.Collectors;

public class JwiWordnet implements Wordnet {
    private final String wordnetLocation;
    private final IDictionary dictionary;
    private final WordnetStemmer stemmer;
    private final String DEFAULT_LOCATION = "c:\\Program Files (x86)\\WordNet\\2.1\\dict\\";

    //TODO IMPLEMENT LOADING TO RAM
    public JwiWordnet(String wordnetLocation, boolean loadToRam) throws DictionaryException {
        try {
            this.wordnetLocation = wordnetLocation == null || wordnetLocation.isBlank() ?
                    DEFAULT_LOCATION : wordnetLocation;
            dictionary = new Dictionary(new URL("file", null, this.wordnetLocation));
            dictionary.open();
            stemmer = new WordnetStemmer(dictionary);
        } catch (IOException e) {
            throw new DictionaryException(e);
        }
    }


    @Override
    public List<String> getSynonym(String inputWord) {
        // look up first sense of the word "dog "'
        List<String> stems = stemmer.findStems(inputWord, POS.NOUN);
        stems.forEach(System.out::println);
        IIndexWord idxWord = dictionary.getIndexWord(stems.get(0), POS.NOUN);
        IWordID wordID = idxWord.getWordIDs().get(0); // 1st meaning
        IWord word = dictionary.getWord(wordID);
        ISynset synset = word.getSynset();
        // iterate over words associated with the synset
        return synset.getWords().stream().map(w->w.getLemma()).collect(Collectors.toList());
    }
}
