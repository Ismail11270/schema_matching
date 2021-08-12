package pl.polsl.iat.matching.app;

import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.matchers.MatcherType;
import pl.polsl.iat.matching.matchers.SchemaMatcher;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.sql.ConnectionProperties;
import pl.polsl.iat.matching.util.MatcherSettings;
import pl.polsl.iat.matching.util.ParametersResolver;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Main {

    public static void main(String[] args) throws SchemaExtractorException, SQLException {
        ParametersResolver parametersResolver = new ParametersResolver(args);
        List<Schema> schemas = new ArrayList<>();
        long start = System.currentTimeMillis();
        for(ConnectionProperties p : parametersResolver.getConnectionProperties()){
            schemas.add(new SchemaExtractor(p).load(MatcherSettings.loaderMode));
        }
        System.out.println("Time taken = " + (System.currentTimeMillis() - start));

        MatcherSettings.hasMatcher(MatcherType.EXACT);

        SchemaMatcher schemaMatcher = new SchemaMatcher();


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
