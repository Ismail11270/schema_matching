package pl.polsl.iat.matching.dictionary.nlp;

import edu.mit.jwi.IRAMDictionary;
import edu.mit.jwi.RAMDictionary;
import edu.mit.jwi.data.ILoadPolicy;
import edu.mit.jwi.item.*;
import edu.mit.jwi.morph.WordnetStemmer;
import pl.polsl.iat.matching.dictionary.exception.DictionaryException;

import java.io.IOException;
import java.net.URL;
import java.util.*;

public class JwiWordnet implements Wordnet {
    private final IRAMDictionary dictionary;
    private final WordnetStemmer stemmer;

    JwiWordnet(String wordnetLocation, boolean loadToRam) throws DictionaryException {
        try {
            dictionary = new RAMDictionary(new URL("file", null, wordnetLocation), ILoadPolicy.IMMEDIATE_LOAD);
            dictionary.open();
            stemmer = new WordnetStemmer(dictionary);
            if (loadToRam) {
                dictionary.load();
            }
        } catch (IOException e) {
            throw new DictionaryException(e);
        }
    }

    private void addWordsFromSynset(ISynset synset, List<String> allWords) {
        synset.getRelatedSynsets().stream().map(dictionary::getSynset).forEach(sset -> addWordsFromSynset(sset, allWords));
    }

    @Override
    public List<String> getRelatedWords(String inputWord, POS pos) {
        IIndexWord idxWord = dictionary.getIndexWord(inputWord, pos);
        List<String> allWords = new ArrayList<>();
        for (IWordID wordID : idxWord.getWordIDs()) {
            IWord word = dictionary.getWord(wordID);
            allWords.add(word.getLemma());
            addWordsFromSynset(word.getSynset(), allWords);
        }
        return allWords;
    }

    @Override
    public Collection<String> getRleatedSynsets(String iWord, POS pos) {
        IIndexWord indexWord = dictionary.getIndexWord(iWord, pos);
        List<IWord> words = indexWord.getWordIDs().stream().map(dictionary::getWord).toList();
        Collection<String> synsets = new TreeSet<>();
        for (IWord word : words) {
            ISynset synset = word.getSynset();
            fun(synset.getID(), synsets, 5);
        }
        return synsets;
    }

    private void fun(ISynsetID synsetID, Collection<String> synsets, int i) {
        if (i <= 0) return;
        i--;
        for (ISynsetID childSynset : dictionary.getSynset(synsetID).getRelatedSynsets()) {
            synsets.add(childSynset.toString());
            fun(childSynset, synsets, i);
        }
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
