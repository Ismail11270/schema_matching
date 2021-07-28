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
import java.util.Set;

public class MatcherSettings {
    public static Set<ComponentMatcher> availableMatchers;
    private final static String MATCHER_SETTINGS_VAR = "MATCHER_SETTINGS_FILE";
    public static void check() {
        return;
    }
    static {
        availableMatchers = new HashSet<>();
        try {
            File inputFile = new File(System.getenv(MATCHER_SETTINGS_VAR));
            Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputFile);
            doc.getDocumentElement().normalize();
            System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("matcher");
            System.out.println("----------------------------");

            for (int temp = 0; temp < nList.getLength(); temp++) {
                Node nNode = nList.item(temp);
                System.out.println("\nCurrent Element :" + nNode.getNodeName());

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    MatcherType matcherType = MatcherType.valueOf(
                            eElement.getElementsByTagName("type").item(0).getTextContent().toUpperCase());
                    boolean enabled = Boolean.parseBoolean(
                            eElement.getElementsByTagName("active").item(0).getTextContent());
                    if(enabled) {
                        availableMatchers.add(MatcherFactory.getMatcherOfType(matcherType));
                    }
                    System.out.println("Student roll no : "
                            + eElement.getAttribute("rollno"));
                    System.out.println("First Name : "
                            + eElement
                            .getElementsByTagName("firstname")
                            .item(0)
                            .getTextContent());
                    System.out.println("Last Name : "
                            + eElement
                            .getElementsByTagName("lastname")
                            .item(0)
                            .getTextContent());
                    System.out.println("Nick Name : "
                            + eElement
                            .getElementsByTagName("nickname")
                            .item(0)
                            .getTextContent());
                    System.out.println("Marks : "
                            + eElement
                            .getElementsByTagName("marks")
                            .item(0)
                            .getTextContent());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
//        availableMatchers.add()
    }
}
