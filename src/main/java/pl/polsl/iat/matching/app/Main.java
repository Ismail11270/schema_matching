package pl.polsl.iat.matching.app;

import pl.polsl.iat.matching.exception.DatabaseException;
import pl.polsl.iat.matching.exception.SchemaExtractorException;
import pl.polsl.iat.matching.matchers.SchemaMatcher;
import pl.polsl.iat.matching.schema.model.Schema;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;
import pl.polsl.iat.matching.sql.ConnectionProperties;
import pl.polsl.iat.matching.util.MatcherSettings;
import pl.polsl.iat.matching.util.ParametersResolver;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {

    public static void main(String[] args) throws DatabaseException, SchemaExtractorException {
        System.out.println(Arrays.toString(args));
        //load schemas from parameters
        ParametersResolver parametersResolver = new ParametersResolver(args);
        SchemaExtractor extractor = new SchemaExtractor(SchemaExtractor.Mode.EAGER);
        List<Schema> schemas = new ArrayList<>();
//        SchemaConnection connection = new SchemaConnection(parametersResolver.getConnectionProperties().get(0));
        for(ConnectionProperties p : parametersResolver.getConnectionProperties()){
            schemas.add(extractor.load(p));
        }


//        MatcherSettings.check();

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
