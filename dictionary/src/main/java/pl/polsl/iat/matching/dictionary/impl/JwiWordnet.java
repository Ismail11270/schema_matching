package pl.polsl.iat.matching.dictionary.impl;

import edu.mit.jwi.Dictionary;
import edu.mit.jwi.IDictionary;
import edu.mit.jwi.item.*;
import edu.mit.jwi.morph.WordnetStemmer;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.io.IOException;
import java.net.URL;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class JwiWordnet implements Wordnet {
    private final String wordnetLocation;
    private final IDictionary dictionary;
    private final WordnetStemmer stemmer;
    private final String DEFAULT_LOCATION = "..\\resources\\nlp\\dict";

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
    public List<String> getRelatedWords(String inputWord) {
        inputWord = "date";
        IIndexWord idxWord = dictionary.getIndexWord(inputWord, POS.NOUN);
        for (IWordID wordID : idxWord.getWordIDs()) {
            IWord word = dictionary.getWord(wordID);
//        List<IWordID> iWordIDS = word.getRelatedMap().get(Pointer.ANTONYM);
//        for (IWordID antId : iWordIDS) {
////            System.out.println(dictionary.getWord(antId).getLemma());
//        }
            word.getSynset().getRelatedSynsets().forEach(x -> dictionary.getSynset(x).getWords()
                    .forEach(xx -> System.out.println(xx.getLemma())));
            Map<IPointer, List<ISynsetID>> relatedMap = word.getSynset().getRelatedMap();
            System.out.println("===");
//            word.getRelatedWords().forEach(x -> System.out.println(dictionary.getWord(x).getLemma()));
        }
//        ISynset synset = word.getSynset();
//        synset.getWords().forEach(x -> System.out.println(x.getLemma()));
//        idxWord.getWordIDs().forEach(x -> {
//            System.out.println("Id = " + x);
//            var word = dictionary.getWord(x);
//            System.out.println(" Lemma = " + word.getLemma());
//            System.out.println(" Gloss = " + word.getSynset().getGloss()) ;
//        });
        return Collections.emptyList();
//        // look up first sense of the word "dog "'
//        List<String> stems = stemmer.findStems(inputWord, POS.NOUN);
//        stems.forEach(System.out::println);
//        IIndexWord idxWord = dictionary.getIndexWord(stems.get(0), POS.NOUN);
//        IWordID wordID = idxWord.getWordIDs().get(0); // 1st meaning
//        IWord word = dictionary.getWord(wordID);
//        ISynset synset = word.getSynset();
//        // iterate over words associated with the synset
//        return synset.getWords().stream().map(IWord::getLemma).collect(Collectors.toList());
    }

    @Override
    public List<String> getAntonyms(String word) {
        return null;
    }
}
