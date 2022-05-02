package pl.polsl.iat.matching.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.core.util.Const;
import pl.polsl.iat.matching.matchers.word.WordMatcher;
import pl.polsl.iat.matching.processing.StringProcessor;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.*;

public class MatcherSettings {

    private static final MatcherSettings settingsInstance;

    public static MatcherSettings getSettings() {
        return settingsInstance;
    }

    private MatcherSettings() { }

    private final Map<WordMatcher.Type,WordMatcher> availableWordMatchers = new Hashtable<>();

    private Integer numberOfThreads = 8;

    /**
     * Considering to drop the idea of lazy loading
     * @return
     */
    @Deprecated(forRemoval = true)
    public SchemaExtractor.Mode getLoaderMode() {
        return loaderMode;
    }

    private SchemaExtractor.Mode loaderMode;

    public boolean hasMatcher(WordMatcher.Type type){
        return availableWordMatchers.containsKey(type);
    }

    public List<WordMatcher> getAvailableWordMatchers(){
        return Collections.unmodifiableList(new ArrayList<>(availableWordMatchers.values()));
    }

    public List<StringProcessor> getAvailableStringProcessors() {
        return Collections.emptyList();
    }

    public WordMatcher getMatcher(WordMatcher.Type type){
        return availableWordMatchers.get(type);
    }

    public Integer getNumberOfThreads() {
        return numberOfThreads;
    }

    static {
        settingsInstance = new MatcherSettings();
        try {
            File inputFile = new File(System.getenv(Const.SettingsXml.MATCHER_SETTINGS_VAR));
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputFile);
            doc.getDocumentElement().normalize();
            NodeList nList = doc.getElementsByTagName(Const.SettingsXml.MATCHER_TAG);

            for (int temp = 0; temp < nList.getLength(); temp++) {
                Node nNode = nList.item(temp);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    WordMatcher.Type matcherType = WordMatcher.Type.valueOf(
                            eElement.getElementsByTagName(Const.SettingsXml.TYPE_TAG).item(0).getTextContent().toUpperCase());
                    boolean enabled = Boolean.parseBoolean(
                            eElement.getElementsByTagName(Const.SettingsXml.ACTIVE_TAG).item(0).getTextContent());
                    if (enabled) {
                        settingsInstance.availableWordMatchers.put(matcherType, WordMatcher.getMatherOfType(matcherType));
                    }
                }
            }
            NodeList modeTag = doc.getElementsByTagName(Const.SettingsXml.MODE);
            settingsInstance.loaderMode = SchemaExtractor.Mode.valueOf(modeTag.item(0).getTextContent().toUpperCase());
            NodeList threadsTag = doc.getElementsByTagName(Const.SettingsXml.THREADS);
            settingsInstance.numberOfThreads = Integer.parseInt(threadsTag.item(0).getTextContent());
        } catch(NumberFormatException e) {
            System.err.println("[ERROR] Invalid thread number configuration! Using default value of 8");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
