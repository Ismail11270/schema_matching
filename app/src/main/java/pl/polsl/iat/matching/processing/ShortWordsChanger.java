package pl.polsl.iat.matching.processing;

import pl.polsl.iat.matching.util.Logger;
import pl.polsl.iat.matching.util.MatcherSettings;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Optional;
import java.util.Properties;

class ShortWordsChanger implements TextProcessor<Words>{

    private static TextProcessor<Words> instance;

    private Properties prop;

    ShortWordsChanger() throws IOException {
        System.out.println("Created");
        try (BufferedReader reader = new BufferedReader(new FileReader(MatcherSettings.SHORT_WORDS_FILE_PATH))) {
            prop = new Properties();
            prop.load(reader);
        } catch (FileNotFoundException e) {
            Logger.warn("Words file not found at location - ", MatcherSettings.SHORT_WORDS_FILE_PATH);
            throw e;
        } catch (IOException e) {
            Logger.warn("Error reading words file.. Details:\n\t", e.getMessage());
            throw e;
        }
    }
    static TextProcessor<Words> getInstance() {
        return Optional.ofNullable(instance).orElseGet(ShortWordsChanger::init);
    }

    private static TextProcessor<Words> init() {
        try {
            instance = new ShortWordsChanger();
            return instance;
        } catch (IOException e) {
            return null;
        }
    }

    @Override
    public Words process(Words input) {
        System.out.println("processed");

        for(Word word : input.get()){
            String value = prop.getProperty(word.toString());
            if(value != null){
                word.updateWord(value);
            }
        }
        return input;
    }

    @Override
    public boolean active() {
        return TextProcessor.super.active();
    }
}
