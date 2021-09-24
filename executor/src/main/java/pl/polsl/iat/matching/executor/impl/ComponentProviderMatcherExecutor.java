package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.executor.MatchingExecutor;
import pl.polsl.iat.matching.result.Component;
import pl.polsl.iat.matching.result.MatchingComponent;
import pl.polsl.iat.matching.schema.model.CharacteristicProvider;
import pl.polsl.iat.matching.schema.model.ComponentsProvider;

public class ComponentProviderMatcherExecutor implements MatchingExecutor {

    private ComponentsProvider<CharacteristicProvider> component;
    private ComponentsProvider<CharacteristicProvider> componentMatch;
    private Component cp;
    private MatchingComponent cpm;

    public ComponentProviderMatcherExecutor(ComponentsProvider<CharacteristicProvider> left,
                                            ComponentsProvider<CharacteristicProvider> right,
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
