package pl.polsl.iat.matching.processing.impl_;

public class ProcessedString {

    private Pieces pieces;
    private String original;

    public ProcessedString(String original, Pieces pieces) {
        this.pieces = pieces;
        this.original = original;
    }

    public Pieces getPieces() {
        return pieces;
    }

    public void setPieces(Pieces pieces) {
        this.pieces = pieces;
    }


}
