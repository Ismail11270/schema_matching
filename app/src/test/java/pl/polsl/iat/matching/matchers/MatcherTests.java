package pl.polsl.iat.matching.matchers;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import pl.polsl.iat.matching.dictionary.exception.NlpMildException;
import pl.polsl.iat.matching.dictionary.nlp.NLPTools;
import pl.polsl.iat.matching.matchers.word.WordsMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcherFactory;
import pl.polsl.iat.matching.processing.FullStringProcessor;
import pl.polsl.iat.matching.processing.Words;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.util.*;
import java.util.concurrent.*;
import java.util.stream.IntStream;

public class MatcherTests {

    private static MatcherSettings settings;

    private static FullStringProcessor strPrc;
    private static WordsMatcher matcher;

    @BeforeAll
    public static void before() throws NlpMildException {
        NLPTools.init(false);
        settings = MatcherSettings.getSettings();
        strPrc = FullStringProcessor.get();
        matcher = WordsMatcherFactory.getWordsMatcher();
    }


    static class Task implements Callable<Integer> {

        String left, right;
        Task(String left, String right) {
            this.left = left;
            this.right = right;
        }
        @Override
        public Integer call() {
            System.out.println("Started " + Thread.currentThread().getName() + " " + System.currentTimeMillis());
            Words a = strPrc.process(left);
            Words b = strPrc.process(right);

            System.out.println("Result " + Thread.currentThread().getName() + " " + matcher.doMatch(a, b));
            System.out.println("End " + Thread.currentThread().getName() + " " + System.currentTimeMillis());
            return 0;
        }
    }
    Map<String, String> cache = new Hashtable<>();
    @Test
    public void testMatchers() throws InterruptedException {
//        System.out.println(cache.computeIfAbsent("test", s -> "yes"));
//        System.out.println(cache.get("test"));
        long start = System.currentTimeMillis();

        ExecutorService service = new ThreadPoolExecutor(1, 1  ,
                0L, TimeUnit.SECONDS,
                new LinkedBlockingQueue<Runnable>());

//        service.invokeAll(IntStream.range(0,10).mapToObj(i -> new Task("person_cat", "human_dog")).toList());
        service.invokeAll(IntStream.range(0,10).mapToObj(i -> new Task("job_applicant", "job_candidate")).toList());
//        var task1 = new Task();
//        var task2 = new Task("job_applicant", "job_candidate");
//        service.submit(task1);
//        service.submit(task2);
//        service.awaitTermination(1, TimeUnit.MINUTES);
        service.shutdown();
//        Words a = strPrc.process("job_candidate");
//        Words b = strPrc.process("job_applicant");


//        System.out.println(matcher.doMatch(a, b));

        //21108
        //2995

        long time = System.currentTimeMillis() - start;
        System.out.println(time);
    }
}
