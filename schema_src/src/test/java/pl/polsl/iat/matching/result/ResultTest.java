package pl.polsl.iat.matching.result;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import java.io.File;
import java.math.BigDecimal;
import java.util.Random;

public class ResultTest {

    @Test
    public void testXmlGeneration() {
        try {
            MatchingResult matchingResult = new MatchingResult();

            Random rand = new Random();
            var factory = new ObjectFactory();
            Component schema1 = factory.createComponent();
            schema1.type = "Schema";
            schema1.name = "Schema_1";
            MatchingComponent schema2 = factory.createComponentMatch();
            schema2.type = "Schema";
            schema2.name = "Schema_2";

            // num of tables in schema1
            for (int i = 0; i < rand.nextInt(5); i++) {
                var table = factory.createComponent();
                table.name = "Schema_1" + ".Table_" + i;
                table.type = "Table";
                for (int j = 0; j < rand.nextInt(5); j++) {
                    var matchTable = factory.createComponentMatch();
                    matchTable.name = "Schema_2" + ".Table_" + j;
                    matchTable.type = "Table";
                    matchTable.match = BigDecimal.valueOf(0.1f * rand.nextInt(10));
                    for (int k = 0; k < rand.nextInt(5); k++) {
                        var column = factory.createComponent();
                        column.name = "Schema_1.Table_" + i + ".Column_" + k;
                        column.type = "Column";
                        for (int l = 0; l < rand.nextInt(); l++) {
                            var columnMatch = factory.createComponentMatch();
                            columnMatch.name = "Schema_2" + ".Table_" + j + ".Column_" + l;
                            columnMatch.type = "Column";
                            columnMatch.match = BigDecimal.valueOf(0.1f * rand.nextInt(10));
                            column.matchingComponent.add(columnMatch);
                        }
                        matchTable.component.add(column);
                    }
                    table.matchingComponent.add(matchTable);
                }
                schema2.component.add(table);
            }
            schema1.matchingComponent.add(schema2);
            matchingResult.component = schema1;
            matchingResult.matchingComponent = schema2;

            JAXBContext context = JAXBContext.newInstance(MatchingResult.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(matchingResult, new File("..\\result\\test-sample.xml"));
        } catch(Throwable t){
            Assertions.fail("Exception during output generation. " + t.getMessage());
        }
    }
}
