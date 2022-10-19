//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.3.1 
// See <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2021.07.30 at 12:12:44 AM AZT 
//
package pl.polsl.iat.matching.core.model.result;

import com.google.common.collect.Lists;
import pl.polsl.iat.matching.core.exception.MatchingException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.annotation.*;
import java.io.File;
import java.math.BigDecimal;
import java.util.*;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * <p>Java class for matching-result complex type.
 *
 * <p>The following schema fragment specifies the expected content contained within this class.
 *
 * <pre>
 * &lt;complexType name="matching-result"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="component" type="{}component"/&gt;
 *         &lt;element name="matching-component" type="{}matching-component"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 *
 *
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "matching-result", propOrder = {
        "components"
})
@XmlRootElement
public class MatchingResult {

    @XmlElement(required = true, name = "component")
    protected List<Component> components;


    @XmlTransient
    protected ResultLevel resultLevel = ResultLevel.COLUMN;

    /**
     * Gets the value of the component property.
     *
     * @return
     *     possible object is
     *     {@link Component }
     *
     */
    public List<Component> getComponents() {
        return components;
    }

    /**
     * Sets the value of the component property.
     *
     * @param value
     *     allowed object is
     *     {@link Component }
     *
     */
    public void setComponents(List<Component> value) {
        this.components = value;
    }

    /**
     * Gets the value of the matchingComponent property.
     *
     * @return
     *     possible object is
     *     {@link MatchingComponent }
     *
     */
//    public MatchingComponent getMatchingComponent() {
//        return matchingComponent;
//    }

    public ResultLevel getResultLevel() {
        return resultLevel;
    }

    public void setResultLevel(ResultLevel resultLevel) {
        this.resultLevel = resultLevel;
    }

    /**
     * Sets the value of the matchingComponent property.
     *
     *     allowed object is
     *     {@link MatchingComponent }
     *
     */
//    public void setMatchingComponent(MatchingComponent value) {
//        this.matchingComponent = value;
//    }


    public void save(String filePath) {
        try {
            if(resultLevel != ResultLevel.COLUMN) {
                for (Component schemaComp : components) {
                    for (MatchingComponent schemaMatch : schemaComp.matchingComponent) {
                        if (resultLevel == ResultLevel.SCHEMA)
                            schemaMatch.clearChildren();
                        else if (resultLevel == ResultLevel.TABLE) {
                            for (Component tableComp : schemaMatch.component)
                                for (MatchingComponent tableMatch : tableComp.matchingComponent)
                                    tableMatch.clearChildren();
                        }
                    }
                }
            }
            JAXBContext context = JAXBContext.newInstance(MatchingResult.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(this, new File(filePath));
        } catch (JAXBException e) {
            throw new MatchingException("Failed to write result file to " + filePath, e);
        }
    }

    /**
     * Schema1
     *  Schema2
     *    Schema1.Table1
     *      Schema2.Table1
     *        Schema1.Table1.Column1
     *          Schema2.Table2.Column1
     *          Schema2.Table2.Column2
     *          Schema2.Table2.Column3
     *        Schema1.Table1.Column2
     *          .....
     *        Schema1.Table1.Column3
     *          ....
     *      Schema2.Table2
     *
     *      Schema2.Table3
     *  Schema3
     */
    private void evaluateParentsAverage() {
        for (Component schema : components) {
            for (MatchingComponent schemaMatch : schema.getMatchingComponent()) {
                for (Component table : schemaMatch.getComponent()) {
                    for (MatchingComponent tableMatch : table.getMatchingComponent()) {
                        Map<String, String> matchMap = new TreeMap<>();
                        List<Component> columns = tableMatch.getComponent();
                        int total = 0;
                        for(Component column : columns) {

                            List<MatchingComponent> columnMatches = getMatchingComponentSorted(column);
                            int i = 0;
                            int result = columnMatches.get(i).getMetadataScore().intValue();
                            while (matchMap.containsKey(columnMatches.get(i).name) && i < columnMatches.size() - 1) {
                                i++;
                                result += columnMatches.get(i).getMetadataScore().intValue();
                            }
                            matchMap.put(column.name, columnMatches.get(i).name);
                            total+=result;
                            column.setScore(result);
                        }
                        tableMatch.setCombinedScoreAverage(total/columns.size());
                    }

                }
            }
        }
    }

    public static enum ResultLevel {
        SCHEMA, TABLE, COLUMN
    }

    public void evaluate() {
//        evaluateParentsGreedy();
//        evaluateParentsAverage();

        iterateTree(components);

//        evaluateParentsRandom();
    }

    private void evaluateParentsGreedy() {
        for (Component schema : components) {
            for (MatchingComponent schemaMatch : schema.getMatchingComponent()) {
                for (Component table : schemaMatch.getComponent()) {
                    for (MatchingComponent tableMatch : table.getMatchingComponent()) {
                        int greedyResult = 0;

                        List<Component> columns = tableMatch.getComponent();
                        Set<MatchingComponent> used = new HashSet<>();
                        for(Component column : columns) {

                            MatchingComponent columnMatch = getMatchingComponentSorted(column)
                                    .stream()
                                    .filter(Predicate.not(used::contains))
                                    .findFirst().orElse(null);
                            if(columnMatch != null) {
                                column.setMatchingComponentId(columnMatch.getId());
                                column.setScore(columnMatch.getMetadataScore().intValue());
                                used.add(columnMatch);
                            }
                            greedyResult = (int) (used.stream().map(MatchingComponent::getMetadataScore).mapToDouble(BigDecimal::doubleValue).sum() / used.size());
                        }
                        tableMatch.setCombinedScoreGreedy(greedyResult);
                    }
                }
            }
        }
    }

    /**
     * 1. A
     * 2. B
     *
     * 1. a
     * 2. b
     * 3. c
     *
     * Aa Bc
     * Ab Ba
     * Ac B
     */
    private void evaluateParentsRandom() {

        double maxCombinations = Math.pow(8,8);
//        double maxCombinations = 1d;
        for (Component schema : components) {
            for (MatchingComponent schemaMatch : schema.getMatchingComponent()) {
                for (Component table : schemaMatch.getComponent()) {
                    for (MatchingComponent tableMatch : table.getMatchingComponent()) {
                        int sizeLeft = tableMatch.getComponent().size();
                        int sizeRight = tableMatch.getComponent().get(0).getMatchingComponent().size();
                        double numberOfCombinations = Math.pow(Math.min(sizeLeft, sizeRight), Math.max(sizeLeft, sizeRight));
                        int iter = numberOfCombinations <= maxCombinations ? (int) numberOfCombinations : (int)maxCombinations;
                        Combo bestCombination = null;
                        List<Component> components = tableMatch.getComponent();
                        List<MatchingComponent> matchingComponents = components.get(0).getMatchingComponent();
                        for(int i = 0; i < iter; i++) {
                            Combo combo = getRandomCombo(new ArrayList<>(components), new ArrayList<>(matchingComponents), MatchingComponent::getMatchScore);
                            if(bestCombination == null) {
                                bestCombination = combo;
                            } else if(bestCombination.getResult() < combo.getResult()) {
                                bestCombination = combo;
                            }
                        }
                        tableMatch.setCombinedScoreRandom(bestCombination.getResult());
                    }
                }
            }
        }
    }

    @XmlTransient
    private Random r = new Random(System.currentTimeMillis());

    @XmlTransient
    private double maxCombinations = 20;//Math.pow(8,8);


    private Combo getRandomCombo(ArrayList<Component> components, ArrayList<MatchingComponent> matchingComponents, Function<MatchingComponent, ? extends Number> getMatchScoreFun) {
        Combo combo = new Combo();
        List<Integer> availableComponents = new ArrayList<>(IntStream.range(0, matchingComponents.size()).boxed().toList());
        while(components.size() > 0 && availableComponents.size() > 0) {
            Component a = components.remove(r.nextInt(components.size()));
            MatchingComponent b = a.getMatchingComponent().get(availableComponents.remove(r.nextInt(availableComponents.size())));
            combo.add(new Pair(a, b, getMatchScoreFun.apply(b).intValue()));
        }
        return combo;
    }

    static class Combo extends ArrayList<Pair> {
        int result;
        boolean ready = false;

        public int getResult() {
            if(ready) {
                return result;
            }
            result = this.stream().mapToInt(x -> x.result).sum() / this.size();
            ready = true;
            return result;
        }
    }

    static class Pair {
        Component component;
        MatchingComponent matchingComponent;
        Integer result;

        public Pair(Component component, MatchingComponent matchingComponent, Integer result) {
            this.component = component;
            this.matchingComponent = matchingComponent;
            this.result = result;
        }
    }

    private void iterateTree(List<Component> parentComponents) {
        //schema match
        for(Component parentComponent : parentComponents) {
            for (MatchingComponent parentComponentMatch : parentComponent.getMatchingComponent()) {
                if (parentComponent.type == ResultComponentType.SCHEMA)
                    iterateTree(parentComponentMatch.getComponent());
                int greedyResult = getGreedyResult(parentComponentMatch);
                int randomResult = getRandomResult(parentComponentMatch);
                int metaDataScore = parentComponentMatch.getMetadataScore().intValue();
                int n = parentComponentMatch.component.size();
                int m = parentComponentMatch.component.get(0).matchingComponent.size();
                float x = m*n;
                float y = (x+1)/x - 1;
                metaDataScore *= y;
                greedyResult = (int) Math.ceil(greedyResult * (1 - y) + metaDataScore);
                randomResult = (int) Math.ceil(randomResult * (1 - y) + metaDataScore);
                System.out.println(x + " " + y);
                parentComponentMatch.setCombinedScoreGreedy(greedyResult);
                parentComponentMatch.setCombinedScoreRandom(randomResult);
//                int averageResult = getAverageResult(parentComponentMatch);
//                parentComponentMatch.setCombinedScoreAverage(averageResult);
            }
        }
    }

    private int getAverageResult(MatchingComponent parentComponentMatch) {
        Map<String, String> matchMap = new TreeMap<>();
        List<Component> columns = parentComponentMatch.getComponent();
        int total = 0;
        for(Component column : columns) {

            List<MatchingComponent> columnMatches = getMatchingComponentSorted(column);
            int i = 0;
            int result = columnMatches.get(i).getMetadataScore().intValue();
            while (matchMap.containsKey(columnMatches.get(i).name) && i < columnMatches.size() - 1) {
                i++;
                result += columnMatches.get(i).getMatchScore().intValue();
            }
            matchMap.put(column.name, columnMatches.get(i).name);
            total+=result;
//            column.setScore(result);
        }
        return total/columns.size();

    }

    private int getRandomResult(MatchingComponent parentComponentMatch) {
        Function<MatchingComponent, ? extends Number> getMatchScoreFun = MatchingComponent::getMatchScore;
        if(ResultComponentType.SCHEMA == parentComponentMatch.type) {
            getMatchScoreFun = MatchingComponent::getCombinedScoreRandom;
        }

        int sizeLeft = parentComponentMatch.getComponent().size();
        int sizeRight = parentComponentMatch.getComponent().get(0).getMatchingComponent().size();
        double numberOfCombinations = Math.pow(Math.min(sizeLeft, sizeRight), Math.max(sizeLeft, sizeRight));
        int iter = numberOfCombinations <= maxCombinations ? (int) numberOfCombinations : (int)maxCombinations;
        Combo bestCombination = null;
        List<Component> components = parentComponentMatch.getComponent();
        List<MatchingComponent> matchingComponents = components.get(0).getMatchingComponent();
        for(int i = 0; i < iter; i++) {
            Combo combo = getRandomCombo(new ArrayList<>(components), new ArrayList<>(matchingComponents), getMatchScoreFun);
            if(bestCombination == null) {
                bestCombination = combo;
            } else if(bestCombination.getResult() < combo.getResult()) {
                bestCombination = combo;
            }
        }
        return bestCombination.getResult();
    }

    private int getGreedyResult(MatchingComponent parentComponentMatch) {
        Function<MatchingComponent, ? extends Number> getMatchScoreFun = MatchingComponent::getMatchScore;
        if(ResultComponentType.SCHEMA == parentComponentMatch.type) {
            getMatchScoreFun = MatchingComponent::getCombinedScoreGreedy;
        }

        List<Component> childComponents = parentComponentMatch.getComponent();
        Set<MatchingComponent> used = new HashSet<>();
        for(Component childComponent : childComponents) {
            MatchingComponent columnMatch = getMatchingComponentSorted(childComponent)
                    .stream()
                    .filter(Predicate.not(used::contains))
                    .findFirst().orElse(null);
            if(columnMatch != null) {
                //TODO best match
//                childComponent.setMatchingComponentId(columnMatch.getId());
//                childComponent.setScore(columnMatch.getMatchScore().intValue());
                used.add(columnMatch);
            }
        }
        return (int) (used.stream().map(getMatchScoreFun).mapToDouble(Number::doubleValue).sum() / used.size());
    }

    private List<MatchingComponent> getMatchingComponentSorted(Component component) {
        if(!component.sorted) {
            component.getMatchingComponent().sort((o1, o2) -> Comparator.comparing(MatchingComponent::getMetadataScore).reversed().compare(o1,o2));
            component.sorted = true;
        }
        return component.getMatchingComponent();
    }
    /**
     * <strong>Schema Structure</strong>
     * A
     *  A.AA
     *   A.AA.A
     *   A.AA.B
     *   A.AA.C
     *  A.AB
     *   A.AB.A
     *   A.AB.B
     *   A.AB.C
     *
     * B
     *  B.AA
     *   B.AA.A
     *   B.AA.B
     *   B.AA.C
     *  B.AB
     *   B.AB.A
     *   B.AB.B
     *   B.AB.C
     *
     *
     *   A.AA -- B.AA
     *     A.AA.A -- B.AA.A
     *     A.AA.A -- B.AA.B
     *     A.AA.A -- B.AA.C
     *     A.AA.B -- B.AA.A
     *     A.AA.B -- B.AA.B
     *     A.AA.B -- B.AA.C
     *     A.AA.C -- B.AA.A
     *     A.AA.C -- B.AA.B
     *     A.AA.C -- B.AA.C
     *
     *   A.AA -- B.AB
     *     A.AA.A -- B.AB.A
     *     A.AA.A -- B.AB.B
     *     A.AA.A -- B.AB.C
     *     A.AA.B -- B.AB.A
     *     A.AA.B -- B.AB.B
     *     A.AA.B -- B.AB.C
     *     A.AA.C -- B.AB.A
     *     A.AA.C -- B.AB.B
     *     A.AA.C -- B.AB.C
     *
     *   A.AB -- B.AA
     *     A.AB.A -- B.AA.A
     *     A.AB.A -- B.AA.B
     *     A.AB.A -- B.AA.C
     *     A.AB.B -- B.AA.A
     *     A.AB.B -- B.AA.B
     *     A.AB.B -- B.AA.C
     *     A.AB.C -- B.AA.A
     *     A.AB.C -- B.AA.B
     *     A.AB.C -- B.AA.C
     *
     *   A.AB -- B.AB
     *     A.AB.A -- B.AB.A
     *     A.AB.A -- B.AB.B
     *     A.AB.A -- B.AB.C
     *     A.AB.B -- B.AB.A
     *     A.AB.B -- B.AB.B
     *     A.AB.B -- B.AB.C
     *     A.AB.C -- B.AB.A
     *     A.AB.C -- B.AB.B
     *     A.AB.C -- B.AB.C
     *
     * parentComponenet -                                               A - schema, A.AA, A.AB - tables
     * parentComponentMatch - each pair for that component              B - schema, B.AA, B.AB - tables
     * childComponent - table for schema, and column for table parent   A.AA, A.AB - tables; A.AA.A, A.AA.B, A.AA.C, A.AB.A, A.AB.B, A.AB.C
     * childMatchingComponent - tableMatch or columnMatch               B.AA, B.AB - tables; B.AA.A, B.AA.B, B.AA.C, B.AB.A, B.AB.B, B.AB.C
     *
     * @param parentComponent - schema or table, those components that have child components
     *
     */
    public void evaluateChildren(Component parentComponent) {
        for (MatchingComponent parentComponentMatch : parentComponent.getMatchingComponent()) {
            List<List<Integer>> combinations = new ArrayList<>();
            Map<String, String> matchMap = new HashMap<>();
            for (Component childComponent : parentComponentMatch.getComponent()) {
                if(childComponent.type != ResultComponentType.COLUMN)
                    evaluateChildren(childComponent);

                List<MatchingComponent> childMatchingComponents = getMatchingComponentSorted(childComponent);

//                for (MatchingComponent childMatchingComponent : childComponent.getMatchingComponent()) {

//                    list.add(childMatchingComponent.getMetadataScore());

//                }
            }

//            List<List<BigDecimal>> lists1 = Lists.cartesianProduct(lists);

//            Double max = lists1.stream()
//                    .map(list ->
//                            list.stream()
//                                    .collect(Collectors.summarizingDouble(BigDecimal::doubleValue))
//                                    .getAverage())
//                    .max(Double::compareTo).orElse(0.0);
//            parentComponentMatch.setChildScore(new BigDecimal(max));
        }
    }


    public void evaluateChildren1(Component parentComponent) {
        for (MatchingComponent parentComponentMatch : parentComponent.getMatchingComponent()) {
            List<List<BigDecimal>> lists = new ArrayList<>();
            for (Component childComponent : parentComponentMatch.getComponent()) {
                if(childComponent.type != ResultComponentType.COLUMN)
                    evaluateChildren(childComponent);
                List<BigDecimal> list = new ArrayList<>();
                for (MatchingComponent childMatchingComponent : childComponent.getMatchingComponent()) {
                    list.add(childMatchingComponent.getMetadataScore());
                }
                lists.add(list);
            }

            List<List<BigDecimal>> lists1 = Lists.cartesianProduct(lists);

            Double max = lists1.stream()
                    .map(list ->
                            list.stream()
                                    .collect(Collectors.summarizingDouble(BigDecimal::doubleValue))
                                    .getAverage())
                    .max(Double::compareTo).orElse(0.0);
            parentComponentMatch.setChildScore(new BigDecimal(max));
        }
    }

}
