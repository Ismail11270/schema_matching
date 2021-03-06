package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.schema.*;
import pl.polsl.iat.matching.matchers.ComponentMatcher;
import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.util.Utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;


/**
 *
 */
public class MatchTaskManager {

    private static final MatchTaskManager managerInstance = new MatchTaskManager();
    private final Map<ComponentType, ComponentMatcher> metaMatchers = new HashMap<>();

    private MatchTaskManager() {
        metaMatchers.put(ComponentType.SCHEMA, ComponentMatcher.getInstance(ComponentType.SCHEMA));
        metaMatchers.put(ComponentType.TABLE,  ComponentMatcher.getInstance(ComponentType.TABLE));
        metaMatchers.put(ComponentType.COLUMN, ComponentMatcher.getInstance(ComponentType.COLUMN));
    }

    public static MatchTaskManager getInstance() {
        return managerInstance;
    }

    public List<Callable<Boolean>> getTasksForSchemaPair(Schema first, Schema second, MatchingComponent rMatchingComponent) {
        Logger.schema("Started matching schemas [%s] and [%s]", first.getName(), second.getName());
        int nFirst = first.getComponents().size();
        int nSecond = second.getComponents().size();
        List<Callable<Boolean>> subTasks = new ArrayList<>();
        for (int i = 0; i < nFirst; i++) {
            for (int j = 0; j < nSecond; j++) {
                subTasks.add(getTaskTable(first.getComponents().get(i), second.getComponents().get(j),
                        rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)));
            }
        }
        rMatchingComponent.setMetadataScore(Utils.parseResult(metaMatchers.get(ComponentType.SCHEMA).doMatch(first,second)));
        rMatchingComponent.setMatchScore(1);
        Logger.schema("Finished matching schemas [%s] and [%s]", first.getName(), second.getName());
        return subTasks;
    }

    private Callable<Boolean> getTaskTable(Table first, Table second, MatchingComponent rMatchingComponent) {
        return () -> {
            Logger.table("Started matching tables [%s] and [%s]", first.getName(), second.getName());
            List<Boolean> columnMatchResults = new ArrayList<>();
            int nFirst = first.getComponents().size();
            int nSecond = second.getComponents().size();
            for (int i = 0; i < nFirst; i++) {
                for (int j = 0; j < nSecond; j++) {
                    columnMatchResults.add(getTaskColumn(first.getComponents().get(i), second.getComponents().get(j),
                            rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)).call());
                }
            }
             rMatchingComponent.setMetadataScore(Utils.parseResult(metaMatchers.get(ComponentType.TABLE).doMatch(first,second)));
            rMatchingComponent.setMatchScore(1);
//            rMatchingComponent.setMatch(new TableMatcher(first,second,rMatchingComponent).doMatch());
//            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
            Logger.table("%s Finished matching tables [%s] and [%s]", Thread.currentThread().getName(), first.getName(), second.getName());
            return true;
        };
    }

    private Callable<Boolean> getTaskColumn(Column first, Column second, MatchingComponent rMatchingComponent) {
        return () -> {
            Logger.column("Started matching columns [%s] and [%s]", first.getName(), second.getName());
            rMatchingComponent.setMatchScore(1);
            rMatchingComponent.setMetadataScore(Utils.parseResult(metaMatchers.get(ComponentType.COLUMN).doMatch(first,second)));
////            rMatchingComponent.setMatch(first.getName().equals(second.getName()) ? 100 : 0);
////            rMatchingComponent.setMatch(new ColumnMatcher(first, second, rMatchingComponent).doMatch());
            Logger.column("Finished matching columns [%s] and [%s]", first.getName(), second.getName());
            return true;
        };
    }

}
