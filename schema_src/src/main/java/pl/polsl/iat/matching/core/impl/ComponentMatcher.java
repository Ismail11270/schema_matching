package pl.polsl.iat.matching.core.impl;

import pl.polsl.iat.matching.core.processing.impl.StringMatcher;
import pl.polsl.iat.matching.core.result.MatchingComponent;
import pl.polsl.iat.matching.core.schema.model.Component;

public abstract class ComponentMatcher<T extends Component> {
    private final StringMatcher stringMatcher;

    private final T left;
    private final T right;

    public ComponentMatcher(T left, T right, MatchingComponent rMatchingComponent) {
        stringMatcher = new StringMatcher();
        this.left = left;
        this.right = right;
    }

    public float doMatch() {
        return matchAttributes();
//        return stringMatcher.compare(new StringPair(left.getName(), right.getName()));
    }

    protected float matchAttributes() {
        return 1;
    }


}
