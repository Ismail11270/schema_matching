package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.Dictionary;
import edu.mit.jwi.IDictionary;
import edu.mit.jwi.RAMDictionary;
import edu.mit.jwi.data.ILoadPolicy;
import edu.mit.jwi.item.*;
import edu.mit.jwi.morph.WordnetStemmer;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.io.IOException;
import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;

public class JwiWordnet implements Wordnet {
    private final String wordnetLocation;
    private final IDictionary dictionary;
    private final WordnetStemmer stemmer;

    JwiWordnet(String wordnetLocation) throws DictionaryException {
        try {
            this.wordnetLocation = wordnetLocation;
            dictionary = new RAMDictionary(new URL("file", null, this.wordnetLocation), ILoadPolicy.IMMEDIATE_LOAD);
            dictionary.open();
            stemmer = new WordnetStemmer(dictionary);

        } catch (IOException e) {
            throw new DictionaryException(e);
        }
    }

    /*
        if words are in the same synset then 100% match
     */
    private void getWordsFromSynset(ISynset synset) {
        System.out.println("=======");
        synset.getWords().stream().map(IWord::getLemma).forEach(System.out::println);
    }

    private void addWordsFromSynset(ISynset synset, List<String> allWords) {
        System.out.println(synset.getGloss());
//        System.out.println("====" + synset.get);
        synset.getWords().forEach(word -> System.out.println(word.getLemma()));
        synset.getRelatedSynsets().stream().map(dictionary::getSynset).forEach(sset -> addWordsFromSynset(sset, allWords));
    }

    @Override
    public List<String> getRelatedWords(String inputWord, POS pos) {

        /*
        IndexWord  -> word ids (words by meaning -> get each word from the dictionary -> for each of those 'words' get synset

         */

        IIndexWord idxWord = dictionary.getIndexWord(inputWord, pos);
        IWordID iWordID = idxWord.getWordIDs().get(0);
//        dictionary.getWord(iWordID).getSynset()
//        for (IWordID wordID : idxWord.getWordIDs()) {
//            IWord word = dictionary.getWord(wordID);
//        IWord word = dictionary.getWord(idxWord.getWordIDs().get(0));
//        System.out.println(word.getSynset().getGloss());
        List<String> allWords = new ArrayList<>();
        for (IWordID wordID : idxWord.getWordIDs()) {
            IWord word = dictionary.getWord(wordID);
            allWords.add(word.getLemma());
            addWordsFromSynset(word.getSynset(), allWords);
        }

//        synset2.getWords().stream().map(IWord::getLemma).forEach(System.out::println);

        //related words to original words from original synset
//        synset1.getWords().get(0).getRelatedWords().stream().map(dictionary::getWord).map(IWord::getLemma).forEach(System.out::println);

//            word.getSynset().getRelatedSynsets().stream().map(dictionary::getSynset).forEach(iSynset -> iSynset.getWords().forEach(x -> System.out.println(x.getLemma())));


//        }


//        List<String> synsets = new ArrayList<>();
//        idxWord.getWordIDs().forEach(wordId -> {
//            IWord word = dictionary.getWord(wordId);
//            ISynset synset = word.getSynset();
//            synsets.add(synset.toString());
//            synset.getRelatedSynsets().forEach(syns -> dictionary.getSynset(syns).getWords().forEach(w -> System.out.println(w.getLemma())));
////            System.out.println("=======" + word.getLemma());
//        });
//        System.out.println(idxWord.getWordIDs().stream().map(x -> dictionary.getWord(x).getSynset().getGloss()).collect(Collectors.toList()));

//        List<String> collect = idxWord.getWordIDs().stream().map(x -> dictionary.getWord(x).getSynset().getRelatedSynsets(Pointer.ANTONYM)).flatMap(Collection::stream).map(ISynsetID::toString).toList();
        return allWords;

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
    public Collection<String> getRleatedSynsets(String iWord, POS pos) {
        IIndexWord indexWord = dictionary.getIndexWord(iWord, pos);
        List<IWord> words = indexWord.getWordIDs().stream().map(dictionary::getWord).toList();
        Collection<String> synsets = new TreeSet<>();
        for(IWord word : words) {
            ISynset synset = word.getSynset();
            fun(synset.getID(), synsets, 5);
        }
//        for(IWord word : words) {
//            ISynset synset = word.getSynset();
//            word.getRelatedWords().stream().map(dictionary::getWord).map(IWord::getLemma).toList().forEach(System.out::println);
//            System.out.println(synset.getID());
//            synsets.add(synset.getID().toString());
//            System.out.println(synset.getGloss());
//            synset.getWords().stream().map(IWord::getLemma).forEach(System.out::println);
//            Map<IPointer, List<ISynsetID>> relatedMap = synset.getRelatedMap();
//            Pointer.
//            for (ISynsetID synset1 : synset.getRelatedSynsets()) {
//                synsets.add(synset1.toString());
////                System.out.println("\t"+synset1);
//                for (ISynsetID synset2 : dictionary.getSynset(synset1).getRelatedSynsets()) {
//                    synsets.add(synset2.toString());
//                    for (ISynsetID synset3 : dictionary.getSynset(synset2).getRelatedSynsets()) {
//                        synsets.add(synset3.toString());
//                        for (ISynsetID synset4 : dictionary.getSynset(synset3).getRelatedSynsets()) {
//                            synsets.add(synset4.toString());
//                            for (ISynsetID synset5 : dictionary.getSynset(synset4).getRelatedSynsets()) {
//                                synsets.add(synset5.toString());
//                            }
//                        }
//                    }
//                }
//            }

//        }
        return synsets;
    }

    private void fun(ISynsetID synsetID, Collection<String> synsets, int i) {
        if(i <= 0) return;
        i--;
        for(ISynsetID childSynset : dictionary.getSynset(synsetID).getRelatedMap().entrySet().stream().filter(entry -> !entry.getKey().equals(Pointer.HYPONYM)).map(Map.Entry::getValue)
                .flatMap(Collection::stream).toList()) {
            System.out.println(childSynset);
            synsets.add(childSynset.toString());
            if(!dictionary.getSynset(childSynset).getRelatedSynsets().isEmpty()){
                fun(childSynset, synsets, i);
            }
        }
    }

//    private void fun(ISynsetID synsetID, Collection<String> synsets, int i) {
//        if(i <= 0) return;
//        i--;
//        for(Map.Entry<IPointer, List<ISynsetID>> childSynset : dictionary.getSynset(synsetID).getRelatedMap().entrySet().stream()
////                .filter(entry -> !entry.getKey().equals(Pointer.ANTONYM))
////                .map(Map.Entry::getValue)
////                .flatMap(Collection::stream)
//                .toList()) {
////            System.out.println(childSynset.getKey() + " " + childSynset.getValue());
//            for(ISynsetID id : childSynset.getValue()) {
////            System.out.println(childSynset);
//                synsets.add(id.toString());
////            if(!dictionary.getSynset(childSynset).getRelatedSynsets().isEmpty()){
//                fun(id, synsets, i);
////            }
//            }
//        }
//    }

    @Override
    public List<String> getAntonyms(String word, POS pos) {
        return null;
    }

    @Override
    public WordnetStemmer getStemmer() {
        return stemmer;
    }
}
