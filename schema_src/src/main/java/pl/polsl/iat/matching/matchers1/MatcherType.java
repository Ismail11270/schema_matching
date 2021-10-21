package pl.polsl.iat.matching.matchers1;

public enum MatcherType {
    EXACT(0), FUZZY(1), DICTIONARY(2);
    private final int id;

    MatcherType(int id){
        this.id = id;
    }

    public String getName(){
        return this.getName().toLowerCase();
    }
}
