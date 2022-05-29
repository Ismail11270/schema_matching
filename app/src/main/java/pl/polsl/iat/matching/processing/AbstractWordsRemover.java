package pl.polsl.iat.matching.processing;

import org.w3c.dom.Text;
import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

abstract class AbstractWordsRemover implements TextProcessor<Words> {

    private List<String> wordsToRemove;


    AbstractWordsRemover(String wordsFile) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(wordsFile))) {
            wordsToRemove = reader.lines().collect(Collectors.toList());
        } catch (FileNotFoundException e) {
            Logger.warn("Words file not found at location - ", wordsFile);
            throw e;
        } catch (IOException e) {
            Logger.warn("Error reading words file.. Details:\n\t", e.getMessage());
            throw e;
        }
    }

    protected List<String> getWordsToRemove() {
        return wordsToRemove;
    }
}
