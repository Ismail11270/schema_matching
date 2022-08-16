package pl.polsl.iat.matching.dictionary.nlp;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


/**
 * Part of speech tags
 *
 * @author Ismoil Atajanov
 */
public enum POSTag {
    CC	("Coordinating conjunction"),
    CD	("Cardinal number"),
    DT	("Determiner"),
    EX	("Existential there"),
    FW	("Foreign word"),
    IN	("Preposition or subordinating conjunction"),
    JJ	("Adjective"),
    JJR	("Adjective, comparative"),
    JJS	("Adjective, superlative"),
    LS	("List item marker"),
    MD	("Modal"),
    NN	("Noun, singular or mass"),
    NNS	("Noun, plural"),
    NNP	("Proper noun, singular"),
    NNPS("Proper noun, plural"),
    PDT	("Predeterminer"),
    POS	("Possessive ending"),
    PRP	("Personal pronoun"),
    PRP$("Possessive pronoun"),
    RB	("Adverb"),
    RBR	("Adverb, comparative"),
    RBS	("Adverb, superlative"),
    RP	("Particle"),
    SYM	("Symbol"),
    TO	("to"),
    UH	("Interjection"),
    VB	("Verb, base form"),
    VBD	("Verb, past tense"),
    VBG	("Verb, gerund or present participle"),
    VBN	("Verb, past participle"),
    VBP	("Verb, non-3rd person singular present"),
    VBZ	("Verb, 3rd person singular present"),
    WDT	("Wh-determiner"),
    WP	("Wh-pronoun"),
    WP$	("Possessive wh-pronoun"),
    WRB	("Wh-adverb"),
    OTHER ("unknow tag");

    POSTag(String description){

    }

    private static POSTag valueOfSafe(String tag) {
        try {
            return POSTag.valueOf(tag);
        } catch(Exception e) {
            return POSTag.OTHER;
        }
    }

    public static List<POSTag> valueOf(String[] tags) {
        return Arrays.stream(tags).map(POSTag::valueOfSafe).collect(Collectors.toList());
    }
}
