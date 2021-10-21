package pl.polsl.iat.matching.processing.impl;

import pl.polsl.iat.matching.processing.StringProcessor;

import java.util.Arrays;

public class StringCleanUpProcessor implements StringProcessor {

    @Override
    public Pieces process(Pieces pieces) {
        return new Pieces(Arrays.stream(pieces.getPieces()).map(this::processPieces).toArray(String[]::new));
    }

    /**
     *
     * @param piece
     * @return
     */
    private String processPieces(String piece) {
        return piece.trim().replaceAll("\\d","");
    }
}