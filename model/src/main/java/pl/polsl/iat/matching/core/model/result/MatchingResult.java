//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.3.1 
// See <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2021.07.30 at 12:12:44 AM AZT 
//
package pl.polsl.iat.matching.core.model.result;

import pl.polsl.iat.matching.core.exception.MatchingException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.annotation.*;
import java.io.File;
import java.util.List;

/**
 * <p>Java class for matching-result complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="matching-result"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="component" type="{}component"/&gt;
 *         &lt;element name="matching-component" type="{}matching-component"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "matching-result", propOrder = {
        "components"
})
@XmlRootElement
public class MatchingResult {

    @XmlElement(required = true, name = "component")
    protected List<Component> components;

    /**
     * Gets the value of the component property.
     * 
     * @return
     *     possible object is
     *     {@link Component }
     *     
     */
    public List<Component> getComponents() {
        return components;
    }

    /**
     * Sets the value of the component property.
     * 
     * @param value
     *     allowed object is
     *     {@link Component }
     *     
     */
    public void setComponents(List<Component> value) {
        this.components = value;
    }

    /**
     * Gets the value of the matchingComponent property.
     * 
     * @return
     *     possible object is
     *     {@link MatchingComponent }
     *     
     */
//    public MatchingComponent getMatchingComponent() {
//        return matchingComponent;
//    }

    /**
     * Sets the value of the matchingComponent property.
     * 
     *     allowed object is
     *     {@link MatchingComponent }
     *     
     */
//    public void setMatchingComponent(MatchingComponent value) {
//        this.matchingComponent = value;
//    }

    public void save(String filePath) {
        try {
            JAXBContext context = JAXBContext.newInstance(MatchingResult.class);
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(this, new File(filePath));
        } catch (JAXBException e) {
            throw new MatchingException("Failed to write result file to " + filePath, e);
        }
    }
}
