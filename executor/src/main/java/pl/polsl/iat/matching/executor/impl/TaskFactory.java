package pl.polsl.iat.matching.executor.impl;

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
        int nFirst = first.getComponents().size();
        int nSecond = second.getComponents().size();
        List<Callable<Boolean>> subTasks = new ArrayList<>();
        for (int i = 0; i < nFirst; i++) {
            for (int j = 0; j < nSecond; j++) {
                subTasks.add(getTaskTable(first.getComponents().get(i), second.getComponents().get(j),
                        rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)));
            }
        }
//        rMatchingComponent.setMatch(new SchemaMatcher(first, second, rMatchingComponent).doMatch());

        rMatchingComponent.setMatch(1);
        return subTasks;
    }

    private Callable<Boolean> getTaskTable(Table first, Table second, MatchingComponent rMatchingComponent) {
        return () -> {
            List<Boolean> columnMatchResults = new ArrayList<>();
            int nFirst = first.getComponents().size();
            int nSecond = second.getComponents().size();
            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
//            System.out.println("Started " + first.getName() + " " + second.getName());
            for (int i = 0; i < nFirst; i++) {
                for (int j = 0; j < nSecond; j++) {
                    columnMatchResults.add(getTaskColumn(first.getComponents().get(i), second.getComponents().get(j),
                            rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)).call());
                }
            }
//            System.out.println("Finished " + first.getName() + " " + second.getName());

            rMatchingComponent.setMatch(1);
//            rMatchingComponent.setMatch(new TableMatcher(first,second,rMatchingComponent).doMatch());
//            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
            return true;
        };
    }

    private Callable<Boolean> getTaskColumn(Column first, Column second, MatchingComponent rMatchingComponent) {
        return () -> {
            rMatchingComponent.setMatch(1);
//            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
//            rMatchingComponent.setMatch(new ColumnMatcher(first, second, rMatchingComponent).doMatch());
            return true;
        };
    }

}
