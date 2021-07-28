package pl.polsl.iat.matching.matchers;

import pl.polsl.iat.matching.matchers.exception.MatchingException;
import pl.polsl.iat.matching.schema.model.Attribute;
import pl.polsl.iat.matching.schema.model.AttributesProvider;

import java.util.stream.Stream;

public class AttributeMatcher {
    private AttributesProvider A, B;
    public AttributeMatcher(AttributesProvider A, AttributesProvider B) throws MatchingException {
        this.A = A;
        this.B = B;
        if(!A.getClass().equals(B.getClass())) {
            throw new MatchingException("Components of different levels cannot be compared: A is " + A.getClass() + " and B is " + B.getClass());
        }
    }

    public float doMatch() {
        Stream<Attribute<?>> attributes = A.getAttributes();
        Stream<Attribute<?>> attributes1 = B.getAttributes();



        //TODO compare all attributes and generate a similarity score (for different types of AttributeProvider use different approaches
        // e.g. for schema only compare name and maybe number of tables attributes however for columns compare all properties of a column such as type primarykey nullable default etc





        return 0;
    }


}
