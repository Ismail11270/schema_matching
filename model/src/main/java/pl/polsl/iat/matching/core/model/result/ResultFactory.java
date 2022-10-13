// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.3.1
// See <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2021.07.28 at 12:23:39 PM AZT 
//
package pl.polsl.iat.matching.core.model.result;//

import pl.polsl.iat.matching.core.model.schema.Column;
import pl.polsl.iat.matching.core.model.schema.Schema;
import pl.polsl.iat.matching.core.model.schema.Table;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;


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


    public MatchingResult createMatchingResult(Schema... schemas) {
        var result = new MatchingResult();
        var factory = new ResultFactory();
        result.components = Collections.synchronizedList(new ArrayList<>());
        for(int jj = 0; jj < schemas.length - 1; jj++) {
            Component schema = factory.createComponent();
            schema.type = ResultComponentType.SCHEMA;
            schema.name = schemas[jj].getName();
            schema.id = "c" + jj;
            for (int ii = jj+1; ii < schemas.length; ii++) {
                var schemaMatch = factory.createComponentMatch();
                schemaMatch.type = ResultComponentType.SCHEMA;
                schemaMatch.name = schemas[ii].getName();
                schemaMatch.matchScore = BigDecimal.valueOf(0);
                schemaMatch.id = "" + ii;
                for (int i = 0; i < schemas[jj].getComponents().size(); i++) {
                    var table = factory.createComponent();
                    Table t0 = schemas[jj].getComponents().get(i);
                    table.name = t0.getName();
                    table.type = ResultComponentType.TABLE;
                    table.id = schema.id + "." + i;
                    for (int j = 0; j < schemas[ii].getComponents().size(); j++) {
                        Table t1 = schemas[ii].getComponents().get(j);
                        var matchTable = factory.createComponentMatch();
                        matchTable.name = t1.getName();
                        matchTable.type = ResultComponentType.TABLE;
                        matchTable.matchScore = BigDecimal.valueOf(0);
                        matchTable.id = ii + "." + j;
                        for (int k = 0; k < t0.getComponents().size(); k++) {
                            Column c0 = t0.getComponents().get(k);
                            var column = factory.createComponent();
                            column.name = c0.getName();
                            column.type = ResultComponentType.COLUMN;
                            column.id = table.id + "." + k;
                            for (int l = 0; l < t1.getComponents().size(); l++) {
                                Column c1 = t1.getComponents().get(l);
                                var columnMatch = factory.createComponentMatch();
                                columnMatch.name = c1.getName();
                                columnMatch.type = ResultComponentType.COLUMN;
                                columnMatch.matchScore = BigDecimal.valueOf(0);
                                columnMatch.id = ii + "." + j + "." + l;
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
        component.matchingComponent = Collections.synchronizedList(new ArrayList<>(Arrays.asList(componentsMatches)));
        return component;
    }

    /**
     * Create an instance of {@link MatchingComponent }
     * 
     */
    public MatchingComponent createComponentMatch(Component... childComponents) {
        var compMatch = new MatchingComponent();
        compMatch.component = Collections.synchronizedList(new ArrayList<>((Arrays.asList(childComponents))));
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
