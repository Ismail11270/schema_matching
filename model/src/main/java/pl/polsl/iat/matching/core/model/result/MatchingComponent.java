//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.3.1 
// See <a href="https://javaee.github.io/jaxb-v2/">https://javaee.github.io/jaxb-v2/</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2021.07.30 at 12:12:44 AM AZT 
//
package pl.polsl.iat.matching.core.model.result;

import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>Java class for matching-component complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="matching-component"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="component" type="{}component" maxOccurs="unbounded"/&gt;
 *       &lt;/sequence&gt;
 *       &lt;attribute name="type" use="required" type="{http://www.w3.org/2001/XMLSchema}string" /&gt;
 *       &lt;attribute name="name" use="required" type="{http://www.w3.org/2001/XMLSchema}string" /&gt;
 *       &lt;attribute name="match" use="required" type="{http://www.w3.org/2001/XMLSchema}decimal" /&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 

 *
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "matching-component", propOrder = {
    "component"
})
public class MatchingComponent {

    @XmlElement(required = true)
    protected List<Component> component;
    @XmlAttribute(name = "type", required = true)
    @XmlJavaTypeAdapter(ResultComponentType.XmlTypeAdapter.class)
    protected ResultComponentType type;
    @XmlAttribute(name = "name", required = true)
    protected String name;
    @XmlAttribute(name = "matchScore", required = true)
    protected BigDecimal matchScore;
    @XmlAttribute(name = "childScore", required = false)
    protected BigDecimal childScore;
    @XmlAttribute(name = "metadataScore", required = false)
    protected BigDecimal metadataScore;
    @XmlAttribute(name = "combinedScore", required = false)
    protected BigDecimal combinedScore;

    /**
     * Gets the value of the component property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the component property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getComponent().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Component }
     * 
     * 
     */
    public List<Component> getComponent() {
        if (component == null) {
            component = new ArrayList<Component>();
        }
        return this.component;
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

    /**
     * Gets the value of the match property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getMatchScore() {
        return matchScore;
    }

    /**
     * Sets the value of the match property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setMatchScore(float value) {
        this.matchScore = BigDecimal.valueOf(value);
    }

    public BigDecimal getCombinedScore() {
        return this.combinedScore;
    }

    public void setCombinedScore(float value) {
        this.combinedScore = BigDecimal.valueOf(value);
    }

    public void setMatchScore(BigDecimal matchScore) {
        this.matchScore = matchScore;
    }

    public BigDecimal getChildScore() {
        return childScore;
    }

    public void setChildScore(BigDecimal childScore) {
        this.childScore = childScore;
    }

    public BigDecimal getMetadataScore() {
        return metadataScore;
    }

    public void setMetadataScore(BigDecimal metadataScore) {
        this.metadataScore = metadataScore;
    }
}
