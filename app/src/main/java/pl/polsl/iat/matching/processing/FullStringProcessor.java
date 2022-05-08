package pl.polsl.iat.matching.processing;

public class FullStringProcessor implements StringProcessor<String> {
    private final static FullStringProcessor processor = new FullStringProcessor();

    public static FullStringProcessor get() {
        return processor;
    }
    private FullStringProcessor() {
    }

    //TODO
    @Override
    public Words process(String input) {
        return null;
    }
}
