package pl.polsl.iat.matching.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pl.polsl.iat.matching.matchers.ComponentMatcher;
import pl.polsl.iat.matching.matchers.MatcherFactory;
import pl.polsl.iat.matching.matchers.MatcherType;
import pl.polsl.iat.matching.schema.model.impl.SchemaExtractor;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.*;

public class MatcherSettings {
    private static Map<MatcherType,ComponentMatcher<?>> availableMatchers;
    public static SchemaExtractor.Mode loaderMode;

    public static boolean hasMatcher(MatcherType type){
        return availableMatchers.containsKey(type);
    }

    public static List<ComponentMatcher<?>> getAvailableMatchers(){
        return Collections.unmodifiableList(new ArrayList<>(availableMatchers.values()));
    }

    public static ComponentMatcher<?> getMatcher(MatcherType type){
        return availableMatchers.get(type);
    }

    static {
        availableMatchers = new Hashtable<>();
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
                    if(enabled) {
                        availableMatchers.put(matcherType, MatcherFactory.getMatcherOfType(matcherType));
                    }
                }
            }
            NodeList modeTag = doc.getElementsByTagName(Const.SettingsXml.MODE);
            loaderMode = SchemaExtractor.Mode.valueOf(modeTag.item(0).getTextContent().toUpperCase());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
