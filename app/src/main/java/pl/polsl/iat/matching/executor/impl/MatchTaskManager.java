package pl.polsl.iat.matching.executor.impl;

import pl.polsl.iat.matching.concurrency.TableMatcherSupplier;
import pl.polsl.iat.matching.core.model.schema.*;
import pl.polsl.iat.matching.matchers.Matcher;
import pl.polsl.iat.matching.matchers.TableMatcher;
import pl.polsl.iat.matching.matchers.impl.ColumnMatcherImpl;
import pl.polsl.iat.matching.matchers.impl.SchemaMatcherImpl;
import pl.polsl.iat.matching.matchers.impl.TableMatcherImpl;
import pl.polsl.iat.matching.core.model.result.MatchingComponent;
import pl.polsl.iat.matching.matchers.MatcherSettings;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.stream.Collectors;
import java.util.stream.IntStream;


/**
 *
 */
public class MatchTaskManager {

    private static final MatchTaskManager managerInstance = new MatchTaskManager();
    private final TableMatcherSupplier matcherSupplier;
    private final Map<ComponentType, Matcher<? extends Component>> componentMatchers;
//    private final
    private MatchTaskManager() {
        List<TableMatcher> matchers =
                IntStream.range(0, MatcherSettings.getSettings().getNumberOfThreads())
                        .mapToObj(i -> new TableMatcherImpl())
                        .collect(Collectors.toList());
        matcherSupplier = TableMatcherSupplier.initialize(matchers);
        componentMatchers = Map.of(
                ComponentType.SCHEMA, new SchemaMatcherImpl(),
                ComponentType.TABLE, new TableMatcherImpl(),
                ComponentType.COLUMN, new ColumnMatcherImpl()
        );
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
