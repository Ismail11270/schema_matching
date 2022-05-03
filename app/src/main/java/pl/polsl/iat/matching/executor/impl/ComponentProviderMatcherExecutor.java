package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.executor.MatchingExecutor;
import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.schema.Component;
import pl.polsl.iat.matching.core.model.schema.ComponentsProvider;

public class ComponentProviderMatcherExecutor<T extends Component> implements MatchingExecutor {


    private ComponentsProvider<T> component;
    private ComponentsProvider<T> componentMatch;
    private Component cp;
    private MatchingComponent cpm;

    public ComponentProviderMatcherExecutor(ComponentsProvider<T> left,
                                            ComponentsProvider<T> right,
                                            Component leftRes,
                                            MatchingComponent rightRes) {
        component = left;
        componentMatch = right;
        cp = leftRes;
        cpm = rightRes;
    }

    @Override
    public void run() {
        cpm.setMatchScore(1);
    }
}
