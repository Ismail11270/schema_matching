package pl.polsl.iat.matching.result;

import org.junit.jupiter.api.Test;

import java.util.Objects;
import java.util.Random;
import java.util.function.Supplier;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class GeneralTests {
    @Test
    public void test(){
        Supplier<Stream<Integer>> supplier = () -> Stream.of(1,2,3);
        var str_ = supplier.get();
        var str1 = supplier.get();
        Integer integer = str1.filter(x -> x.equals(2)).findFirst().get();
        System.out.println(integer);
        str_.forEach(System.out::println);
    }

    @Test
    public void test1(){
        Stream.iterate(1, i -> {
            return i < 10;
        }, x -> getInt(x)).filter(Objects::nonNull);
    }


    @Test
    public void test2() {
    }

    private Random rand = new Random();

    private int getInt(int x){
        return x++;
    }
}
