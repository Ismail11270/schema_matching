package pl.polsl.iat.matcher.executor;

import org.junit.jupiter.api.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExecutorTest {

    public void test() {

        Pattern ptrn = Pattern.compile("([a-zA-Z]+) (\\d+)");
        Matcher matcher = ptrn.matcher("June 24, August 9, Dec 12");

// This will reorder the string inline and print:
//   24 of June, 9 of August, 12 of Dec
// Remember that the first group is always the full matched text, so the
// month and day indices start from 1 instead of zero.
        String replacedString = matcher.replaceAll("$2 of $1");
        System.out.println(replacedString);
    }


    @Test
    public void test1() {

    }

    private void addInt(Integer a, int i) {
        a+=i;
    }
}
