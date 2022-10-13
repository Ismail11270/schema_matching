//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.3.1 
// See <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2021.07.30 at 12:12:44 AM AZT 
//
package pl.polsl.iat.matching.core.model.result;

import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * <p>Java class for component complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="component"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="matching-component" type="{}matching-component" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *       &lt;attribute name="type" use="required" type="{http://www.w3.org/2001/XMLSchema}string" /&gt;
 *       &lt;attribute name="name" use="required" type="{http://www.w3.org/2001/XMLSchema}string" /&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "component", propOrder = {
    "matchingComponent"
})
public class Component {

    @XmlElement(name = "matching-component")
    protected List<MatchingComponent> matchingComponent;
    @XmlAttribute(name = "type", required = true)
    @XmlJavaTypeAdapter(ResultComponentType.XmlTypeAdapter.class)
    protected ResultComponentType type;
    @XmlAttribute(name = "name", required = true)
    protected String name;

    @XmlAttribute(name = "id", required = true)
    protected String id;

    @XmlAttribute(name = "score")
    protected Integer score;

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    @XmlTransient
    public MatchingComponent selectedComponent;
    @XmlTransient
    boolean sorted = false;
    /**
     * Gets the value of the matchingComponent property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the matchingComponent property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getMatchingComponent().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link MatchingComponent }
     * 
     * 
     */
    public List<MatchingComponent> getMatchingComponent() {
        if (matchingComponent == null) {
            matchingComponent = new ArrayList<>();
        }
        return this.matchingComponent;
    }

    public void setMatchingComponent(List<MatchingComponent> matchingComponents) {
        this.matchingComponent = matchingComponents;
    }
    /**
     * Gets the value of the type property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public ResultComponentType getType() {
        return type;
    }

    /**
     * Sets the value of the type property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setType(ResultComponentType value) {
        this.type = value;
    }

    /**
     * Gets the value of the name property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the name property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setName(String value) {
        this.name = value;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Component component = (Component) o;
        return id.equals(component.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
