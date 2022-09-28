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
    CC	("Coordinating conjunction",                null),
    CD	("Cardinal number",                         null),
    DT	("Determiner",                              null),
    EX	("Existential there",                       null),
    FW	("Foreign word",                            null),
    IN	("Preposition or subordinating conjunction",null),
    JJ	("Adjective",                                edu.mit.jwi.item.POS.ADJECTIVE),
    JJR	("Adjective, comparative",                   edu.mit.jwi.item.POS.ADJECTIVE),
    JJS	("Adjective, superlative",                   edu.mit.jwi.item.POS.ADJECTIVE),
    LS	("List item marker",                        null),
    MD	("Modal",                                   null),
    NN	("Noun, singular or mass",                   edu.mit.jwi.item.POS.NOUN),
    NNS	("Noun, plural",                             edu.mit.jwi.item.POS.NOUN),
    NNP	("Proper noun, singular",                    edu.mit.jwi.item.POS.NOUN),
    NNPS("Proper noun, plural",                      edu.mit.jwi.item.POS.NOUN),
    PDT	("Predeterminer",                           null),
    POS	("Possessive ending",                       null),
    PRP	("Personal pronoun",                        null),
    PRP$("Possessive pronoun",                      null),
    RB	("Adverb",                                   edu.mit.jwi.item.POS.ADVERB),
    RBR	("Adverb, comparative",                      edu.mit.jwi.item.POS.ADVERB),
    RBS	("Adverb, superlative",                      edu.mit.jwi.item.POS.ADVERB),
    RP	("Particle",                                null),
    SYM	("Symbol",                                  null),
    TO	("to",                                      null),
    UH	("Interjection",                            null),
    VB	("Verb, base form",                          edu.mit.jwi.item.POS.VERB),
    VBD	("Verb, past tense",                         edu.mit.jwi.item.POS.VERB),
    VBG	("Verb, gerund or present participle",       edu.mit.jwi.item.POS.VERB),
    VBN	("Verb, past participle",                    edu.mit.jwi.item.POS.VERB),
    VBP	("Verb, non-3rd person singular present",    edu.mit.jwi.item.POS.VERB),
    VBZ	("Verb, 3rd person singular present",        edu.mit.jwi.item.POS.VERB),
    WDT	("Wh-determiner",                           null),
    WP	("Wh-pronoun",                              null),
    WP$	("Possessive wh-pronoun",                   null),
    WRB	("Wh-adverb",                               null),
    OTHER ("unknow tag",                            null);

    private edu.mit.jwi.item.POS wordnetPos;

    POSTag(String description, edu.mit.jwi.item.POS wordnetPos) {
        this.wordnetPos = wordnetPos;
    }


    private static POSTag valueOfSafe(String tag) {
        try {
            return POSTag.valueOf(tag);
        } catch(Exception e) {
            return POSTag.OTHER;
        }
    }

    public edu.mit.jwi.item.POS getWordnetPos() {
        return wordnetPos != null ? wordnetPos : edu.mit.jwi.item.POS.NOUN;
    }

    public static List<POSTag> valueOf(String[] tags) {
        return Arrays.stream(tags).map(POSTag::valueOfSafe).collect(Collectors.toList());
    }
}
