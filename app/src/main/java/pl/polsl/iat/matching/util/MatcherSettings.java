package pl.polsl.iat.matching.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.matchers.word.WordMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcherFactory;
import pl.polsl.iat.matching.processing.ProcessorType;
import pl.polsl.iat.matching.processing.TextProcessor;
import pl.polsl.iat.matching.processing.Words;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.*;

public class MatcherSettings {

    public enum MatchingOptions {
        INCLUDE_CHILDREN,
        METADATA,
        COMBINED
    }

    public final static String STOP_WORDS_FILE = "stopwords.txt";

    public static String STOP_WORDS_PATH;

    private static final MatcherSettings settingsInstance;

    public static synchronized MatcherSettings getSettings() {
        return settingsInstance;
    }

    private MatcherSettings() {
    }

    private final Map<WordMatcher.Type, WordMatcher> availableWordMatchers = new HashMap<>();

    private final List<ProcessorType> availablePreprocessors = new ArrayList<>();

    private Integer numberOfThreads = 8;

    /**
     * Considering to drop the idea of lazy loading
     */
    @Deprecated(forRemoval = true)
    public SchemaExtractor.Mode getLoaderMode() {
        return loaderMode;
    }

    private SchemaExtractor.Mode loaderMode;

    public boolean hasMatcher(WordMatcher.Type type) {
        return availableWordMatchers.containsKey(type);
    }

    public Map<WordMatcher.Type, WordMatcher> getAvailableWordMatchers() {
        return Map.copyOf(availableWordMatchers);
    }

    public List<ProcessorType> getAvailablePreProcessors() {
        return List.copyOf(availablePreprocessors);
    }

    public WordMatcher getMatcher(WordMatcher.Type type) {
        return availableWordMatchers.get(type);
    }

    public Integer getNumberOfThreads() {
        return numberOfThreads;
    }

    private final List<MatchingOptions> availableMatchingOptions = new ArrayList<>();

    static {
        settingsInstance = new MatcherSettings();
        try {
            File inputFile = new File(System.getenv(Const.SettingsXml.MATCHER_SETTINGS_VAR));
            STOP_WORDS_PATH = inputFile.getParent() + "\\" + STOP_WORDS_FILE;
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputFile);
            doc.getDocumentElement().normalize();

            initExtraMatching(doc);
            initWordMatchers(doc);
            initPreprocessors(doc);

            NodeList modeTag = doc.getElementsByTagName(Const.SettingsXml.MODE_TAG);
            settingsInstance.loaderMode = SchemaExtractor.Mode.valueOf(modeTag.item(0).getTextContent().toUpperCase());
            NodeList threadsTag = doc.getElementsByTagName(Const.SettingsXml.THREADS_TAG);
            settingsInstance.numberOfThreads = Integer.parseInt(threadsTag.item(0).getTextContent());
        } catch (NumberFormatException e) {
            Logger.error("Invalid thread number configuration! Using default value of 8");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void initExtraMatching(Document doc) {
        NodeList nList = doc.getElementsByTagName(Const.SettingsXml.EXTRA_MATCHING_TAG);
        if (nList.getLength() > 0) {
            Element extraMatching = (Element) nList.item(0);
            NodeList components = extraMatching.getElementsByTagName(Const.SettingsXml.MATCHING_COMPONENT_TAG);
            for (int i = 0; i < components.getLength(); i++) {
                try {
                    MatchingOptions matchingOption = MatchingOptions.valueOf(components.item(i).getTextContent().toUpperCase());
                    settingsInstance.availableMatchingOptions.add(matchingOption);
                } catch (IllegalArgumentException iae) {
                    System.err.println("Failed to read matching options configuration: \n" + iae.getMessage());
                }
            }
        }
    }

    private static void initWordMatchers(Document doc) {
        NodeList nList = doc.getElementsByTagName(Const.SettingsXml.WORD_MATCHERS_TAG);
        if (nList.getLength() > 0) {
            nList = ((Element) nList.item(0)).getElementsByTagName(Const.SettingsXml.MATCHER_TAG);
        }

        for (int i = 0; i < nList.getLength(); i++) {
            try {
                Node nNode = nList.item(i);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    WordMatcher.Type matcherType = WordMatcher.Type.valueOf(
                            eElement.getElementsByTagName(Const.SettingsXml.TYPE_TAG).item(0).getTextContent().toUpperCase());
                    boolean enabled = Boolean.parseBoolean(
                            eElement.getElementsByTagName(Const.SettingsXml.ACTIVE_TAG).item(0).getTextContent());
                    if (enabled) {
                        settingsInstance.availableWordMatchers.put(matcherType, WordsMatcherFactory.getMatherOfType(matcherType));
                    }
                }
            } catch (IllegalArgumentException iae) {
                System.err.println("Failed to read matcher configuration: \n" + iae.getMessage());
            }
        }
    }


    private static void initPreprocessors(Document doc) {
        NodeList nList = doc.getElementsByTagName(Const.SettingsXml.PRE_PROCESSING_TAG);
        if (nList.getLength() > 0) {
            nList = ((Element) nList.item(0)).getElementsByTagName(Const.SettingsXml.PROCESSOR_TAG);
        }

        for (int i = 0; i < nList.getLength(); i++) {
            try {
                Node nNode = nList.item(i);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    ProcessorType type = ProcessorType.getFromXmlName(
                            eElement.getElementsByTagName(Const.SettingsXml.TYPE_TAG).item(0).getTextContent().toLowerCase()).orElseThrow(IllegalArgumentException::new);
                    boolean enabled = Boolean.parseBoolean(
                            eElement.getElementsByTagName(Const.SettingsXml.ACTIVE_TAG).item(0).getTextContent());
                    if (enabled) {
                        String priorityText = eElement.getElementsByTagName(Const.SettingsXml.PREPROCESSOR_PRIORITY_TAG).item(0).getTextContent();
                        if(!priorityText.equals(Const.SettingsXml.PRIORITY_DEFAULT)) {
                            type.newPriority(Integer.parseInt(priorityText));
                        }
                        settingsInstance.availablePreprocessors.add(type);
                    }
                }
            } catch (IllegalArgumentException iae) {
                System.err.println("Failed to read matcher configuration: \n" + iae.getMessage());
            }
        }
    }
}
