package pl.polsl.iat.matching.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import pl.polsl.iat.matching.matchers.ComponentMatcher;
import pl.polsl.iat.matching.matchers.MatcherFactory;
import pl.polsl.iat.matching.matchers.MatcherType;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Map;
import java.util.Set;

public class MatcherSettings {
    public static Map<MatcherType,ComponentMatcher> availableMatchers;
    private final static String MATCHER_SETTINGS_VAR = "MATCHER_SETTINGS_FILE";

    static {
        availableMatchers = new Hashtable<>();
        try {
            File inputFile = new File(System.getenv(MATCHER_SETTINGS_VAR));
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
