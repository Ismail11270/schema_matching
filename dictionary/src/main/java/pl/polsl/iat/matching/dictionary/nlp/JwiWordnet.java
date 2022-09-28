package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.Dictionary;
import edu.mit.jwi.IDictionary;
import edu.mit.jwi.item.*;
import edu.mit.jwi.morph.WordnetStemmer;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class JwiWordnet implements Wordnet {
    private final String wordnetLocation;
    private final IDictionary dictionary;
    private final WordnetStemmer stemmer;

    JwiWordnet(String wordnetLocation) throws DictionaryException {
        try {
            this.wordnetLocation = wordnetLocation;
            dictionary = new Dictionary(new URL("file", null, this.wordnetLocation));
            dictionary.open();
            stemmer = new WordnetStemmer(dictionary);

        } catch (IOException e) {
            throw new DictionaryException(e);
        }
    }

    @Override
    public List<String> getRelatedWords(String inputWord, POS pos) {
        IIndexWord idxWord = dictionary.getIndexWord(inputWord, pos);
        List<String> synsets = new ArrayList<>();
        idxWord.getWordIDs().forEach(wordId -> {
            IWord word = dictionary.getWord(wordId);
            ISynset synset = word.getSynset();
            synsets.add(synset.toString());
            synset.getWords().forEach(w -> System.out.println(w.getLemma()));
            System.out.println("=======" + word.getLemma());
        });
        System.out.println(idxWord.getWordIDs().stream().map(x -> dictionary.getWord(x).getSynset().getGloss()).collect(Collectors.toList()));

//        List<String> collect = idxWord.getWordIDs().stream().map(x -> dictionary.getWord(x).getSynset().getRelatedSynsets(Pointer.ANTONYM)).flatMap(Collection::stream).map(ISynsetID::toString).toList();
        return synsets;

//        for (IWordID wordID : idxWord.getWordIDs()) {
//            IWord word = dictionary.getWord(wordID);
//        List<IWordID> iWordIDS = word.getRelatedMap().get(Pointer.ANTONYM);
//        for (IWordID antId : iWordIDS) {
////            System.out.println(dictionary.getWord(antId).getLemma());
//        }
//            word.getRelatedWords().forEach(x -> System.out.println(x.getLemma()));
//            word.getSynset().getRelatedSynsets(Pointer.HYPONYM).forEach(x -> dictionary.getSynset(x).getWords()
//                    .forEach(xx -> System.out.println(xx.getLemma())));
//            Map<IPointer, List<ISynsetID>> relatedMap = word.getSynset().getRelatedMap();
//            List<ISynsetID> allRelatedSynsets = relatedMap.values().stream().flatMap(List::stream).collect(Collectors.toList());
//            System.out.println(allRelatedSynsets);
//            for (IPointer pointer : relatedMap.keySet()) {
//                System.out.println(pointer);
//                System.out.println(relatedMap.get(pointer));
//            }
//            System.out.println("===");
//            word.getRelatedWords().forEach(x -> System.out.println(dictionary.getWord(x).getLemma()));
//        }
//        ISynset synset = word.getSynset();
//        synset.getWords().forEach(x -> System.out.println(x.getLemma()));
//        idxWord.getWordIDs().forEach(x -> {
//            System.out.println("Id = " + x);
//            var word = dictionary.getWord(x);
//            System.out.println(" Lemma = " + word.getLemma());
//            System.out.println(" Gloss = " + word.getSynset().getGloss()) ;
//        });
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
    public List<String> getAntonyms(String word, POS pos) {
        return null;
    }

    @Override
    public WordnetStemmer getStemmer() {
        return stemmer;
    }
}
