package pl.polsl.iat.matching.result;

import com.google.common.collect.Lists;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.core.model.result.Component;
import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.result.MatchingResult;
import pl.polsl.iat.matching.core.model.result.ResultComponentType;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class ResultTest {

    class Pair {
        String first, second;
        public Pair(String first, String second) {
            this.first = first;
            this.second = second;
        }

        @Override
        public String toString() {
            return first + "+" + second;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Pair pair = (Pair) o;
            return Objects.equals(second, pair.second) || Objects.equals(first, pair.first);
        }

        @Override
        public int hashCode() {
            return Objects.hash(second);
        }
    }

    @Test
    public void test() {


//        List<Pair> A = List.of(new Pair("A","a"), new Pair("A","b"), new Pair("A","c"), new Pair("A","d"), new Pair("A","e"), new Pair("A","f"), new Pair("A","g"), new Pair("A","h"));
//        List<Pair> B = List.of(new Pair("B","a"), new Pair("B","b"), new Pair("B","c"), new Pair("B","d"), new Pair("B","e"), new Pair("B","f"), new Pair("B","g"), new Pair("B","h"));
//        List<Pair> C = List.of(new Pair("C","a"), new Pair("C","b"), new Pair("C","c"), new Pair("C","d"), new Pair("C","e"), new Pair("C","f"), new Pair("C","g"), new Pair("C","h"));
//        List<Pair> D = List.of(new Pair("D","a"), new Pair("D","b"), new Pair("D","c"), new Pair("D","d"), new Pair("D","e"), new Pair("D","f"), new Pair("D","g"), new Pair("D","h"));
//        List<Pair> E = List.of(new Pair("E","a"), new Pair("E","b"), new Pair("E","c"), new Pair("E","d"), new Pair("E","e"), new Pair("E","f"), new Pair("E","g"), new Pair("E","h"));
//        List<Pair> F = List.of(new Pair("F","a"), new Pair("F","b"), new Pair("F","c"), new Pair("F","d"), new Pair("F","e"), new Pair("F","f"), new Pair("F","g"), new Pair("F","h"));
//        List<Pair> G = List.of(new Pair("G","a"), new Pair("G","b"), new Pair("G","c"), new Pair("G","d"), new Pair("G","e"), new Pair("G","f"), new Pair("G","g"), new Pair("G","h"));
//        List<Pair> H = List.of(new Pair("H","a"), new Pair("H","b"), new Pair("H","c"), new Pair("H","d"), new Pair("H","e"), new Pair("H","f"), new Pair("H","g"), new Pair("H","h"));
//        List<Pair> I = List.of(new Pair("I","a"), new Pair("I","b"), new Pair("I","c"), new Pair("I","d"), new Pair("I","e"), new Pair("I","f"), new Pair("I","g"), new Pair("I","h"));
//        List<Pair> J = List.of(new Pair("J","a"), new Pair("J","b"), new Pair("J","c"), new Pair("J","d"), new Pair("J","e"), new Pair("J","f"), new Pair("J","g"), new Pair("J","h"));
//        List<Pair> K = List.of(new Pair("K","a"), new Pair("K","b"), new Pair("K","c"), new Pair("K","d"), new Pair("K","e"), new Pair("K","f"), new Pair("K","g"), new Pair("K","h"));
//        List<Pair> D = List.of(new Pair("D","a"), new Pair("D","b"), new Pair("D","c"), new Pair("D","d"));
        List<Pair> A = List.of(new Pair("A","a"), new Pair("A","b"), new Pair("A","c"), new Pair("A","d"));
        List<Pair> B = List.of(new Pair("B","a"), new Pair("B","b"), new Pair("B","c"), new Pair("B","d"));
        List<Pair> C = List.of(new Pair("C","a"), new Pair("C","b"), new Pair("C","c"), new Pair("C","d"));
//        List<Pair> D = List.of(new Pair("D","a"), new Pair("D","b"), new Pair("D","c"));
//
        // A B C
        // a b

        // [[Aa,Ba,Ca],[Ab,Bb,Cb]]
        // [[Aa, Ab],[Ba, Bb],[Ca,Cb]]
//        List<String> B = List.of("Ba", "Bb", "Bc");
//        List<String> C = List.of("Ca", "Cb", "Cc");
//        List<Integer> D = List.of(55, 100, 50, 54);
//        List<Integer> E = List.of(55, 100, 50, 54);

//        List<Integer> C = List.of(27, 50, 100);
//        List<List<Integer>> l1 = List.of(List.of(1, 2, 3), List.of(2, 3, 4));
        // [[1,2,3],
        // [2,3,4]]

        // [1,2]
        // [2,3]
        // [3,4]
//        List<List<Integer>> l2 = new ArrayList<>();
//        for(int i = 0; i < l1.size(); i++){
//            List<Integer> subList = new ArrayList<>();
//            for(int j = 0; j < l1.get(i).size();j++){
//                subList.add(l1.get(j).get(i));
//            }
//            l2.add(subList);
//        }
//        System.out.println(l1);
//        System.out.println(l2);
        long start = System.currentTimeMillis();
//        var input = List.of(A, B, C);
//        int n = input.size();
//        int m = input.get(0).size();
//        if(n > m)
//            input = transpose(input);
//        List<List<Pair>> res = cartesianProduct(input);
//
//        res.forEach(System.out::println);
        List<List<Integer>> t1 = new ArrayList<>();
        int n = 11, m = 11;
        for(int i = 0; i < n; i++) {
            t1.add(IntStream.range(0,m).boxed().collect(Collectors.toList()));
        }
//        t1.forEach(System.out::println);
//        if(n > m) {
//            t1 = transpose(t1);
//        }
//        t1.forEach(System.out::println);

////        List<List<Pair>> lists = cartesianProduct(List.of(A, B));
        var res = cartesianProduct(t1);
        long end = System.currentTimeMillis();
        System.out.println(end - start);
        System.out.println(res.size());
//        lists.forEach(System.out::println);

    }

    protected List<List<Pair>> transpose(List<List<Pair>> matrix) {
        int m = matrix.get(0).size();
        int n = matrix.size();
        List<Pair[]> transpose = new ArrayList<>(m);
        IntStream.range(0,m).forEach(x -> transpose.add(new Pair[n]));
        for(int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                transpose.get(j)[i] = matrix.get(i).get(j);
            }
        }
        return transpose.stream().map(List::of).toList();
    }

    protected <T> List<List<T>> cartesianProduct(List<List<T>> lists) {
        List<List<T>> resultLists = new ArrayList<List<T>>();
        if (lists.size() == 0) {
            resultLists.add(new ArrayList<T>());
            return resultLists;
        } else {
            List<T> firstList = lists.get(0);
            List<List<T>> remainingLists = cartesianProduct(lists.subList(1, lists.size()));
            for (T condition : firstList) {
                for (List<T> remainingList : remainingLists) {
                    ArrayList<T> resultList = new ArrayList<T>();
                    if(remainingList.contains(condition))
                        continue;
                    resultList.add(condition);
                    resultList.addAll(remainingList);
                    resultLists.add(resultList);
                }
            }
        }
        return resultLists;
    }
//
//    static class Pair {
//        Component component;
//        MatchingComponent matchingComponent;
//        Integer result;
//
//        public Pair(Component component, MatchingComponent matchingComponent, Integer result) {
//            this.component = component;
//            this.matchingComponent = matchingComponent;
//            this.result = result;
//        }
//
//        @Override
//        public boolean equals(Object o) {
//            if (this == o) return true;
//            if (o == null || getClass() != o.getClass()) return false;
//            MatchingResult.Pair pair = (MatchingResult.Pair) o;
//            return Objects.equals(matchingComponent, pair.matchingComponent);
//        }
//
//        @Override
//        public int hashCode() {
//            return Objects.hash(matchingComponent);
//        }
//
//        public int getResult(){
//            return result;
//        }
//    }
//
//
//    public int cartesianProduct(MatchingComponent parentComponentMatch, Function<MatchingComponent, ? extends Number> getMatchScoreFun) {
//        List<List<MatchingResult.Pair>> lists = new ArrayList<>();
//        for (Component childComponent : parentComponentMatch.getComponent()) {
//            if (childComponent.type != ResultComponentType.COLUMN)
//                evaluateChildren(childComponent);
//            List<MatchingResult.Pair> list = new ArrayList<>();
//            for (MatchingComponent childMatchingComponent : childComponent.getMatchingComponent()) {
//                list.add(new MatchingResult.Pair(childComponent, childMatchingComponent, getMatchScoreFun.apply(childMatchingComponent).intValue()));
//            }
//            lists.add(list);
//        }
//
//        List<List<MatchingResult.Pair>> lists1 = cartesianProduct(lists);
//
//        Double max = lists1.stream()
//                .map(list ->
//                        list.stream()
//                                .collect(Collectors.summarizingInt(MatchingResult.Pair::getResult))
//                                .getAverage())
//                .max(Double::compareTo).orElse(0.0);
//        return max.intValue();
//    }
//
//    protected <T> List<List<T>> cartesianProduct1(List<List<T>> lists) {
//        List<List<T>> resultLists = new ArrayList<List<T>>();
//        if (lists.size() == 0) {
//            resultLists.add(new ArrayList<T>());
//            return resultLists;
//        } else {
//            List<T> firstList = lists.get(0);
//            List<List<T>> remainingLists = cartesianProduct1(lists.subList(1, lists.size()));
//            for (T condition : firstList) {
//                for (List<T> remainingList : remainingLists) {
//                    ArrayList<T> resultList = new ArrayList<T>();
//                    if(remainingList.contains(condition))
//                        continue;
//                    resultList.add(condition);
//                    resultList.addAll(remainingList);
//                    resultLists.add(resultList);
//                }
//            }
//        }
//        System.out.println(resultLists.size());
//        return resultLists;
//
//    }
}
