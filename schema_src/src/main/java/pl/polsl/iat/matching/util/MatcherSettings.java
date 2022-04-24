package pl.polsl.iat.matching.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pl.polsl.iat.matching.matchers1.ComponentMatcher;
import pl.polsl.iat.matching.matchers1.MatcherFactory;
import pl.polsl.iat.matching.matchers1.MatcherType;
import pl.polsl.iat.matching.processing.StringProcessor;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.*;

public class MatcherSettings {

    private static final MatcherSettings settingsInstance;

    public static MatcherSettings getSettings() {
        return settingsInstance;
    }

    private MatcherSettings() { }

    private final Map<MatcherType,ComponentMatcher<?>> availableMatchers = new Hashtable<>();

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

    public boolean hasMatcher(MatcherType type){
        return availableMatchers.containsKey(type);
    }

    public List<ComponentMatcher<?>> getAvailableMatchers(){
        return List.copyOf(availableMatchers.values());
    }

    public List<StringProcessor> getAvailableStringProcessors() {
        return Collections.emptyList();
    }

    public ComponentMatcher<?> getMatcher(MatcherType type){
        return availableMatchers.get(type);
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
                    MatcherType matcherType = MatcherType.valueOf(
                            eElement.getElementsByTagName(Const.SettingsXml.TYPE_TAG).item(0).getTextContent().toUpperCase());
                    boolean enabled = Boolean.parseBoolean(
                            eElement.getElementsByTagName(Const.SettingsXml.ACTIVE_TAG).item(0).getTextContent());
                    if (enabled) {
                        settingsInstance.availableMatchers.put(matcherType, MatcherFactory.getMatcherOfType(matcherType));
                    }
                }
            }
            NodeList modeTag = doc.getElementsByTagName(Const.SettingsXml.MODE);
            settingsInstance.loaderMode = SchemaExtractor.Mode.valueOf(modeTag.item(0).getTextContent().toUpperCase());
            NodeList threadsTag = doc.getElementsByTagName(Const.SettingsXml.THREADS);
            settingsInstance.numberOfThreads = Integer.parseInt(threadsTag.item(0).getTextContent());
        } catch(NumberFormatException e) {
            System.out.println("[ERROR] Invalid thread number configuration! Using default value of 8");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
