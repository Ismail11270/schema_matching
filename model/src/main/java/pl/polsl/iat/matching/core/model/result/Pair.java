package pl.polsl.iat.matching.core.model.result;

import java.util.Objects;

class Pair {
    Component component;
    MatchingComponent matchingComponent;
    Integer result;

    public Pair(Component component, MatchingComponent matchingComponent, Integer result) {
        this.component = component;
        this.matchingComponent = matchingComponent;
        this.result = result;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pair pair = (Pair) o;
        return Objects.equals(matchingComponent, pair.matchingComponent) || Objects.equals(component, pair.component);
    }

    @Override
    public int hashCode() {
        return Objects.hash(matchingComponent);
    }

    public int getResult() {
        return result;
    }
}
