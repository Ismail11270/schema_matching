package pl.polsl.iat.matching.processing.impl;

public class Pieces {
    private String[] pieces;

    public Pieces(String... pieces) {
        this.pieces = pieces;
    }

    public String[] getPieces() {
        return pieces;
    }

    public void setPieces(String... pieces) {
        this.pieces = pieces;
    }
}
