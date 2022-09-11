package pl.polsl.iat.matching.util;

import com.google.common.collect.Lists;
import me.xdrop.fuzzywuzzy.FuzzySearch;
import pl.polsl.iat.matching.processing.Words;

import java.util.*;

public class WordCombination {


    private static Integer doMatch(String A, String B) {
//        return A.equals("kurwa") ? 100 : 0;
        return A.equalsIgnoreCase(B) ? 100 : 0;
    }
    public static void main(String[] args) {
        //Smaller first
        String[] A  = {"abdullah","small", "Abdullah"};
        String[] B  = {"abdullah  very big", "Abdullah very small"};
//        System.out.println(doMatch(new Words(A), new Words(B)));


        System.out.println(FuzzySearch.ratio("hello", "hallo"));
//        FuzzySearch.
    }
}