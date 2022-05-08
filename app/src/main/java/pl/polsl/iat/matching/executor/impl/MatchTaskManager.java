package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.schema.*;
import pl.polsl.iat.matching.matchers.ComponentMatcher;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;


/**
 *
 */
public class MatchTaskManager {

    private static final MatchTaskManager managerInstance = new MatchTaskManager();
    private final ComponentMatcher componentMatcher;

    private MatchTaskManager() {
        componentMatcher = ComponentMatcher.getInstance();
    }

    public static MatchTaskManager getInstance() {
        return managerInstance;
    }

    public List<Callable<Boolean>> getTasksForSchemaPair(Schema first, Schema second, MatchingComponent rMatchingComponent) {
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

        rMatchingComponent.setMatchScore(1);
        return subTasks;
    }

    private Callable<Boolean> getTaskTable(Table first, Table second, MatchingComponent rMatchingComponent) {
        return () -> {
            List<Boolean> columnMatchResults = new ArrayList<>();
            int nFirst = first.getComponents().size();
            int nSecond = second.getComponents().size();
            rMatchingComponent.setMatchScore(first.getName().equals(second.getName()) ? 100 : 0);
//            System.out.println("Started " + first.getName() + " " + second.getName());
            for (int i = 0; i < nFirst; i++) {
                for (int j = 0; j < nSecond; j++) {
                    columnMatchResults.add(getTaskColumn(first.getComponents().get(i), second.getComponents().get(j),
                            rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)).call());
                }
            }
//            System.out.println("Finished " + first.getName() + " " + second.getName());

            rMatchingComponent.setMatchScore(1);
//            rMatchingComponent.setMatch(new TableMatcher(first,second,rMatchingComponent).doMatch());
//            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
            return true;
        };
    }

    private Callable<Boolean> getTaskColumn(Column first, Column second, MatchingComponent rMatchingComponent) {
        return () -> {
            rMatchingComponent.setMatchScore(1);
//            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
//            rMatchingComponent.setMatch(new ColumnMatcher(first, second, rMatchingComponent).doMatch());
            return true;
        };
    }

}
