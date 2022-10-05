package pl.polsl.iat.matching.util;

import me.xdrop.fuzzywuzzy.FuzzySearch;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pl.polsl.iat.matching.core.model.schema.impl.SchemaExtractor;
import pl.polsl.iat.matching.matchers.word.WordMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcher;
import pl.polsl.iat.matching.matchers.word.WordsMatcherFactory;
import pl.polsl.iat.matching.processing.ProcessorType;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.*;

public class MatcherSettings {

    public enum MatchingOptions {
        INCLUDE_CHILDREN,
        METADATA,
        COMBINED
    }


    public static final String STOP_WORDS_FILE_VAR = "STOP_WORDS_FILE";
    public static final String PREFIXES_FILE_VAR = "PREFIXES_FILE";

    public final static String DEFAULT_STOP_WORDS_FILE_NAME = "stopwords.txt";
    public static final String DEFAULT_PREFIXES_FILE_NAME = "prefixes.txt";

    public final static String STOP_WORDS_FILE_NAME = Optional.ofNullable(System.getenv(STOP_WORDS_FILE_VAR)).orElse(DEFAULT_STOP_WORDS_FILE_NAME);
    public static final String PREFIXES_FILE_NAME = Optional.ofNullable(System.getenv(PREFIXES_FILE_VAR)).orElse(DEFAULT_PREFIXES_FILE_NAME);

    public static String STOP_WORDS_FILE_PATH;
    public static String PREFIXES_FILE_PATH;
    public static String RESOURCES_DIR;

    private static final MatcherSettings settingsInstance;

    public static synchronized MatcherSettings getSettings() {
        return settingsInstance;
    }

    private MatcherSettings() {
    }

    private final TreeMap<WordMatcher.Type, WordMatcher> availableWordMatchers = new TreeMap<>(Comparator.comparingInt(WordMatcher.Type::getPriority));

    private final List<ProcessorType> availablePreprocessors = new ArrayList<>();

    private Integer numberOfThreads = 8;

    private Logger.LogLevel logLevel = Logger.LogLevel.TABLE;

    private boolean loadToRam;

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
        return availableWordMatchers;
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

    public Logger.LogLevel getLogLevel() {
        return logLevel;
    }

    public boolean isLoadToRam() {
        return loadToRam;
    }

    private final List<MatchingOptions> availableMatchingOptions = new ArrayList<>();


    static {
        settingsInstance = new MatcherSettings();
        try {
            File inputFile = new File(System.getenv(Const.SettingsXml.MATCHER_SETTINGS_VAR));
            RESOURCES_DIR = inputFile.getParent();
            STOP_WORDS_FILE_PATH = RESOURCES_DIR + "\\nlp\\" + STOP_WORDS_FILE_NAME;
            PREFIXES_FILE_PATH = RESOURCES_DIR + "\\nlp\\" + PREFIXES_FILE_NAME;
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputFile);
            doc.getDocumentElement().normalize();

            initExtraMatching(doc);
            initWordMatchers(doc);
            initPreprocessors(doc);

            NodeList modeTag = doc.getElementsByTagName(Const.SettingsXml.MODE_TAG);
            settingsInstance.loaderMode = SchemaExtractor.Mode.valueOf(modeTag.item(0).getTextContent().toUpperCase());
            NodeList threadsTag = doc.getElementsByTagName(Const.SettingsXml.THREADS_TAG);
            settingsInstance.numberOfThreads = Integer.parseInt(threadsTag.item(0).getTextContent());
            NodeList loadToRamTag = doc.getElementsByTagName(Const.SettingsXml.LOAD_TO_RAM_TAG);
            settingsInstance.loadToRam = Boolean.parseBoolean(loadToRamTag.item(0).getTextContent());
            NodeList logLevelTag = doc.getElementsByTagName(Const.SettingsXml.LOG_LEVEL_TAG);
            settingsInstance.logLevel = Logger.LogLevel.valueOf((logLevelTag.item(0).getTextContent()).toUpperCase());
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
                    WordMatcher matcher = WordsMatcherFactory.getMatherOfType(matcherType);
                    if(matcherType == WordMatcher.Type.FUZZY) {
                        Node node = eElement.getElementsByTagName(Const.SettingsXml.METHOD).item(0);
                        String method = node == null ? "tokenSetRatio" : node.getTextContent();
                        matcher.addOption(WordMatcher.Options.Fuzzy.METHOD, FuzzySearch.class.getMethod(method, String.class, String.class));
                    }
                    if (enabled) {
                        settingsInstance.availableWordMatchers.put(matcherType, matcher);
                    }
                }
            } catch (IllegalArgumentException iae) {
                System.err.println("Failed to read matcher configuration: \n" + iae.getMessage());
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
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
//        settingsInstance.availablePreprocessors.add(ProcessorType.PART_OF_SPEECH_TAGGER);
        settingsInstance.availablePreprocessors.sort(Comparator.comparingInt(ProcessorType::getPriority).reversed());
    }
}
