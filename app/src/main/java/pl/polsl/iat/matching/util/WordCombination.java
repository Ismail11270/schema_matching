package pl.polsl.iat.matching.util;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class WordCombination {

    private static class Tuple<T,U> {
        private T first;
        private U second;

        public Tuple(T first, U second) {
            this.first = first;
            this.second = second;
        }

        public T getFirst() {
            return first;
        }

        public U getSecond() {
            return second;
        }
    }

    public static void main(String[] args) {

        String[] A = {"hello", "world", "kurwa", "test  "};
        String[] B = {"hello", "universe", "big shit", "test"};

        Map<Float, Tuple<Integer, Integer>> results = new TreeMap<>();
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < B.length; j++) {
                results.put(compare(A[i], B[j]), new Tuple<>(i, j));
            }
        }

        List<Integer> indexes = List.of(1,2,3,4,5);

        String[] smaller = A.length < B.length ? A : B;
        String[] bigger = A.length < B.length ? B : A;
//        for(int i = 0; i < A.length; i++) {
//            int j = i;
        for (int j = 0; j < bigger.length; j++) {
            int i = 0;
            int j_ = j;
            do {
                System.out.println(i + " " + j_);
                if (j_ >= bigger.length - 1) {
                    j_ = 0;
                } else {
                    j_++;
                }

                i++;

            } while (i < smaller.length);
            System.out.println("----------------");
        }
    }

    private static float compare(String a, String b) {
        return 0f;
    }

    private static class WordIterator implements Iterator<String> {

        @Override
        public boolean hasNext() {
            return false;
        }

        @Override
        public String next() {
            return null;
        }
    }
}