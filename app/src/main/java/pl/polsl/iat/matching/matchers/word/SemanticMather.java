package pl.polsl.iat.matching.matchers.word;

import pl.polsl.iat.matching.dictionary.LexicalDictionary;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.processing.Word;

import java.util.*;

class SemanticMather extends WordMatcher {

    private static SemanticMather instance;

    private final LexicalDictionary dictionary;

    private SemanticMather() {
        dictionary = NLPTools.getLexicalDictionary();
    }

    public static SemanticMather getInstance() {
        if (instance == null) {
            instance = new SemanticMather();
        }
        return instance;
    }

    Map<String, Collection<String>> cache = new Hashtable<>();

    @Override
    public Integer doMatch(Word left, Word right) {

        Collection<String> leftSynsets = new ArrayList<>(cache.computeIfAbsent(left.toString(), x -> dictionary.getRelatedSynsetIds(left.toString(), left.getPos().getWordnetPos())));
        Collection<String> rightSynsets = new ArrayList<>(cache.computeIfAbsent(right.toString(), x -> dictionary.getRelatedSynsetIds(right.toString(), right.getPos().getWordnetPos())));

        int a = leftSynsets.size(), b = rightSynsets.size();
        leftSynsets.retainAll(rightSynsets);
        float total = a + b - leftSynsets.size();
        return (int)((a/total)*(b/total) * 100);
    }

    @Override
    public Type getType() {
        return Type.SEMANTIC;
    }
}
