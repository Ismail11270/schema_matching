package pl.polsl.iat.matching.processing;

class Stemmer implements TextProcessor<Words> {

    @Override
    public Words process(Words words) {
        return words;
    }
}
