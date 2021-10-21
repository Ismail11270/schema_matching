package pl.polsl.iat.matching.matchers1;

import pl.polsl.iat.matching.matchers1.exception.MatchingException;
import pl.polsl.iat.matching.schema.model.CharacteristicProvider;

public class AttributeMatcher {
    private CharacteristicProvider A, B;
    public AttributeMatcher(CharacteristicProvider A, CharacteristicProvider B) throws MatchingException {
        this.A = A;
        this.B = B;
        if(!A.getClass().equals(B.getClass())) {
            throw new MatchingException("Components of different levels cannot be compared: A is " + A.getClass() + " and B is " + B.getClass());
        }
    }

    public float doMatch() {
//        Stream<Characteristic<?,?>> attributes = A.getCharacteristics();
//        Stream<Characteristic<?>> attributes1 = B.getCharacteristics();



        //TODO compare all attributes and generate a similarity score (for different types of AttributeProvider use different approaches
        // e.g. for schema only compare name and maybe number of tables attributes however for columns compare all properties of a column such as type primarykey nullable default etc





        return 0;
    }


}
