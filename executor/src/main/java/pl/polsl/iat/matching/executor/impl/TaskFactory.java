package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.processing.StringPair;
import pl.polsl.iat.matching.processing.impl.StringMatcher;
import pl.polsl.iat.matching.result.MatchingComponent;
import pl.polsl.iat.matching.schema.model.Column;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.Table;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.Callable;

public class TaskFactory {

    Random r = new Random();

    public TaskFactory() {
    }

    public List<Callable<Boolean>> getTaskSchema(Schema first, Schema second, MatchingComponent rMatchingComponent) {
//        resultComponent.
        StringMatcher stringMatcher = new StringMatcher();
        StringPair namePair = new StringPair(first.getName(), second.getName());
//            first.getCharacteristics().collect(Collectors.toList()).get(0).
        int nameComparison = stringMatcher.compare(namePair);
        int nFirst = first.getComponents().size();
        int nSecond = second.getComponents().size();
        List<Callable<Boolean>> subTasks = new ArrayList<>();
        for (int i = 0; i < nFirst; i++) {
            for (int j = 0; j < nSecond; j++) {
                subTasks.add(getTaskTable(first.getComponents().get(i), second.getComponents().get(j),
                        rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)));
            }
        }
        System.out.println(first.getName() + " " + second.getName() + " " + Thread.currentThread().getName());

        rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
        return subTasks;
    }

    private Callable<Boolean> getTaskTable(Table first, Table second, MatchingComponent rMatchingComponent) {
        return () -> {
            List<Boolean> columnMatchResults = new ArrayList<>();
            int nFirst = first.getComponents().size();
            int nSecond = second.getComponents().size();
            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
            for (int i = 0; i < nFirst; i++) {
                for (int j = 0; j < nSecond; j++) {
                    columnMatchResults.add(getTaskColumn(first.getComponents().get(i), second.getComponents().get(j),
                            rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)).call());
                }
            }
            return true;
        };
    }

    private Callable<Boolean> getTaskColumn(Column first, Column second, MatchingComponent rMatchingComponent) {
        return () -> {
            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
            return true;
        };
    }

}
