package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.core.model.schema.*;
import pl.polsl.iat.matching.matchers.ComponentMatcher;
import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.util.Utils;
import pl.polsl.iat.matching.matchers.result.Results;

import java.math.BigDecimal;
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

    public List<Callable<Integer>> getTasksForSchemaPair(Schema first, Schema second, MatchingComponent rMatchingComponent) {
        Logger.schema("Started matching schemas [%s] and [%s]", first.getName(), second.getName());
        int nFirst = first.getComponents().size();
        int nSecond = second.getComponents().size();
        List<Callable<Integer>> subTasks = new ArrayList<>();
        for (int i = 0; i < nFirst; i++) {
            for (int j = 0; j < nSecond; j++) {
                subTasks.add(getTaskTable(first.getComponents().get(i), second.getComponents().get(j),
                        rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)));
            }
        }
        rMatchingComponent.setMetadataScore(Utils.parseResult(metaMatchers.get(ComponentType.SCHEMA).doMatch(first,second)));
        Logger.schema("Finished matching schemas [%s] and [%s]", first.getName(), second.getName());
        return subTasks;
    }

    private Callable<Integer> getTaskTable(Table first, Table second, MatchingComponent rMatchingComponent) {
        return () -> {
            Logger.table("Started matching tables [%s] and [%s]", first.getName(), second.getName());
            List<Integer> columnMatchResults = new ArrayList<>();
            int nFirst = first.getComponents().size();
            int nSecond = second.getComponents().size();
            for (int i = 0; i < nFirst; i++) {
                for (int j = 0; j < nSecond; j++) {
                    columnMatchResults.add(getTaskColumn(first.getComponents().get(i), second.getComponents().get(j),
                            rMatchingComponent.getComponent().get(i).getMatchingComponent().get(j)).call());
                }
            }
             rMatchingComponent.setMetadataScore(Utils.parseResult(metaMatchers.get(ComponentType.TABLE).doMatch(first,second)));
            return 1;
        };
    }

    private Callable<Integer> getTaskColumn(Column first, Column second, MatchingComponent rMatchingComponent) {
        return () -> {
            Logger.column("Started matching columns [%s] and [%s]", first.getName(), second.getName());
            Results results = metaMatchers.get(ComponentType.COLUMN).doMatch(first, second);
            rMatchingComponent.setMatchScore(Utils.parseResult(results));
            Logger.column("Finished matching columns [%s] and [%s]", first.getName(), second.getName());
            return results.calculateResult();
        };
    }

}
