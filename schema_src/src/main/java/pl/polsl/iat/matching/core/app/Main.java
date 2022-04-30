package pl.polsl.iat.matching.core.app;

import pl.polsl.iat.matching.core.exception.SchemaExtractorException;
import pl.polsl.iat.matching.core.result.ResultFactory;
import pl.polsl.iat.matching.core.schema.model.Schema;
import pl.polsl.iat.matching.core.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.sql.ConnectionProperties;
import pl.polsl.iat.matching.core.util.MatcherSettings;
import pl.polsl.iat.matching.core.util.ParametersResolver;

import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("removal")
public class Main {

    public static void main(String[] args) throws SchemaExtractorException {
        ParametersResolver parametersResolver = new ParametersResolver(args);
        List<Schema> schemas = new ArrayList<>();
        long start = System.currentTimeMillis();
        for(ConnectionProperties p : parametersResolver.getConnectionProperties()){
            schemas.add(new SchemaExtractor(p).load(MatcherSettings.getSettings().getLoaderMode()));
        }
        System.out.println("Time taken = " + (System.currentTimeMillis() - start));

        new ResultFactory().createMatchingResult(schemas.toArray(new Schema[0]))
                .save("..\\result\\actual-result.xml");

        // TODO
        // for each schema pair run schema matcher
            // schema matcher
            // for each table pairs run table matcher
                // table matcher
                // for each table attribute pair run attribute matcher
                    // matchScore(A,B)
                    // if types are different return MatchResult(false)
                    // apply rules on names get Aclean Bclean
                    // MatchResult checkExactMatch(Aclean, Bclean)
                    // Match



    }


}
