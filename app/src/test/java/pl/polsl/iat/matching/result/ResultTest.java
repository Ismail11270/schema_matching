package pl.polsl.iat.matching.result;

import com.google.common.collect.Lists;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ResultTest {


    @Test
    public void test() {


        List<Integer> A = List.of(100, 55, 27);
        List<Integer> B = List.of(55, 100, 50);
        List<Integer> C = List.of(27, 50, 100);


        long start = System.currentTimeMillis();
        long end = System.currentTimeMillis();
        System.out.println(end - start);
//        var x = cartesianProduct(List.of(A,B,C));
//        List<List<Integer>> lists = Lists.cartesianProduct(List.of(A, B, C));

//        System.out.println(lists.size());
//        lists.stream().map(list -> list.stream().collect(Collectors.summarizingInt(x -> x)).getAverage()).forEach(System.out::println);

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
                    resultList.add(condition);
                    resultList.addAll(remainingList);
                    resultLists.add(resultList);
                }
            }
        }
        return resultLists;

    }
}
