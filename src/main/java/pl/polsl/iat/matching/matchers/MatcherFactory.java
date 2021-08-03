package pl.polsl.iat.matching.matchers;

public class MatcherFactory {

    //TODO Implement this

    /**
     * Used by {@Link MatcherSettings}
     * @param type
     * @return
     */
    public static ComponentMatcher getMatcherOfType(MatcherType type){
        return new ComponentMatcher() {

        };
    }
}
