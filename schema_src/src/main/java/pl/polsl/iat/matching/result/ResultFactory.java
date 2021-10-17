// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.3.1
// See <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2021.07.28 at 12:23:39 PM AZT 
//
package pl.polsl.iat.matching.result;//

import pl.polsl.iat.matching.schema.model.Column;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.Table;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the generated package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ResultFactory {

    private final static QName _MatchingResult_QNAME = new QName("", "matching-result");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: generated
     * 
     */
    public ResultFactory() {
    }


    //TODO
    // make result generation depth e.g. schema, tables, columns
    public MatchingResult createMatchingResult(Schema... schemas) {
        var result = new MatchingResult();
        var factory = new ResultFactory();
        result.components = new ArrayList<>();
        for(int jj = 0; jj < schemas.length - 1; jj++) {
            Component schema = factory.createComponent();
            schema.type = ResultComponentType.SCHEMA;
            schema.name = schemas[jj].getName();
            for (int ii = jj+1; ii < schemas.length; ii++) {
                var schemaMatch = factory.createComponentMatch();
                schemaMatch.type = ResultComponentType.SCHEMA;
                schemaMatch.name = schemas[ii].getName();
                for (int i = 0; i < schemas[0].getComponents().size(); i++) {
                    var table = factory.createComponent();
                    Table t0 = schemas[0].getComponents().get(i);
                    table.name = t0.getName();
                    table.type = ResultComponentType.TABLE;
                    for (int j = 0; j < schemas[ii].getComponents().size(); j++) {
                        Table t1 = schemas[ii].getComponents().get(j);
                        var matchTable = factory.createComponentMatch();
                        matchTable.name = t1.getName();
                        matchTable.type = ResultComponentType.TABLE;
                        matchTable.match = BigDecimal.valueOf(0);
                        for (int k = 0; k < t0.getComponents().size(); k++) {
                            Column c0 = t0.getComponents().get(k);
                            var column = factory.createComponent();
                            column.name = c0.getName();
                            column.type = ResultComponentType.COLUMN;
                            for (int l = 0; l < t1.getComponents().size(); l++) {
                                Column c1 = t1.getComponents().get(l);
                                var columnMatch = factory.createComponentMatch();
                                columnMatch.name = c1.getName();
                                columnMatch.type = ResultComponentType.COLUMN;
                                columnMatch.match = BigDecimal.valueOf(0);
                                column.matchingComponent.add(columnMatch);
                            }
                            matchTable.component.add(column);
                        }
                        table.matchingComponent.add(matchTable);
                    }
                    schemaMatch.component.add(table);
                }
                schema.matchingComponent.add(schemaMatch);
            }
            result.components.add(schema);
        }
        return result;
    }

    /**
     * Create an instance of {@link MatchingResult }
     * 
     */
    public MatchingResult createMatchingResult() {
        return new MatchingResult();
    }

    /**
     * Create an instance of {@link Component }
     * 
     */
    public Component createComponent(MatchingComponent... componentsMatches) {
        var component = new Component();
        component.matchingComponent = new ArrayList<>(Arrays.asList(componentsMatches));
        return component;
    }

    /**
     * Create an instance of {@link MatchingComponent }
     * 
     */
    public MatchingComponent createComponentMatch(Component... childComponents) {
        var compMatch = new MatchingComponent();
        compMatch.component = new ArrayList<>((Arrays.asList(childComponents)));
        return compMatch;
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link MatchingResult }{@code >}
     * 
     * @param value
     *     Java instance representing xml element's value.
     * @return
     *     the new instance of {@link JAXBElement }{@code <}{@link MatchingResult }{@code >}
     */
    @XmlElementDecl(namespace = "", name = "matching-result")
    public JAXBElement<MatchingResult> createMatchingResult(MatchingResult value) {
        return new JAXBElement<MatchingResult>(_MatchingResult_QNAME, MatchingResult.class, null, value);
    }

}
