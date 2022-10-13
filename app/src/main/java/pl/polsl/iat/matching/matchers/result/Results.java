package pl.polsl.iat.matching.matchers.result;

import java.util.*;

public class Results {

    private Map<Class<? extends AbstractResult>, List<AbstractResult<?>>> results = new HashMap<>();
    private Integer calculatedResult = null;

    public Results() {

    }

    public Results add(AbstractResult<?> result) {
        List<AbstractResult<?>> val = results.computeIfAbsent(result.getClass(), k -> new ArrayList<>());
        val.add(result);
        return this;
    }

    public int calculateResult() {
        if(calculatedResult == null && results.isEmpty()) {
            calculatedResult = 0;
        } else if(calculatedResult == null){
            List<AbstractResult<?>> mainResult = results.get(WordsMatchingResult.class);
            calculatedResult = mainResult != null && !mainResult.isEmpty()
                    ? (Integer) mainResult.get(0).getResult()
                    : 0;
            List<AbstractResult<?>> absChResults = results.get(CharacteristicsResult.class);
            if(absChResults == null)
                return calculatedResult;
            for (AbstractResult<?> absChResult : absChResults) {
                var chResult = (CharacteristicsResult) absChResult;
                if(chResult.getResult() == 1) {
                    float res_ = 100 - calculatedResult;
                    calculatedResult += (int) (res_*chResult.getType().getGeneralType().getPositiveCoef());
                } else if(chResult.getResult() == -1) {
                    calculatedResult -= (int) (calculatedResult*chResult.getType().getGeneralType().getNegativeCoef());
                }
            }
//            if(calculatedResult == 100)
//                return 100;


//            calculatedResult = results.stream().mapToInt(AbstractResult<Integer>::getResult).sum() / results.size();
        }
        return calculatedResult;
    }
}
