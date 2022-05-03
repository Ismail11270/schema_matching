package pl.polsl.iat.matching.core.model.result;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Random;

public class ResultTest {

    @Test
    public void testXmlGeneration() {
        try {
            MatchingResult matchingResult = new MatchingResult();
            matchingResult.components = new ArrayList<>();
            Random rand = new Random();
            var factory = new ResultFactory();
            Component schema1 = factory.createComponent();
            schema1.type = ResultComponentType.SCHEMA;
            schema1.name = "Schema_1";
            MatchingComponent schema2 = factory.createComponentMatch();
            schema2.type = ResultComponentType.SCHEMA;
            schema2.name = "Schema_2";

            // num of tables in schema1
            for (int i = 0; i < rand.nextInt(10); i++) {
                var table = factory.createComponent();
                table.name = "Schema_1" + ".Table_" + i;
                table.type = ResultComponentType.TABLE;
                for (int j = 0; j < rand.nextInt(10); j++) {
                    var matchTable = factory.createComponentMatch();
                    matchTable.name = "Schema_2" + ".Table_" + j;
                    matchTable.type = ResultComponentType.TABLE;
                    matchTable.matchScore = BigDecimal.valueOf(0.1f * rand.nextInt(10));
                    for (int k = 0; k < rand.nextInt(5); k++) {
                        var column = factory.createComponent();
                        column.name = "Schema_1.Table_" + i + ".Column_" + k;
                        column.type = ResultComponentType.COLUMN;
                        for (int l = 0; l < rand.nextInt(); l++) {
                            var columnMatch = factory.createComponentMatch();
                            columnMatch.name = "Schema_2" + ".Table_" + j + ".Column_" + l;
                            columnMatch.type = ResultComponentType.COLUMN;
                            columnMatch.matchScore = BigDecimal.valueOf(0.1f * rand.nextInt(10));
                            column.matchingComponent.add(columnMatch);
                        }
                        matchTable.component.add(column);
                    }
                    table.matchingComponent.add(matchTable);
                }
                schema2.component.add(table);
            }
            schema1.matchingComponent.add(schema2);
            matchingResult.components.add(schema1);

            matchingResult.save("..\\result\\test-sample.xml");
        } catch(Throwable t){
            Assertions.fail("Exception during output generation. " + t.getMessage());
        }
    }
}
