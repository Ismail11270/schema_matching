package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.executor.MatchingExecutor;
import pl.polsl.iat.matching.core.result.MatchingComponent;
import pl.polsl.iat.matching.core.schema.model.Component;
import pl.polsl.iat.matching.core.schema.model.ComponentsProvider;

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
        cpm.setMatch(1);
    }
}
