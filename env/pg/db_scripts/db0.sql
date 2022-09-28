--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Debian 14.5-1.pgdg110+1)
-- Dumped by pg_dump version 14.5 (Debian 14.5-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: human_resources; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA human_resources;


ALTER SCHEMA human_resources OWNER TO postgres;

--
-- Name: person; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA person;


ALTER SCHEMA person OWNER TO postgres;

--
-- Name: production; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA production;


ALTER SCHEMA production OWNER TO postgres;

--
-- Name: purchasing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA purchasing;


ALTER SCHEMA purchasing OWNER TO postgres;

--
-- Name: sales; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sales;


ALTER SCHEMA sales OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: department; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.department (
    department_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.department OWNER TO postgres;

--
-- Name: TABLE department; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.department IS 'Lookup table containing the departments within the Adventure Works Cycles company.';


--
-- Name: employee_department_history; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_department_history (
    businessentity_id integer NOT NULL,
    department_id smallint NOT NULL,
    shift_id smallint NOT NULL,
    start_date date NOT NULL,
    end_date date,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL)))
);


ALTER TABLE human_resources.employee_department_history OWNER TO postgres;

--
-- Name: employee_pay_history; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_pay_history (
    business_entity_id integer NOT NULL,
    rate_change_date timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    pay_frequency smallint NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((pay_frequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);


ALTER TABLE human_resources.employee_pay_history OWNER TO postgres;

--
-- Name: job_candidate; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.job_candidate (
    job_candidate_id integer NOT NULL,
    business_entity_id integer,
    resume xml,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.job_candidate OWNER TO postgres;

--
-- Name: jobcandidate_jobcandidateid_seq; Type: SEQUENCE; Schema: human_resources; Owner: postgres
--

CREATE SEQUENCE human_resources.jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE human_resources.jobcandidate_jobcandidateid_seq OWNER TO postgres;

--
-- Name: jobcandidate_jobcandidateid_seq; Type: SEQUENCE OWNED BY; Schema: human_resources; Owner: postgres
--

ALTER SEQUENCE human_resources.jobcandidate_jobcandidateid_seq OWNED BY human_resources.job_candidate.job_candidate_id;


--
-- Name: shift; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.shift (
    shift_id integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.shift OWNER TO postgres;

--
-- Name: TABLE shift; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.shift IS 'Work shift lookup table.';


--
-- Name: address; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.address (
    address_id integer NOT NULL,
    address_line_1 character varying(60) NOT NULL,
    address_line_2 character varying(60),
    city character varying(30) NOT NULL,
    state_province_id integer NOT NULL,
    zipcode character varying(15) NOT NULL,
    spatial_location character varying(44),
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.address OWNER TO postgres;

--
-- Name: TABLE address; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.address IS 'Street address information for customers, employees, and vendors.';


--
-- Name: address_addressid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.address_addressid_seq OWNER TO postgres;

--
-- Name: address_addressid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.address_addressid_seq OWNED BY person.address.address_id;


--
-- Name: address_type; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.address_type (
    address_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.address_type OWNER TO postgres;

--
-- Name: addresstype_addresstypeid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.addresstype_addresstypeid_seq OWNER TO postgres;

--
-- Name: addresstype_addresstypeid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.addresstype_addresstypeid_seq OWNED BY person.address_type.address_type_id;


--
-- Name: business_entity; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.business_entity (
    business_entity_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.business_entity OWNER TO postgres;

--
-- Name: business_entity_address; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.business_entity_address (
    business_entity_id integer NOT NULL,
    address_id integer NOT NULL,
    address_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.business_entity_address OWNER TO postgres;

--
-- Name: business_entity_contact; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.business_entity_contact (
    business_entity_id integer NOT NULL,
    person_id integer NOT NULL,
    contact_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.business_entity_contact OWNER TO postgres;

--
-- Name: businessentity_businessentityid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.businessentity_businessentityid_seq OWNER TO postgres;

--
-- Name: businessentity_businessentityid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.businessentity_businessentityid_seq OWNED BY person.business_entity.business_entity_id;


--
-- Name: contact_type; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.contact_type (
    contact_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.contact_type OWNER TO postgres;

--
-- Name: contacttype_contacttypeid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.contacttype_contacttypeid_seq OWNER TO postgres;

--
-- Name: contacttype_contacttypeid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.contacttype_contacttypeid_seq OWNED BY person.contact_type.contact_type_id;


--
-- Name: country_region; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.country_region (
    country_region_code character varying(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.country_region OWNER TO postgres;

--
-- Name: email_address; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.email_address (
    business_entity_id integer NOT NULL,
    email_address_id integer NOT NULL,
    email_address character varying(50),
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.email_address OWNER TO postgres;

--
-- Name: emailaddress_emailaddressid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.emailaddress_emailaddressid_seq OWNER TO postgres;

--
-- Name: emailaddress_emailaddressid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.emailaddress_emailaddressid_seq OWNED BY person.email_address.email_address_id;


--
-- Name: password; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.password (
    business_entity_id integer NOT NULL,
    password_hash character varying(128) NOT NULL,
    password_salt character varying(10) NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.password OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.person (
    business_entity_id integer NOT NULL,
    person_type character(2) NOT NULL,
    title character varying(8),
    suffix character varying(10),
    email_promotion integer DEFAULT 0 NOT NULL,
    additional_contact_info xml,
    demo_graphics xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (((email_promotion >= 0) AND (email_promotion <= 2))),
    CONSTRAINT "CK_Person_PersonType" CHECK (((person_type IS NULL) OR (upper((person_type)::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text]))))
);


ALTER TABLE person.person OWNER TO postgres;

--
-- Name: person_phone; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.person_phone (
    business_entity_id integer NOT NULL,
    phone_number_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.person_phone OWNER TO postgres;

--
-- Name: phone_number_type; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.phone_number_type (
    phone_number_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.phone_number_type OWNER TO postgres;

--
-- Name: phonenumbertype_phonenumbertypeid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.phonenumbertype_phonenumbertypeid_seq OWNER TO postgres;

--
-- Name: phonenumbertype_phonenumbertypeid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.phonenumbertype_phonenumbertypeid_seq OWNED BY person.phone_number_type.phone_number_type_id;


--
-- Name: state_province; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.state_province (
    state_province_id integer NOT NULL,
    state_province_code character(3) NOT NULL,
    country_region_code character varying(3) NOT NULL,
    territory_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.state_province OWNER TO postgres;

--
-- Name: stateprovince_stateprovinceid_seq; Type: SEQUENCE; Schema: person; Owner: postgres
--

CREATE SEQUENCE person.stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.stateprovince_stateprovinceid_seq OWNER TO postgres;

--
-- Name: stateprovince_stateprovinceid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: postgres
--

ALTER SEQUENCE person.stateprovince_stateprovinceid_seq OWNED BY person.state_province.state_province_id;


--
-- Name: bill_of_materials; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.bill_of_materials (
    bill_of_materials_id integer NOT NULL,
    product_assembly_id integer,
    component_id integer NOT NULL,
    start_date timestamp without time zone DEFAULT now() NOT NULL,
    end_date timestamp without time zone,
    unit_measure_code character(3) NOT NULL,
    bom_level smallint NOT NULL,
    per_assembly_qty numeric(8,2) DEFAULT 1.00 NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK ((((product_assembly_id IS NULL) AND (bom_level = 0) AND (per_assembly_qty = 1.00)) OR ((product_assembly_id IS NOT NULL) AND (bom_level >= 1)))),
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (((end_date > start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK ((per_assembly_qty >= 1.00)),
    CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK ((product_assembly_id <> component_id))
);


ALTER TABLE production.bill_of_materials OWNER TO postgres;

--
-- Name: COLUMN bill_of_materials.bill_of_materials_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.bill_of_materials_id IS 'Primary key for BillOfMaterials records.';


--
-- Name: COLUMN bill_of_materials.product_assembly_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.product_assembly_id IS 'Parent product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN bill_of_materials.start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.start_date IS 'Date the component started being used in the assembly item.';


--
-- Name: COLUMN bill_of_materials.end_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.end_date IS 'Date the component stopped being used in the assembly item.';


--
-- Name: COLUMN bill_of_materials.unit_measure_code; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.unit_measure_code IS 'Standard code identifying the unit of measure for the quantity.';


--
-- Name: billofmaterials_billofmaterialsid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.billofmaterials_billofmaterialsid_seq OWNER TO postgres;

--
-- Name: billofmaterials_billofmaterialsid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.billofmaterials_billofmaterialsid_seq OWNED BY production.bill_of_materials.bill_of_materials_id;


--
-- Name: culture; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.culture (
    culture_id character(6) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.culture OWNER TO postgres;

--
-- Name: TABLE culture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.culture IS 'Lookup table containing the languages in which some AdventureWorks data is stored.';


--
-- Name: COLUMN culture.culture_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.culture.culture_id IS 'Primary key for Culture records.';


--
-- Name: document; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.document (
    title character varying(50) NOT NULL,
    owner integer NOT NULL,
    file_name character varying(400) NOT NULL,
    file_extension character varying(8),
    revision character(5) NOT NULL,
    change_number integer DEFAULT 0 NOT NULL,
    status smallint NOT NULL,
    document_summary text,
    document bytea,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    document_node character varying DEFAULT '/'::character varying NOT NULL,
    CONSTRAINT "CK_Document_Status" CHECK (((status >= 1) AND (status <= 3)))
);


ALTER TABLE production.document OWNER TO postgres;

--
-- Name: TABLE document; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.document IS 'Product maintenance documents.';


--
-- Name: COLUMN document.title; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.title IS 'Title of the document.';


--
-- Name: COLUMN document.owner; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.owner IS 'Employee who controls the document.  Foreign key to Employee.BusinessEntityID';


--
-- Name: COLUMN document.file_name; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.file_name IS 'File name of the document';


--
-- Name: COLUMN document.file_extension; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.file_extension IS 'File extension indicating the document type. For example, .doc or .txt.';


--
-- Name: COLUMN document.revision; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.revision IS 'Revision number of the document.';


--
-- Name: COLUMN document.change_number; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.change_number IS 'Engineering change approval number.';


--
-- Name: COLUMN document.status; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.status IS '1 = Pending approval, 2 = Approved, 3 = Obsolete';


--
-- Name: COLUMN document.document_summary; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.document_summary IS 'Document abstract.';


--
-- Name: COLUMN document.document; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.document IS 'Complete document.';


--
-- Name: COLUMN document.row_guid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.row_guid IS 'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.';


--
-- Name: COLUMN document.document_node; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.document_node IS 'Primary key for Document records.';


--
-- Name: illustration; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.illustration (
    illustration_id integer NOT NULL,
    diagram xml,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.illustration OWNER TO postgres;

--
-- Name: TABLE illustration; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.illustration IS 'Bicycle assembly diagrams.';


--
-- Name: COLUMN illustration.illustration_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.illustration.illustration_id IS 'Primary key for Illustration records.';


--
-- Name: COLUMN illustration.diagram; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.illustration.diagram IS 'Illustrations used in manufacturing instructions. Stored as XML.';


--
-- Name: illustration_illustrationid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.illustration_illustrationid_seq OWNER TO postgres;

--
-- Name: illustration_illustrationid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.illustration_illustrationid_seq OWNED BY production.illustration.illustration_id;


--
-- Name: location; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.location (
    location_id integer NOT NULL,
    cost_rate numeric DEFAULT 0.00 NOT NULL,
    availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((cost_rate >= 0.00))
);


ALTER TABLE production.location OWNER TO postgres;

--
-- Name: TABLE location; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.location IS 'Product inventory and manufacturing locations.';


--
-- Name: COLUMN location.location_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.location.location_id IS 'Primary key for Location records.';


--
-- Name: COLUMN location.cost_rate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.location.cost_rate IS 'Standard hourly cost of the manufacturing location.';


--
-- Name: COLUMN location.availability; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.location.availability IS 'Work capacity (in hours) of the manufacturing location.';


--
-- Name: location_locationid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.location_locationid_seq OWNER TO postgres;

--
-- Name: location_locationid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.location_locationid_seq OWNED BY production.location.location_id;


--
-- Name: product; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product (
    product_id integer NOT NULL,
    product_number character varying(25) NOT NULL,
    color character varying(15),
    safety_stock_level smallint NOT NULL,
    reorder_point smallint NOT NULL,
    standard_cost numeric NOT NULL,
    list_price numeric NOT NULL,
    size character varying(5),
    size_unit_measure_code character(3),
    weight_unit_measure_code character(3),
    weight numeric(8,2),
    days_to_manufacture integer NOT NULL,
    product_line character(2),
    class character(2),
    style character(2),
    product_subcategory_id integer,
    product_model_id integer,
    sell_start_date timestamp without time zone NOT NULL,
    sellend_date timestamp without time zone,
    discontinued_date timestamp without time zone,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Product_Class" CHECK (((upper((class)::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR (class IS NULL))),
    CONSTRAINT "CK_Product_DaysToManufacture" CHECK ((days_to_manufacture >= 0)),
    CONSTRAINT "CK_Product_ListPrice" CHECK ((list_price >= 0.00)),
    CONSTRAINT "CK_Product_ProductLine" CHECK (((upper((product_line)::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR (product_line IS NULL))),
    CONSTRAINT "CK_Product_ReorderPoint" CHECK ((reorder_point > 0)),
    CONSTRAINT "CK_Product_SafetyStockLevel" CHECK ((safety_stock_level > 0)),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (((sellend_date >= sell_start_date) OR (sellend_date IS NULL))),
    CONSTRAINT "CK_Product_StandardCost" CHECK ((standard_cost >= 0.00)),
    CONSTRAINT "CK_Product_Style" CHECK (((upper((style)::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR (style IS NULL))),
    CONSTRAINT "CK_Product_Weight" CHECK ((weight > 0.00))
);


ALTER TABLE production.product OWNER TO postgres;

--
-- Name: TABLE product; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product IS 'Products sold or used in the manfacturing of sold products.';


--
-- Name: COLUMN product.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.product_id IS 'Primary key for Product records.';


--
-- Name: COLUMN product.product_number; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.product_number IS 'Unique product identification number.';


--
-- Name: COLUMN product.color; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.color IS 'Product color.';


--
-- Name: COLUMN product.safety_stock_level; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.safety_stock_level IS 'Minimum inventory quantity.';


--
-- Name: COLUMN product.reorder_point; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.reorder_point IS 'Inventory level that triggers a purchase order or work order.';


--
-- Name: COLUMN product.standard_cost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.standard_cost IS 'Standard cost of the product.';


--
-- Name: COLUMN product.list_price; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.list_price IS 'Selling price.';


--
-- Name: COLUMN product.size; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.size IS 'Product size.';


--
-- Name: COLUMN product.size_unit_measure_code; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.size_unit_measure_code IS 'Unit of measure for Size column.';


--
-- Name: COLUMN product.weight_unit_measure_code; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.weight_unit_measure_code IS 'Unit of measure for Weight column.';


--
-- Name: COLUMN product.weight; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.weight IS 'Product weight.';


--
-- Name: COLUMN product.days_to_manufacture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.days_to_manufacture IS 'Number of days required to manufacture the product.';


--
-- Name: COLUMN product.product_line; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.product_line IS 'R = Road, M = Mountain, T = Touring, S = Standard';


--
-- Name: COLUMN product.class; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.class IS 'H = High, M = Medium, L = Low';


--
-- Name: COLUMN product.style; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.style IS 'W = Womens, M = Mens, U = Universal';


--
-- Name: COLUMN product.product_subcategory_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.product_subcategory_id IS 'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID.';


--
-- Name: COLUMN product.product_model_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.product_model_id IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN product.sell_start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.sell_start_date IS 'Date the product was available for sale.';


--
-- Name: COLUMN product.sellend_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.sellend_date IS 'Date the product was no longer available for sale.';


--
-- Name: COLUMN product.discontinued_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.discontinued_date IS 'Date the product was discontinued.';


--
-- Name: product_category; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_category (
    product_category_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_category OWNER TO postgres;

--
-- Name: TABLE product_category; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_category IS 'High-level product categorization.';


--
-- Name: COLUMN product_category.product_category_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_category.product_category_id IS 'Primary key for ProductCategory records.';


--
-- Name: product_cost_history; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_cost_history (
    product_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    standard_cost numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standard_cost >= 0.00))
);


ALTER TABLE production.product_cost_history OWNER TO postgres;

--
-- Name: COLUMN product_cost_history.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.product_id IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN product_cost_history.start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.start_date IS 'Product cost start date.';


--
-- Name: COLUMN product_cost_history.end_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.end_date IS 'Product cost end date.';


--
-- Name: COLUMN product_cost_history.standard_cost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.standard_cost IS 'Standard cost of the product.';


--
-- Name: product_description; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_description (
    product_description_id integer NOT NULL,
    description character varying(400) NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_description OWNER TO postgres;

--
-- Name: TABLE product_description; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_description IS 'Product descriptions in several languages.';


--
-- Name: COLUMN product_description.product_description_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_description.product_description_id IS 'Primary key for ProductDescription records.';


--
-- Name: COLUMN product_description.description; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_description.description IS 'Description of the product.';


--
-- Name: product_document; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_document (
    product_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    document_node character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE production.product_document OWNER TO postgres;

--
-- Name: TABLE product_document; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_document IS 'Cross-reference table mapping products to related product documents.';


--
-- Name: COLUMN product_document.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_document.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_document.document_node; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_document.document_node IS 'Document identification number. Foreign key to Document.DocumentNode.';


--
-- Name: product_inventory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_inventory (
    product_id integer NOT NULL,
    location_id smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE production.product_inventory OWNER TO postgres;

--
-- Name: TABLE product_inventory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_inventory IS 'Product inventory information.';


--
-- Name: COLUMN product_inventory.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_inventory.location_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.location_id IS 'Inventory location identification number. Foreign key to Location.LocationID.';


--
-- Name: COLUMN product_inventory.shelf; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.shelf IS 'Storage compartment within an inventory location.';


--
-- Name: COLUMN product_inventory.bin; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.bin IS 'Storage container on a shelf in an inventory location.';


--
-- Name: COLUMN product_inventory.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.quantity IS 'Quantity of products in the inventory location.';


--
-- Name: product_list_price_history; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_list_price_history (
    product_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    list_price numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((list_price > 0.00))
);


ALTER TABLE production.product_list_price_history OWNER TO postgres;

--
-- Name: TABLE product_list_price_history; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_list_price_history IS 'Changes in the list price of a product over time.';


--
-- Name: COLUMN product_list_price_history.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.product_id IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN product_list_price_history.start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.start_date IS 'List price start date.';


--
-- Name: COLUMN product_list_price_history.end_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.end_date IS 'List price end date';


--
-- Name: COLUMN product_list_price_history.list_price; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.list_price IS 'Product list price.';


--
-- Name: product_model; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_model (
    product_model_id integer NOT NULL,
    catalog_description xml,
    instructions xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_model OWNER TO postgres;

--
-- Name: TABLE product_model; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_model IS 'Product model classification.';


--
-- Name: COLUMN product_model.product_model_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model.product_model_id IS 'Primary key for ProductModel records.';


--
-- Name: COLUMN product_model.catalog_description; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model.catalog_description IS 'Detailed product catalog information in xml format.';


--
-- Name: COLUMN product_model.instructions; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model.instructions IS 'Manufacturing instructions in xml format.';


--
-- Name: product_model_illustration; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_model_illustration (
    product_model_id integer NOT NULL,
    illustration_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_model_illustration OWNER TO postgres;

--
-- Name: TABLE product_model_illustration; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_model_illustration IS 'Cross-reference table mapping product models and illustrations.';


--
-- Name: COLUMN product_model_illustration.illustration_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model_illustration.illustration_id IS 'Primary key. Foreign key to Illustration.IllustrationID.';


--
-- Name: product_model_product_description_culture; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_model_product_description_culture (
    product_model_id integer NOT NULL,
    product_description_id integer NOT NULL,
    culture_id character(6) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_model_product_description_culture OWNER TO postgres;

--
-- Name: TABLE product_model_product_description_culture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_model_product_description_culture IS 'Cross-reference table mapping product descriptions and the language the description is written in.';


--
-- Name: product_photo; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_photo (
    product_photo_id integer NOT NULL,
    thumbnail_photo bytea,
    thumbnail_photo_file_name character varying(50),
    large_photo bytea,
    large_photo_file_name character varying(50),
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_photo OWNER TO postgres;

--
-- Name: TABLE product_photo; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_photo IS 'Product images.';


--
-- Name: COLUMN product_photo.large_photo_file_name; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_photo.large_photo_file_name IS 'Large image file name.';


--
-- Name: product_product_photo; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_product_photo (
    product_id integer NOT NULL,
    product_photo_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_product_photo OWNER TO postgres;

--
-- Name: TABLE product_product_photo; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_product_photo IS 'Cross-reference table mapping products and product photos.';


--
-- Name: COLUMN product_product_photo.product_photo_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_product_photo.product_photo_id IS 'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';


--
-- Name: product_productid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.product_productid_seq OWNER TO postgres;

--
-- Name: product_productid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.product_productid_seq OWNED BY production.product.product_id;


--
-- Name: product_review; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_review (
    product_review_id integer NOT NULL,
    product_id integer NOT NULL,
    review_date timestamp without time zone DEFAULT now() NOT NULL,
    email_address character varying(50) NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850),
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE production.product_review OWNER TO postgres;

--
-- Name: TABLE product_review; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_review IS 'Customer reviews of products they have purchased.';


--
-- Name: COLUMN product_review.product_review_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.product_review_id IS 'Primary key for ProductReview records.';


--
-- Name: COLUMN product_review.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_review.review_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.review_date IS 'Date review was submitted.';


--
-- Name: COLUMN product_review.email_address; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.email_address IS 'Reviewer''s e-mail address.';


--
-- Name: COLUMN product_review.rating; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.rating IS 'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.';


--
-- Name: COLUMN product_review.comments; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.comments IS 'Reviewer''s comments';


--
-- Name: product_subcategory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_subcategory (
    product_subcategory_id integer NOT NULL,
    product_category_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_subcategory OWNER TO postgres;

--
-- Name: TABLE product_subcategory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_subcategory IS 'Product subcategories. See ProductCategory table.';


--
-- Name: COLUMN product_subcategory.product_subcategory_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_subcategory.product_subcategory_id IS 'Primary key for ProductSubcategory records.';


--
-- Name: COLUMN product_subcategory.product_category_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_subcategory.product_category_id IS 'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';


--
-- Name: productcategory_productcategoryid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productcategory_productcategoryid_seq OWNER TO postgres;

--
-- Name: productcategory_productcategoryid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.productcategory_productcategoryid_seq OWNED BY production.product_category.product_category_id;


--
-- Name: productdescription_productdescriptionid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productdescription_productdescriptionid_seq OWNER TO postgres;

--
-- Name: productdescription_productdescriptionid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.productdescription_productdescriptionid_seq OWNED BY production.product_description.product_description_id;


--
-- Name: productmodel_productmodelid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.productmodel_productmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productmodel_productmodelid_seq OWNER TO postgres;

--
-- Name: productmodel_productmodelid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.productmodel_productmodelid_seq OWNED BY production.product_model.product_model_id;


--
-- Name: productphoto_productphotoid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.productphoto_productphotoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productphoto_productphotoid_seq OWNER TO postgres;

--
-- Name: productphoto_productphotoid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.productphoto_productphotoid_seq OWNED BY production.product_photo.product_photo_id;


--
-- Name: productreview_productreviewid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.productreview_productreviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productreview_productreviewid_seq OWNER TO postgres;

--
-- Name: productreview_productreviewid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.productreview_productreviewid_seq OWNED BY production.product_review.product_review_id;


--
-- Name: productsubcategory_productsubcategoryid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.productsubcategory_productsubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productsubcategory_productsubcategoryid_seq OWNER TO postgres;

--
-- Name: productsubcategory_productsubcategoryid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.productsubcategory_productsubcategoryid_seq OWNED BY production.product_subcategory.product_subcategory_id;


--
-- Name: scrap_reason; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.scrap_reason (
    scrap_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.scrap_reason OWNER TO postgres;

--
-- Name: TABLE scrap_reason; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.scrap_reason IS 'Manufacturing failure reasons lookup table.';


--
-- Name: COLUMN scrap_reason.scrap_reason_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.scrap_reason.scrap_reason_id IS 'Primary key for ScrapReason records.';


--
-- Name: scrapreason_scrapreasonid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.scrapreason_scrapreasonid_seq OWNER TO postgres;

--
-- Name: scrapreason_scrapreasonid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.scrapreason_scrapreasonid_seq OWNED BY production.scrap_reason.scrap_reason_id;


--
-- Name: transaction_history; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.transaction_history (
    transaction_id integer NOT NULL,
    product_id integer NOT NULL,
    reference_order_id integer NOT NULL,
    reference_order_line_id integer DEFAULT 0 NOT NULL,
    transaction_date timestamp without time zone DEFAULT now() NOT NULL,
    transaction_type character(1) NOT NULL,
    quantity integer NOT NULL,
    actual_cost numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK ((upper((transaction_type)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE production.transaction_history OWNER TO postgres;

--
-- Name: TABLE transaction_history; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.transaction_history IS 'Record of each purchase order, sales order, or work order transaction year to date.';


--
-- Name: COLUMN transaction_history.transaction_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.transaction_id IS 'Primary key for TransactionHistory records.';


--
-- Name: COLUMN transaction_history.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transaction_history.reference_order_line_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.reference_order_line_id IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transaction_history.transaction_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.transaction_date IS 'Date and time of the transaction.';


--
-- Name: COLUMN transaction_history.transaction_type; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.transaction_type IS 'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';


--
-- Name: COLUMN transaction_history.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.quantity IS 'Product quantity.';


--
-- Name: COLUMN transaction_history.actual_cost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.actual_cost IS 'Product cost.';


--
-- Name: transaction_history_archive; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.transaction_history_archive (
    transaction_id integer NOT NULL,
    product_id integer NOT NULL,
    reference_order_id integer NOT NULL,
    reference_order_line_id integer DEFAULT 0 NOT NULL,
    transaction_date timestamp without time zone DEFAULT now() NOT NULL,
    transaction_type character(1) NOT NULL,
    quantity integer NOT NULL,
    actual_cost numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK ((upper((transaction_type)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE production.transaction_history_archive OWNER TO postgres;

--
-- Name: TABLE transaction_history_archive; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.transaction_history_archive IS 'Transactions for previous years.';


--
-- Name: COLUMN transaction_history_archive.transaction_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.transaction_id IS 'Primary key for TransactionHistoryArchive records.';


--
-- Name: COLUMN transaction_history_archive.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transaction_history_archive.reference_order_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.reference_order_id IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transaction_history_archive.reference_order_line_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.reference_order_line_id IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transaction_history_archive.transaction_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.transaction_date IS 'Date and time of the transaction.';


--
-- Name: COLUMN transaction_history_archive.transaction_type; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.transaction_type IS 'W = Work Order, S = Sales Order, P = Purchase Order';


--
-- Name: COLUMN transaction_history_archive.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.quantity IS 'Product quantity.';


--
-- Name: COLUMN transaction_history_archive.actual_cost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.actual_cost IS 'Product cost.';


--
-- Name: transactionhistory_transactionid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.transactionhistory_transactionid_seq OWNER TO postgres;

--
-- Name: transactionhistory_transactionid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.transactionhistory_transactionid_seq OWNED BY production.transaction_history.transaction_id;


--
-- Name: unit_measure; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.unit_measure (
    unit_measure_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.unit_measure OWNER TO postgres;

--
-- Name: TABLE unit_measure; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.unit_measure IS 'Unit of measure lookup table.';


--
-- Name: COLUMN unit_measure.unit_measure_code; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.unit_measure.unit_measure_code IS 'Primary key.';


--
-- Name: work_order; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.work_order (
    work_order_id integer NOT NULL,
    product_id integer NOT NULL,
    order_qty integer NOT NULL,
    scrapped_qty smallint NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    due_date timestamp without time zone NOT NULL,
    scrap_reason_id smallint,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrder_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_WorkOrder_OrderQty" CHECK ((order_qty > 0)),
    CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK ((scrapped_qty >= 0))
);


ALTER TABLE production.work_order OWNER TO postgres;

--
-- Name: TABLE work_order; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.work_order IS 'Manufacturing work orders.';


--
-- Name: COLUMN work_order.work_order_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.work_order_id IS 'Primary key for WorkOrder records.';


--
-- Name: COLUMN work_order.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN work_order.order_qty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.order_qty IS 'Product quantity to build.';


--
-- Name: COLUMN work_order.scrapped_qty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.scrapped_qty IS 'Quantity that failed inspection.';


--
-- Name: COLUMN work_order.start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.start_date IS 'Work order start date.';


--
-- Name: COLUMN work_order.end_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.end_date IS 'Work order end date.';


--
-- Name: COLUMN work_order.due_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.due_date IS 'Work order due date.';


--
-- Name: COLUMN work_order.scrap_reason_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.scrap_reason_id IS 'Reason for inspection failure.';


--
-- Name: work_order_routing; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.work_order_routing (
    work_order_id integer NOT NULL,
    product_id integer NOT NULL,
    operation_sequence smallint NOT NULL,
    location_id smallint NOT NULL,
    scheduled_start_date timestamp without time zone NOT NULL,
    scheduled_end_date timestamp without time zone NOT NULL,
    actual_start_date timestamp without time zone,
    actual_end_date timestamp without time zone,
    actual_resource_hrs numeric(9,4),
    planned_cost numeric NOT NULL,
    actual_cost numeric,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK ((actual_cost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK (((actual_end_date >= actual_start_date) OR (actual_end_date IS NULL) OR (actual_start_date IS NULL))),
    CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK ((actual_resource_hrs >= 0.0000)),
    CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK ((planned_cost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK ((scheduled_end_date >= scheduled_start_date))
);


ALTER TABLE production.work_order_routing OWNER TO postgres;

--
-- Name: TABLE work_order_routing; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.work_order_routing IS 'Work order details.';


--
-- Name: COLUMN work_order_routing.work_order_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.work_order_id IS 'Primary key. Foreign key to WorkOrder.WorkOrderID.';


--
-- Name: COLUMN work_order_routing.product_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.product_id IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN work_order_routing.operation_sequence; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.operation_sequence IS 'Primary key. Indicates the manufacturing process sequence.';


--
-- Name: COLUMN work_order_routing.location_id; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.location_id IS 'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';


--
-- Name: COLUMN work_order_routing.scheduled_start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.scheduled_start_date IS 'Planned manufacturing start date.';


--
-- Name: COLUMN work_order_routing.scheduled_end_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.scheduled_end_date IS 'Planned manufacturing end date.';


--
-- Name: COLUMN work_order_routing.actual_start_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actual_start_date IS 'Actual start date.';


--
-- Name: COLUMN work_order_routing.actual_end_date; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actual_end_date IS 'Actual end date.';


--
-- Name: COLUMN work_order_routing.actual_resource_hrs; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actual_resource_hrs IS 'Number of manufacturing hours used.';


--
-- Name: COLUMN work_order_routing.planned_cost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.planned_cost IS 'Estimated manufacturing cost.';


--
-- Name: COLUMN work_order_routing.actual_cost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actual_cost IS 'Actual manufacturing cost.';


--
-- Name: workorder_workorderid_seq; Type: SEQUENCE; Schema: production; Owner: postgres
--

CREATE SEQUENCE production.workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.workorder_workorderid_seq OWNER TO postgres;

--
-- Name: workorder_workorderid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: postgres
--

ALTER SEQUENCE production.workorder_workorderid_seq OWNED BY production.work_order.work_order_id;


--
-- Name: product_vendor; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.product_vendor (
    product_id integer NOT NULL,
    business_entity_id integer NOT NULL,
    average_lead_time integer NOT NULL,
    standard_price numeric NOT NULL,
    last_receipt_cost numeric,
    last_receipt_date timestamp without time zone,
    min_order_qty integer NOT NULL,
    max_order_qty integer NOT NULL,
    on_order_qty integer,
    unit_measure_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK ((average_lead_time >= 1)),
    CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK ((last_receipt_cost > 0.00)),
    CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK ((max_order_qty >= 1)),
    CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK ((min_order_qty >= 1)),
    CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK ((on_order_qty >= 0)),
    CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK ((standard_price > 0.00))
);


ALTER TABLE purchasing.product_vendor OWNER TO postgres;

--
-- Name: COLUMN product_vendor.product_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.product_id IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_vendor.business_entity_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.business_entity_id IS 'Primary key. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN product_vendor.last_receipt_cost; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.last_receipt_cost IS 'The selling price when last purchased.';


--
-- Name: COLUMN product_vendor.min_order_qty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.min_order_qty IS 'The maximum quantity that should be ordered.';


--
-- Name: COLUMN product_vendor.max_order_qty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.max_order_qty IS 'The minimum quantity that should be ordered.';


--
-- Name: COLUMN product_vendor.on_order_qty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.on_order_qty IS 'The quantity currently on order.';


--
-- Name: COLUMN product_vendor.unit_measure_code; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.unit_measure_code IS 'The product''s unit of measure.';


--
-- Name: purchase_order_detail; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order_detail (
    purchase_order_id integer NOT NULL,
    purchase_order_detail_id integer NOT NULL,
    due_date timestamp without time zone NOT NULL,
    order_qty smallint NOT NULL,
    product_id integer NOT NULL,
    unit_price numeric NOT NULL,
    received_qty numeric(8,2) NOT NULL,
    rejected_qty numeric(8,2) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK ((order_qty > 0)),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK ((received_qty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK ((rejected_qty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK ((unit_price >= 0.00))
);


ALTER TABLE purchasing.purchase_order_detail OWNER TO postgres;

--
-- Name: COLUMN purchase_order_detail.order_qty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.order_qty IS 'Quantity ordered.';


--
-- Name: COLUMN purchase_order_detail.received_qty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.received_qty IS 'Quantity actually received from the vendor.';


--
-- Name: purchase_order_header; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order_header (
    purchase_order_id integer NOT NULL,
    revision_number smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    employee_id integer NOT NULL,
    vendor_id integer NOT NULL,
    ship_method_id integer NOT NULL,
    order_date timestamp without time zone DEFAULT now() NOT NULL,
    ship_date timestamp without time zone,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    tax_amt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK (((ship_date >= order_date) OR (ship_date IS NULL))),
    CONSTRAINT "CK_PurchaseOrderHeader_Status" CHECK (((status >= 1) AND (status <= 4))),
    CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK ((tax_amt >= 0.00))
);


ALTER TABLE purchasing.purchase_order_header OWNER TO postgres;

--
-- Name: TABLE purchase_order_header; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.purchase_order_header IS 'General purchase order information. See PurchaseOrderDetail.';


--
-- Name: COLUMN purchase_order_header.purchase_order_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.purchase_order_id IS 'Primary key.';


--
-- Name: COLUMN purchase_order_header.revision_number; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.revision_number IS 'Incremental number to track changes to the purchase order over time.';


--
-- Name: COLUMN purchase_order_header.status; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.status IS 'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';


--
-- Name: COLUMN purchase_order_header.employee_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.employee_id IS 'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN purchase_order_header.vendor_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.vendor_id IS 'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN purchase_order_header.ship_method_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.ship_method_id IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN purchase_order_header.order_date; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.order_date IS 'Purchase order creation date.';


--
-- Name: COLUMN purchase_order_header.ship_date; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.ship_date IS 'Estimated shipment date from the vendor.';


--
-- Name: COLUMN purchase_order_header.subtotal; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.subtotal IS 'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';


--
-- Name: COLUMN purchase_order_header.tax_amt; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.tax_amt IS 'Tax amount.';


--
-- Name: COLUMN purchase_order_header.freight; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.freight IS 'Shipping cost.';


--
-- Name: purchaseorderdetail_purchaseorderdetailid_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.purchaseorderdetail_purchaseorderdetailid_seq OWNER TO postgres;

--
-- Name: purchaseorderdetail_purchaseorderdetailid_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq OWNED BY purchasing.purchase_order_detail.purchase_order_detail_id;


--
-- Name: purchaseorderheader_purchaseorderid_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.purchaseorderheader_purchaseorderid_seq OWNER TO postgres;

--
-- Name: purchaseorderheader_purchaseorderid_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq OWNED BY purchasing.purchase_order_header.purchase_order_id;


--
-- Name: ship_method; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.ship_method (
    ship_method_id integer NOT NULL,
    ship_base numeric DEFAULT 0.00 NOT NULL,
    ship_rate numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((ship_base > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((ship_rate > 0.00))
);


ALTER TABLE purchasing.ship_method OWNER TO postgres;

--
-- Name: TABLE ship_method; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.ship_method IS 'Shipping company lookup table.';


--
-- Name: COLUMN ship_method.ship_method_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.ship_method.ship_method_id IS 'Primary key for ShipMethod records.';


--
-- Name: COLUMN ship_method.ship_base; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.ship_method.ship_base IS 'Minimum shipping charge.';


--
-- Name: COLUMN ship_method.ship_rate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.ship_method.ship_rate IS 'Shipping charge per pound.';


--
-- Name: shipmethod_shipmethodid_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.shipmethod_shipmethodid_seq OWNER TO postgres;

--
-- Name: shipmethod_shipmethodid_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.shipmethod_shipmethodid_seq OWNED BY purchasing.ship_method.ship_method_id;


--
-- Name: vendor; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.vendor (
    business_entity_id integer NOT NULL,
    credit_rating smallint NOT NULL,
    purchasing_web_service_url character varying(1024),
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((credit_rating >= 1) AND (credit_rating <= 5)))
);


ALTER TABLE purchasing.vendor OWNER TO postgres;

--
-- Name: TABLE vendor; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.vendor IS 'Companies from whom Adventure Works Cycles purchases parts or other goods.';


--
-- Name: COLUMN vendor.business_entity_id; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.vendor.business_entity_id IS 'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID';


--
-- Name: COLUMN vendor.credit_rating; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.vendor.credit_rating IS '1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';


--
-- Name: COLUMN vendor.purchasing_web_service_url; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.vendor.purchasing_web_service_url IS 'Vendor URL.';


--
-- Name: country_region_currency; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.country_region_currency (
    country_region_code character varying(3) NOT NULL,
    currency_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.country_region_currency OWNER TO postgres;

--
-- Name: COLUMN country_region_currency.country_region_code; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.country_region_currency.country_region_code IS 'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: credit_card; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.credit_card (
    credit_card_id integer NOT NULL,
    card_type character varying(50) NOT NULL,
    card_number character varying(25) NOT NULL,
    exp_month smallint NOT NULL,
    exp_year smallint NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.credit_card OWNER TO postgres;

--
-- Name: COLUMN credit_card.exp_month; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.exp_month IS 'Credit card expiration month.';


--
-- Name: COLUMN credit_card.exp_year; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.exp_year IS 'Credit card expiration year.';


--
-- Name: creditcard_creditcardid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.creditcard_creditcardid_seq OWNER TO postgres;

--
-- Name: creditcard_creditcardid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.creditcard_creditcardid_seq OWNED BY sales.credit_card.credit_card_id;


--
-- Name: currency; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.currency (
    currency_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currency OWNER TO postgres;

--
-- Name: TABLE currency; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.currency IS 'Lookup table containing standard ISO currencies.';


--
-- Name: COLUMN currency.currency_code; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency.currency_code IS 'The ISO code for the Currency.';


--
-- Name: currency_rate; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.currency_rate (
    currency_rate_id integer NOT NULL,
    currency_rate_date timestamp without time zone NOT NULL,
    from_currency_code character(3) NOT NULL,
    to_currency_code character(3) NOT NULL,
    average_rate numeric NOT NULL,
    end_of_day_rate numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currency_rate OWNER TO postgres;

--
-- Name: COLUMN currency_rate.currency_rate_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.currency_rate_id IS 'Primary key for CurrencyRate records.';


--
-- Name: COLUMN currency_rate.currency_rate_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.currency_rate_date IS 'Date and time the exchange rate was obtained.';


--
-- Name: COLUMN currency_rate.from_currency_code; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.from_currency_code IS 'Exchange rate was converted from this currency code.';


--
-- Name: COLUMN currency_rate.to_currency_code; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.to_currency_code IS 'Exchange rate was converted to this currency code.';


--
-- Name: COLUMN currency_rate.average_rate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.average_rate IS 'Average exchange rate for the day.';


--
-- Name: COLUMN currency_rate.end_of_day_rate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.end_of_day_rate IS 'Final exchange rate for the day.';


--
-- Name: currencyrate_currencyrateid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.currencyrate_currencyrateid_seq OWNER TO postgres;

--
-- Name: currencyrate_currencyrateid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.currencyrate_currencyrateid_seq OWNED BY sales.currency_rate.currency_rate_id;


--
-- Name: customer; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.customer (
    customer_id integer NOT NULL,
    person_id integer,
    store_id integer,
    territory_id integer,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.customer OWNER TO postgres;

--
-- Name: TABLE customer; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.customer IS 'Current customer information. Also see the Person and Store tables.';


--
-- Name: COLUMN customer.customer_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.customer_id IS 'Primary key.';


--
-- Name: COLUMN customer.person_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.person_id IS 'Foreign key to Person.BusinessEntityID';


--
-- Name: COLUMN customer.store_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.store_id IS 'Foreign key to Store.BusinessEntityID';


--
-- Name: COLUMN customer.territory_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.territory_id IS 'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: customer_customerid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.customer_customerid_seq OWNER TO postgres;

--
-- Name: customer_customerid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.customer_customerid_seq OWNED BY sales.customer.customer_id;


--
-- Name: person_credit_card; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.person_credit_card (
    business_entity_id integer NOT NULL,
    credit_card_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.person_credit_card OWNER TO postgres;

--
-- Name: sales_order_detail; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_order_detail (
    sales_order_id integer NOT NULL,
    sales_order_detail_id integer NOT NULL,
    carrier_tracking_number character varying(25),
    order_qty smallint NOT NULL,
    product_id integer NOT NULL,
    special_offer_id integer NOT NULL,
    unit_price numeric NOT NULL,
    unit_price_discount numeric DEFAULT 0.0 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((order_qty > 0)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unit_price >= 0.00)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unit_price_discount >= 0.00))
);


ALTER TABLE sales.sales_order_detail OWNER TO postgres;

--
-- Name: COLUMN sales_order_detail.sales_order_detail_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.sales_order_detail_id IS 'Primary key. One incremental unique number per product sold.';


--
-- Name: COLUMN sales_order_detail.order_qty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.order_qty IS 'Quantity ordered per product.';


--
-- Name: COLUMN sales_order_detail.product_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.product_id IS 'Product sold to customer. Foreign key to Product.ProductID.';


--
-- Name: COLUMN sales_order_detail.unit_price; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.unit_price IS 'Selling price of a single product.';


--
-- Name: COLUMN sales_order_detail.unit_price_discount; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.unit_price_discount IS 'Discount amount.';


--
-- Name: sales_order_header; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_order_header (
    sales_order_id integer NOT NULL,
    revision_number smallint DEFAULT 0 NOT NULL,
    order_date timestamp without time zone DEFAULT now() NOT NULL,
    due_date timestamp without time zone NOT NULL,
    ship_date timestamp without time zone,
    status smallint DEFAULT 1 NOT NULL,
    customer_id integer NOT NULL,
    sales_person_id integer,
    territory_id integer,
    bill_to_address_id integer NOT NULL,
    ship_to_address_id integer NOT NULL,
    ship_method_id integer NOT NULL,
    credit_card_id integer,
    credit_card_approval_code character varying(15),
    currency_rate_id integer,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    tax_amt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    total_due numeric,
    comment character varying(128),
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ((due_date >= order_date)),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (((ship_date >= order_date) OR (ship_date IS NULL))),
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (((status >= 0) AND (status <= 8))),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ((tax_amt >= 0.00))
);


ALTER TABLE sales.sales_order_header OWNER TO postgres;

--
-- Name: COLUMN sales_order_header.sales_order_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.sales_order_id IS 'Primary key.';


--
-- Name: COLUMN sales_order_header.revision_number; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.revision_number IS 'Incremental number to track changes to the sales order over time.';


--
-- Name: COLUMN sales_order_header.order_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.order_date IS 'Dates the sales order was created.';


--
-- Name: COLUMN sales_order_header.due_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.due_date IS 'Date the order is due to the customer.';


--
-- Name: COLUMN sales_order_header.ship_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.ship_date IS 'Date the order was shipped to the customer.';


--
-- Name: COLUMN sales_order_header.status; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.status IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';


--
-- Name: COLUMN sales_order_header.customer_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.customer_id IS 'Customer identification number. Foreign key to Customer.BusinessEntityID.';


--
-- Name: COLUMN sales_order_header.sales_person_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.sales_person_id IS 'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN sales_order_header.territory_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.territory_id IS 'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN sales_order_header.bill_to_address_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.bill_to_address_id IS 'Customer billing address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN sales_order_header.ship_to_address_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.ship_to_address_id IS 'Customer shipping address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN sales_order_header.ship_method_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.ship_method_id IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN sales_order_header.credit_card_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.credit_card_id IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: COLUMN sales_order_header.credit_card_approval_code; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.credit_card_approval_code IS 'Approval code provided by the credit card company.';


--
-- Name: COLUMN sales_order_header.currency_rate_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.currency_rate_id IS 'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';


--
-- Name: COLUMN sales_order_header.subtotal; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.subtotal IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';


--
-- Name: COLUMN sales_order_header.tax_amt; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.tax_amt IS 'Tax amount.';


--
-- Name: COLUMN sales_order_header.freight; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.freight IS 'Shipping cost.';


--
-- Name: COLUMN sales_order_header.total_due; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.total_due IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';


--
-- Name: COLUMN sales_order_header.comment; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.comment IS 'Sales representative comments.';


--
-- Name: sales_order_header_sales_reason; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_order_header_sales_reason (
    sales_order_id integer NOT NULL,
    sales_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.sales_order_header_sales_reason OWNER TO postgres;

--
-- Name: TABLE sales_order_header_sales_reason; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.sales_order_header_sales_reason IS 'Cross-reference table mapping sales orders to sales reason codes.';


--
-- Name: sales_person; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_person (
    business_entity_id integer NOT NULL,
    territory_id integer,
    sales_quota numeric,
    bonus numeric DEFAULT 0.00 NOT NULL,
    commission_pct numeric DEFAULT 0.00 NOT NULL,
    sales_ytd numeric DEFAULT 0.00 NOT NULL,
    sales_last_year numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commission_pct >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK ((sales_last_year >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK ((sales_quota > 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((sales_ytd >= 0.00))
);


ALTER TABLE sales.sales_person OWNER TO postgres;

--
-- Name: COLUMN sales_person.business_entity_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.business_entity_id IS 'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';


--
-- Name: COLUMN sales_person.territory_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.territory_id IS 'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN sales_person.sales_quota; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.sales_quota IS 'Projected yearly sales.';


--
-- Name: COLUMN sales_person.bonus; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.bonus IS 'Bonus due if quota is met.';


--
-- Name: COLUMN sales_person.commission_pct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.commission_pct IS 'Commision percent received per sale.';


--
-- Name: COLUMN sales_person.sales_ytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.sales_ytd IS 'Sales total year to date.';


--
-- Name: COLUMN sales_person.sales_last_year; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.sales_last_year IS 'Sales total of previous year.';


--
-- Name: sales_person_quota_history; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_person_quota_history (
    business_entity_id integer NOT NULL,
    quota_date timestamp without time zone NOT NULL,
    sales_quota numeric NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((sales_quota > 0.00))
);


ALTER TABLE sales.sales_person_quota_history OWNER TO postgres;

--
-- Name: COLUMN sales_person_quota_history.business_entity_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person_quota_history.business_entity_id IS 'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN sales_person_quota_history.quota_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person_quota_history.quota_date IS 'Sales quota date.';


--
-- Name: COLUMN sales_person_quota_history.sales_quota; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person_quota_history.sales_quota IS 'Sales quota amount.';


--
-- Name: sales_reason; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_reason (
    sales_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.sales_reason OWNER TO postgres;

--
-- Name: COLUMN sales_reason.sales_reason_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_reason.sales_reason_id IS 'Primary key for SalesReason records.';


--
-- Name: sales_tax_rate; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_tax_rate (
    sales_tax_rate_id integer NOT NULL,
    state_province_id integer NOT NULL,
    tax_type smallint NOT NULL,
    tax_rate numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((tax_type >= 1) AND (tax_type <= 3)))
);


ALTER TABLE sales.sales_tax_rate OWNER TO postgres;

--
-- Name: COLUMN sales_tax_rate.sales_tax_rate_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.sales_tax_rate_id IS 'Primary key for SalesTaxRate records.';


--
-- Name: COLUMN sales_tax_rate.state_province_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.state_province_id IS 'State, province, or country/region the sales tax applies to.';


--
-- Name: COLUMN sales_tax_rate.tax_rate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.tax_rate IS 'Tax rate amount.';


--
-- Name: sales_territory; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_territory (
    territory_id integer NOT NULL,
    country_region_code character varying(3) NOT NULL,
    "group" character varying(50) NOT NULL,
    sales_ytd numeric DEFAULT 0.00 NOT NULL,
    sales_last_year numeric DEFAULT 0.00 NOT NULL,
    cost_ytd numeric DEFAULT 0.00 NOT NULL,
    cost_last_year numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK ((cost_last_year >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK ((cost_ytd >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK ((sales_last_year >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK ((sales_ytd >= 0.00))
);


ALTER TABLE sales.sales_territory OWNER TO postgres;

--
-- Name: COLUMN sales_territory.territory_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.territory_id IS 'Primary key for SalesTerritory records.';


--
-- Name: COLUMN sales_territory.country_region_code; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.country_region_code IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN sales_territory."group"; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory."group" IS 'Geographic area to which the sales territory belong.';


--
-- Name: COLUMN sales_territory.sales_ytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.sales_ytd IS 'Sales in the territory year to date.';


--
-- Name: COLUMN sales_territory.sales_last_year; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.sales_last_year IS 'Sales in the territory the previous year.';


--
-- Name: COLUMN sales_territory.cost_ytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.cost_ytd IS 'Business costs in the territory year to date.';


--
-- Name: COLUMN sales_territory.cost_last_year; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.cost_last_year IS 'Business costs in the territory the previous year.';


--
-- Name: sales_territory_history; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_territory_history (
    business_entity_id integer NOT NULL,
    territory_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL)))
);


ALTER TABLE sales.sales_territory_history OWNER TO postgres;

--
-- Name: TABLE sales_territory_history; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.sales_territory_history IS 'Sales representative transfers to other sales territories.';


--
-- Name: COLUMN sales_territory_history.business_entity_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.business_entity_id IS 'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN sales_territory_history.territory_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.territory_id IS 'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN sales_territory_history.start_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.start_date IS 'Primary key. Date the sales representive started work in the territory.';


--
-- Name: COLUMN sales_territory_history.end_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.end_date IS 'Date the sales representative left work in the territory.';


--
-- Name: salesorderdetail_salesorderdetailid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesorderdetail_salesorderdetailid_seq OWNER TO postgres;

--
-- Name: salesorderdetail_salesorderdetailid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.salesorderdetail_salesorderdetailid_seq OWNED BY sales.sales_order_detail.sales_order_detail_id;


--
-- Name: salesorderheader_salesorderid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.salesorderheader_salesorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesorderheader_salesorderid_seq OWNER TO postgres;

--
-- Name: salesorderheader_salesorderid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.salesorderheader_salesorderid_seq OWNED BY sales.sales_order_header.sales_order_id;


--
-- Name: salesreason_salesreasonid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesreason_salesreasonid_seq OWNER TO postgres;

--
-- Name: salesreason_salesreasonid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.salesreason_salesreasonid_seq OWNED BY sales.sales_reason.sales_reason_id;


--
-- Name: salestaxrate_salestaxrateid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.salestaxrate_salestaxrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salestaxrate_salestaxrateid_seq OWNER TO postgres;

--
-- Name: salestaxrate_salestaxrateid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.salestaxrate_salestaxrateid_seq OWNED BY sales.sales_tax_rate.sales_tax_rate_id;


--
-- Name: salesterritory_territoryid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesterritory_territoryid_seq OWNER TO postgres;

--
-- Name: salesterritory_territoryid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.salesterritory_territoryid_seq OWNED BY sales.sales_territory.territory_id;


--
-- Name: shopping_cart_item; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.shopping_cart_item (
    shopping_cart_item_id integer NOT NULL,
    shopping_cart_id character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    product_id integer NOT NULL,
    date_created timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);


ALTER TABLE sales.shopping_cart_item OWNER TO postgres;

--
-- Name: COLUMN shopping_cart_item.shopping_cart_item_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.shopping_cart_item_id IS 'Primary key for ShoppingCartItem records.';


--
-- Name: COLUMN shopping_cart_item.shopping_cart_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.shopping_cart_id IS 'Shopping cart identification number.';


--
-- Name: COLUMN shopping_cart_item.quantity; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.quantity IS 'Product quantity ordered.';


--
-- Name: COLUMN shopping_cart_item.product_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.product_id IS 'Product ordered. Foreign key to Product.ProductID.';


--
-- Name: COLUMN shopping_cart_item.date_created; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.date_created IS 'Date the time the record was created.';


--
-- Name: shoppingcartitem_shoppingcartitemid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.shoppingcartitem_shoppingcartitemid_seq OWNER TO postgres;

--
-- Name: shoppingcartitem_shoppingcartitemid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq OWNED BY sales.shopping_cart_item.shopping_cart_item_id;


--
-- Name: special_offer; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.special_offer (
    special_offer_id integer NOT NULL,
    description character varying(255) NOT NULL,
    discount_pct numeric DEFAULT 0.00 NOT NULL,
    type character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    min_qty integer DEFAULT 0 NOT NULL,
    max_qty integer,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK ((discount_pct >= 0.00)),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK ((end_date >= start_date)),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK ((max_qty >= 0)),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK ((min_qty >= 0))
);


ALTER TABLE sales.special_offer OWNER TO postgres;

--
-- Name: COLUMN special_offer.special_offer_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.special_offer_id IS 'Primary key for SpecialOffer records.';


--
-- Name: COLUMN special_offer.description; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.description IS 'Discount description.';


--
-- Name: COLUMN special_offer.discount_pct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.discount_pct IS 'Discount precentage.';


--
-- Name: COLUMN special_offer.type; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.type IS 'Discount type category.';


--
-- Name: COLUMN special_offer.category; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.category IS 'Group the discount applies to such as Reseller or Customer.';


--
-- Name: COLUMN special_offer.start_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.start_date IS 'Discount start date.';


--
-- Name: COLUMN special_offer.end_date; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.end_date IS 'Discount end date.';


--
-- Name: COLUMN special_offer.min_qty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.min_qty IS 'Minimum discount percent allowed.';


--
-- Name: COLUMN special_offer.max_qty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.max_qty IS 'Maximum discount percent allowed.';


--
-- Name: special_offer_product; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.special_offer_product (
    special_offer_id integer NOT NULL,
    product_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.special_offer_product OWNER TO postgres;

--
-- Name: COLUMN special_offer_product.special_offer_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer_product.special_offer_id IS 'Primary key for SpecialOfferProduct records.';


--
-- Name: COLUMN special_offer_product.product_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer_product.product_id IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: specialoffer_specialofferid_seq; Type: SEQUENCE; Schema: sales; Owner: postgres
--

CREATE SEQUENCE sales.specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.specialoffer_specialofferid_seq OWNER TO postgres;

--
-- Name: specialoffer_specialofferid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: postgres
--

ALTER SEQUENCE sales.specialoffer_specialofferid_seq OWNED BY sales.special_offer.special_offer_id;


--
-- Name: store; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.store (
    business_entity_id integer NOT NULL,
    sales_person_id integer,
    demographics xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.store OWNER TO postgres;

--
-- Name: TABLE store; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.store IS 'Customers (resellers) of Adventure Works products.';


--
-- Name: COLUMN store.sales_person_id; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.store.sales_person_id IS 'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN store.demographics; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.store.demographics IS 'Demographic informationg about the store such as the number of employees, annual sales and store type.';


--
-- Name: job_candidate job_candidate_id; Type: DEFAULT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_candidate ALTER COLUMN job_candidate_id SET DEFAULT nextval('human_resources.jobcandidate_jobcandidateid_seq'::regclass);


--
-- Name: address address_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address ALTER COLUMN address_id SET DEFAULT nextval('person.address_addressid_seq'::regclass);


--
-- Name: address_type address_type_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address_type ALTER COLUMN address_type_id SET DEFAULT nextval('person.addresstype_addresstypeid_seq'::regclass);


--
-- Name: business_entity business_entity_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity ALTER COLUMN business_entity_id SET DEFAULT nextval('person.businessentity_businessentityid_seq'::regclass);


--
-- Name: contact_type contact_type_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.contact_type ALTER COLUMN contact_type_id SET DEFAULT nextval('person.contacttype_contacttypeid_seq'::regclass);


--
-- Name: email_address email_address_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.email_address ALTER COLUMN email_address_id SET DEFAULT nextval('person.emailaddress_emailaddressid_seq'::regclass);


--
-- Name: phone_number_type phone_number_type_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.phone_number_type ALTER COLUMN phone_number_type_id SET DEFAULT nextval('person.phonenumbertype_phonenumbertypeid_seq'::regclass);


--
-- Name: state_province state_province_id; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province ALTER COLUMN state_province_id SET DEFAULT nextval('person.stateprovince_stateprovinceid_seq'::regclass);


--
-- Name: bill_of_materials bill_of_materials_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials ALTER COLUMN bill_of_materials_id SET DEFAULT nextval('production.billofmaterials_billofmaterialsid_seq'::regclass);


--
-- Name: illustration illustration_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.illustration ALTER COLUMN illustration_id SET DEFAULT nextval('production.illustration_illustrationid_seq'::regclass);


--
-- Name: location location_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.location ALTER COLUMN location_id SET DEFAULT nextval('production.location_locationid_seq'::regclass);


--
-- Name: product product_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product ALTER COLUMN product_id SET DEFAULT nextval('production.product_productid_seq'::regclass);


--
-- Name: product_category product_category_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_category ALTER COLUMN product_category_id SET DEFAULT nextval('production.productcategory_productcategoryid_seq'::regclass);


--
-- Name: product_description product_description_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_description ALTER COLUMN product_description_id SET DEFAULT nextval('production.productdescription_productdescriptionid_seq'::regclass);


--
-- Name: product_model product_model_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model ALTER COLUMN product_model_id SET DEFAULT nextval('production.productmodel_productmodelid_seq'::regclass);


--
-- Name: product_photo product_photo_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_photo ALTER COLUMN product_photo_id SET DEFAULT nextval('production.productphoto_productphotoid_seq'::regclass);


--
-- Name: product_review product_review_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_review ALTER COLUMN product_review_id SET DEFAULT nextval('production.productreview_productreviewid_seq'::regclass);


--
-- Name: product_subcategory product_subcategory_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_subcategory ALTER COLUMN product_subcategory_id SET DEFAULT nextval('production.productsubcategory_productsubcategoryid_seq'::regclass);


--
-- Name: scrap_reason scrap_reason_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.scrap_reason ALTER COLUMN scrap_reason_id SET DEFAULT nextval('production.scrapreason_scrapreasonid_seq'::regclass);


--
-- Name: transaction_history transaction_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history ALTER COLUMN transaction_id SET DEFAULT nextval('production.transactionhistory_transactionid_seq'::regclass);


--
-- Name: work_order work_order_id; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order ALTER COLUMN work_order_id SET DEFAULT nextval('production.workorder_workorderid_seq'::regclass);


--
-- Name: purchase_order_detail purchase_order_detail_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail ALTER COLUMN purchase_order_detail_id SET DEFAULT nextval('purchasing.purchaseorderdetail_purchaseorderdetailid_seq'::regclass);


--
-- Name: purchase_order_header purchase_order_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header ALTER COLUMN purchase_order_id SET DEFAULT nextval('purchasing.purchaseorderheader_purchaseorderid_seq'::regclass);


--
-- Name: ship_method ship_method_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.ship_method ALTER COLUMN ship_method_id SET DEFAULT nextval('purchasing.shipmethod_shipmethodid_seq'::regclass);


--
-- Name: credit_card credit_card_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.credit_card ALTER COLUMN credit_card_id SET DEFAULT nextval('sales.creditcard_creditcardid_seq'::regclass);


--
-- Name: currency_rate currency_rate_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate ALTER COLUMN currency_rate_id SET DEFAULT nextval('sales.currencyrate_currencyrateid_seq'::regclass);


--
-- Name: customer customer_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer ALTER COLUMN customer_id SET DEFAULT nextval('sales.customer_customerid_seq'::regclass);


--
-- Name: sales_order_detail sales_order_detail_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail ALTER COLUMN sales_order_detail_id SET DEFAULT nextval('sales.salesorderdetail_salesorderdetailid_seq'::regclass);


--
-- Name: sales_order_header sales_order_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header ALTER COLUMN sales_order_id SET DEFAULT nextval('sales.salesorderheader_salesorderid_seq'::regclass);


--
-- Name: sales_reason sales_reason_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_reason ALTER COLUMN sales_reason_id SET DEFAULT nextval('sales.salesreason_salesreasonid_seq'::regclass);


--
-- Name: sales_tax_rate sales_tax_rate_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_tax_rate ALTER COLUMN sales_tax_rate_id SET DEFAULT nextval('sales.salestaxrate_salestaxrateid_seq'::regclass);


--
-- Name: sales_territory territory_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory ALTER COLUMN territory_id SET DEFAULT nextval('sales.salesterritory_territoryid_seq'::regclass);


--
-- Name: shopping_cart_item shopping_cart_item_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shopping_cart_item ALTER COLUMN shopping_cart_item_id SET DEFAULT nextval('sales.shoppingcartitem_shoppingcartitemid_seq'::regclass);


--
-- Name: special_offer special_offer_id; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer ALTER COLUMN special_offer_id SET DEFAULT nextval('sales.specialoffer_specialofferid_seq'::regclass);


--
-- Data for Name: department; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.department (department_id, modified_date) FROM stdin;
\.


--
-- Data for Name: employee_department_history; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_department_history (businessentity_id, department_id, shift_id, start_date, end_date, modified_date) FROM stdin;
\.


--
-- Data for Name: employee_pay_history; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_pay_history (business_entity_id, rate_change_date, rate, pay_frequency, modified_date) FROM stdin;
\.


--
-- Data for Name: job_candidate; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.job_candidate (job_candidate_id, business_entity_id, resume, modified_date) FROM stdin;
\.


--
-- Data for Name: shift; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.shift (shift_id, start_time, end_time, modified_date) FROM stdin;
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.address (address_id, address_line_1, address_line_2, city, state_province_id, zipcode, spatial_location, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: address_type; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.address_type (address_type_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: business_entity; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.business_entity (business_entity_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: business_entity_address; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.business_entity_address (business_entity_id, address_id, address_type_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: business_entity_contact; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.business_entity_contact (business_entity_id, person_id, contact_type_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: contact_type; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.contact_type (contact_type_id, modified_date) FROM stdin;
\.


--
-- Data for Name: country_region; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.country_region (country_region_code, modified_date) FROM stdin;
\.


--
-- Data for Name: email_address; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.email_address (business_entity_id, email_address_id, email_address, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: password; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.password (business_entity_id, password_hash, password_salt, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.person (business_entity_id, person_type, title, suffix, email_promotion, additional_contact_info, demo_graphics, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: person_phone; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.person_phone (business_entity_id, phone_number_type_id, modified_date) FROM stdin;
\.


--
-- Data for Name: phone_number_type; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.phone_number_type (phone_number_type_id, modified_date) FROM stdin;
\.


--
-- Data for Name: state_province; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.state_province (state_province_id, state_province_code, country_region_code, territory_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: bill_of_materials; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.bill_of_materials (bill_of_materials_id, product_assembly_id, component_id, start_date, end_date, unit_measure_code, bom_level, per_assembly_qty, modified_date) FROM stdin;
\.


--
-- Data for Name: culture; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.culture (culture_id, modified_date) FROM stdin;
\.


--
-- Data for Name: document; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.document (title, owner, file_name, file_extension, revision, change_number, status, document_summary, document, row_guid, modified_date, document_node) FROM stdin;
\.


--
-- Data for Name: illustration; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.illustration (illustration_id, diagram, modified_date) FROM stdin;
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.location (location_id, cost_rate, availability, modified_date) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product (product_id, product_number, color, safety_stock_level, reorder_point, standard_cost, list_price, size, size_unit_measure_code, weight_unit_measure_code, weight, days_to_manufacture, product_line, class, style, product_subcategory_id, product_model_id, sell_start_date, sellend_date, discontinued_date, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_category (product_category_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: product_cost_history; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_cost_history (product_id, start_date, end_date, standard_cost, modified_date) FROM stdin;
\.


--
-- Data for Name: product_description; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_description (product_description_id, description, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: product_document; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_document (product_id, modified_date, document_node) FROM stdin;
\.


--
-- Data for Name: product_inventory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_inventory (product_id, location_id, shelf, bin, quantity, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: product_list_price_history; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_list_price_history (product_id, start_date, end_date, list_price, modified_date) FROM stdin;
\.


--
-- Data for Name: product_model; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_model (product_model_id, catalog_description, instructions, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: product_model_illustration; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_model_illustration (product_model_id, illustration_id, modified_date) FROM stdin;
\.


--
-- Data for Name: product_model_product_description_culture; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_model_product_description_culture (product_model_id, product_description_id, culture_id, modified_date) FROM stdin;
\.


--
-- Data for Name: product_photo; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_photo (product_photo_id, thumbnail_photo, thumbnail_photo_file_name, large_photo, large_photo_file_name, modified_date) FROM stdin;
\.


--
-- Data for Name: product_product_photo; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_product_photo (product_id, product_photo_id, modified_date) FROM stdin;
\.


--
-- Data for Name: product_review; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_review (product_review_id, product_id, review_date, email_address, rating, comments, modified_date) FROM stdin;
1	709	2013-09-18 00:00:00	john@fourthcoffee.com	5	I can't believe I'm singing the praises of a pair of socks, but I just came back from a grueling\n3-day ride and these socks really helped make the trip a blast. They're lightweight yet really cushioned my feet all day. \nThe reinforced toe is nearly bullet-proof and I didn't experience any problems with rubbing or blisters like I have with\nother brands. I know it sounds silly, but it's always the little stuff (like comfortable feet) that makes or breaks a long trip.\nI won't go on another trip without them!	2013-09-18 00:00:00
2	937	2013-11-13 00:00:00	david@graphicdesigninstitute.com	4	A little on the heavy side, but overall the entry/exit is easy in all conditions. I've used these pedals for \nmore than 3 years and I've never had a problem. Cleanup is easy. Mud and sand don't get trapped. I would like \nthem even better if there was a weight reduction. Maybe in the next design. Still, I would recommend them to a friend.	2013-11-13 00:00:00
3	937	2013-11-15 00:00:00	jill@margiestravel.com	2	Maybe it's just because I'm new to mountain biking, but I had a terrible time getting use\nto these pedals. In my first outing, I wiped out trying to release my foot. Any suggestions on\nways I can adjust the pedals, or is it just a learning curve thing?	2013-11-15 00:00:00
4	798	2013-11-15 00:00:00	laura@treyresearch.net	5	The Road-550-W from Adventure Works Cycles is everything it's advertised to be. Finally, a quality bike that\nis actually built for a woman and provides control and comfort in one neat package. The top tube is shorter, the suspension is weight-tuned and there's a much shorter reach to the brake\nlevers. All this adds up to a great mountain bike that is sure to accommodate any woman's anatomy. In addition to getting the size right, the saddle is incredibly comfortable. \nAttention to detail is apparent in every aspect from the frame finish to the careful design of each component. Each component is a solid performer without any fluff. \nThe designers clearly did their homework and thought about size, weight, and funtionality throughout. And at less than 19 pounds, the bike is manageable for even the most petite cyclist.\n\nWe had 5 riders take the bike out for a spin and really put it to the test. The results were consistent and very positive. Our testers loved the manuverability \nand control they had with the redesigned frame on the 550-W. A definite improvement over the 2012 design. Four out of five testers listed quick handling\nand responsivness were the key elements they noticed. Technical climbing and on the flats, the bike just cruises through the rough. Tight corners and obstacles were handled effortlessly. The fifth tester was more impressed with the smooth ride. The heavy-duty shocks absorbed even the worst bumps and provided a soft ride on all but the \nnastiest trails and biggest drops. The shifting was rated superb and typical of what we've come to expect from Adventure Works Cycles. On descents, the bike handled flawlessly and tracked very well. The bike is well balanced front-to-rear and frame flex was minimal. In particular, the testers\nnoted that the brake system had a unique combination of power and modulation.  While some brake setups can be overly touchy, these brakes had a good\namount of power, but also a good feel that allows you to apply as little or as much braking power as is needed. Second is their short break-in period. We found that they tend to break-in well before\nthe end of the first ride; while others take two to three rides (or more) to come to full power. \n\nOn the negative side, the pedals were not quite up to our tester's standards. \nJust for fun, we experimented with routine maintenance tasks. Overall we found most operations to be straight forward and easy to complete. The only exception was replacing the front wheel. The maintenance manual that comes\nwith the bike say to install the front wheel with the axle quick release or bolt, then compress the fork a few times before fastening and tightening the two quick-release mechanisms on the bottom of the dropouts. This is to seat the axle in the dropouts, and if you do not\ndo this, the axle will become seated after you tightened the two bottom quick releases, which will then become loose. It's better to test the tightness carefully or you may notice that the two bottom quick releases have come loose enough to fall completely open. And that's something you don't want to experience\nwhile out on the road! \n\nThe Road-550-W frame is available in a variety of sizes and colors and has the same durable, high-quality aluminum that AWC is known for. At a MSRP of just under $1125.00, it's comparable in price to its closest competitors and\nwe think that after a test drive you'l find the quality and performance above and beyond . You'll have a grin on your face and be itching to get out on the road for more. While designed for serious road racing, the Road-550-W would be an excellent choice for just about any terrain and \nany level of experience. It's a huge step in the right direction for female cyclists and well worth your consideration and hard-earned money.	2013-11-15 00:00:00
\.


--
-- Data for Name: product_subcategory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_subcategory (product_subcategory_id, product_category_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: scrap_reason; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.scrap_reason (scrap_reason_id, modified_date) FROM stdin;
\.


--
-- Data for Name: transaction_history; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.transaction_history (transaction_id, product_id, reference_order_id, reference_order_line_id, transaction_date, transaction_type, quantity, actual_cost, modified_date) FROM stdin;
\.


--
-- Data for Name: transaction_history_archive; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.transaction_history_archive (transaction_id, product_id, reference_order_id, reference_order_line_id, transaction_date, transaction_type, quantity, actual_cost, modified_date) FROM stdin;
\.


--
-- Data for Name: unit_measure; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.unit_measure (unit_measure_code, modified_date) FROM stdin;
\.


--
-- Data for Name: work_order; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.work_order (work_order_id, product_id, order_qty, scrapped_qty, start_date, end_date, due_date, scrap_reason_id, modified_date) FROM stdin;
\.


--
-- Data for Name: work_order_routing; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.work_order_routing (work_order_id, product_id, operation_sequence, location_id, scheduled_start_date, scheduled_end_date, actual_start_date, actual_end_date, actual_resource_hrs, planned_cost, actual_cost, modified_date) FROM stdin;
\.


--
-- Data for Name: product_vendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.product_vendor (product_id, business_entity_id, average_lead_time, standard_price, last_receipt_cost, last_receipt_date, min_order_qty, max_order_qty, on_order_qty, unit_measure_code, modified_date) FROM stdin;
\.


--
-- Data for Name: purchase_order_detail; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order_detail (purchase_order_id, purchase_order_detail_id, due_date, order_qty, product_id, unit_price, received_qty, rejected_qty, modified_date) FROM stdin;
\.


--
-- Data for Name: purchase_order_header; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order_header (purchase_order_id, revision_number, status, employee_id, vendor_id, ship_method_id, order_date, ship_date, subtotal, tax_amt, freight, modified_date) FROM stdin;
\.


--
-- Data for Name: ship_method; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.ship_method (ship_method_id, ship_base, ship_rate, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: vendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.vendor (business_entity_id, credit_rating, purchasing_web_service_url, modified_date) FROM stdin;
\.


--
-- Data for Name: country_region_currency; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.country_region_currency (country_region_code, currency_code, modified_date) FROM stdin;
\.


--
-- Data for Name: credit_card; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.credit_card (credit_card_id, card_type, card_number, exp_month, exp_year, modified_date) FROM stdin;
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.currency (currency_code, modified_date) FROM stdin;
\.


--
-- Data for Name: currency_rate; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.currency_rate (currency_rate_id, currency_rate_date, from_currency_code, to_currency_code, average_rate, end_of_day_rate, modified_date) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customer (customer_id, person_id, store_id, territory_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: person_credit_card; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.person_credit_card (business_entity_id, credit_card_id, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_order_detail; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_order_detail (sales_order_id, sales_order_detail_id, carrier_tracking_number, order_qty, product_id, special_offer_id, unit_price, unit_price_discount, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_order_header; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_order_header (sales_order_id, revision_number, order_date, due_date, ship_date, status, customer_id, sales_person_id, territory_id, bill_to_address_id, ship_to_address_id, ship_method_id, credit_card_id, credit_card_approval_code, currency_rate_id, subtotal, tax_amt, freight, total_due, comment, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_order_header_sales_reason; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_order_header_sales_reason (sales_order_id, sales_reason_id, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_person; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_person (business_entity_id, territory_id, sales_quota, bonus, commission_pct, sales_ytd, sales_last_year, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_person_quota_history; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_person_quota_history (business_entity_id, quota_date, sales_quota, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_reason; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_reason (sales_reason_id, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_tax_rate; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_tax_rate (sales_tax_rate_id, state_province_id, tax_type, tax_rate, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_territory; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_territory (territory_id, country_region_code, "group", sales_ytd, sales_last_year, cost_ytd, cost_last_year, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: sales_territory_history; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_territory_history (business_entity_id, territory_id, start_date, end_date, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: shopping_cart_item; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.shopping_cart_item (shopping_cart_item_id, shopping_cart_id, quantity, product_id, date_created, modified_date) FROM stdin;
\.


--
-- Data for Name: special_offer; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.special_offer (special_offer_id, description, discount_pct, type, category, start_date, end_date, min_qty, max_qty, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: special_offer_product; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.special_offer_product (special_offer_id, product_id, row_guid, modified_date) FROM stdin;
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.store (business_entity_id, sales_person_id, demographics, row_guid, modified_date) FROM stdin;
\.


--
-- Name: jobcandidate_jobcandidateid_seq; Type: SEQUENCE SET; Schema: human_resources; Owner: postgres
--

SELECT pg_catalog.setval('human_resources.jobcandidate_jobcandidateid_seq', 1, false);


--
-- Name: address_addressid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.address_addressid_seq', 1, false);


--
-- Name: addresstype_addresstypeid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.addresstype_addresstypeid_seq', 1, false);


--
-- Name: businessentity_businessentityid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.businessentity_businessentityid_seq', 1, false);


--
-- Name: contacttype_contacttypeid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.contacttype_contacttypeid_seq', 1, false);


--
-- Name: emailaddress_emailaddressid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.emailaddress_emailaddressid_seq', 1, false);


--
-- Name: phonenumbertype_phonenumbertypeid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.phonenumbertype_phonenumbertypeid_seq', 1, false);


--
-- Name: stateprovince_stateprovinceid_seq; Type: SEQUENCE SET; Schema: person; Owner: postgres
--

SELECT pg_catalog.setval('person.stateprovince_stateprovinceid_seq', 1, false);


--
-- Name: billofmaterials_billofmaterialsid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.billofmaterials_billofmaterialsid_seq', 1, false);


--
-- Name: illustration_illustrationid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.illustration_illustrationid_seq', 1, false);


--
-- Name: location_locationid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.location_locationid_seq', 1, false);


--
-- Name: product_productid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.product_productid_seq', 1, false);


--
-- Name: productcategory_productcategoryid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.productcategory_productcategoryid_seq', 1, false);


--
-- Name: productdescription_productdescriptionid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.productdescription_productdescriptionid_seq', 1, false);


--
-- Name: productmodel_productmodelid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.productmodel_productmodelid_seq', 1, false);


--
-- Name: productphoto_productphotoid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.productphoto_productphotoid_seq', 1, false);


--
-- Name: productreview_productreviewid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.productreview_productreviewid_seq', 1, false);


--
-- Name: productsubcategory_productsubcategoryid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.productsubcategory_productsubcategoryid_seq', 1, false);


--
-- Name: scrapreason_scrapreasonid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.scrapreason_scrapreasonid_seq', 1, false);


--
-- Name: transactionhistory_transactionid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.transactionhistory_transactionid_seq', 1, false);


--
-- Name: workorder_workorderid_seq; Type: SEQUENCE SET; Schema: production; Owner: postgres
--

SELECT pg_catalog.setval('production.workorder_workorderid_seq', 1, false);


--
-- Name: purchaseorderdetail_purchaseorderdetailid_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.purchaseorderdetail_purchaseorderdetailid_seq', 1, false);


--
-- Name: purchaseorderheader_purchaseorderid_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.purchaseorderheader_purchaseorderid_seq', 1, false);


--
-- Name: shipmethod_shipmethodid_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.shipmethod_shipmethodid_seq', 1, false);


--
-- Name: creditcard_creditcardid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.creditcard_creditcardid_seq', 1, false);


--
-- Name: currencyrate_currencyrateid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.currencyrate_currencyrateid_seq', 1, false);


--
-- Name: customer_customerid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.customer_customerid_seq', 1, false);


--
-- Name: salesorderdetail_salesorderdetailid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.salesorderdetail_salesorderdetailid_seq', 1, false);


--
-- Name: salesorderheader_salesorderid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.salesorderheader_salesorderid_seq', 1, false);


--
-- Name: salesreason_salesreasonid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.salesreason_salesreasonid_seq', 1, false);


--
-- Name: salestaxrate_salestaxrateid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.salestaxrate_salestaxrateid_seq', 1, false);


--
-- Name: salesterritory_territoryid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.salesterritory_territoryid_seq', 1, false);


--
-- Name: shoppingcartitem_shoppingcartitemid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.shoppingcartitem_shoppingcartitemid_seq', 1, false);


--
-- Name: specialoffer_specialofferid_seq; Type: SEQUENCE SET; Schema: sales; Owner: postgres
--

SELECT pg_catalog.setval('sales.specialoffer_specialofferid_seq', 1, false);


--
-- Name: department PK_Department_DepartmentID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (department_id);

ALTER TABLE human_resources.department CLUSTER ON "PK_Department_DepartmentID";


--
-- Name: employee_department_history PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (businessentity_id, start_date, department_id, shift_id);

ALTER TABLE human_resources.employee_department_history CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";


--
-- Name: employee_pay_history PK_EmployeePayHistory_BusinessEntityID_RateChangeDate; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_pay_history
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (business_entity_id, rate_change_date);

ALTER TABLE human_resources.employee_pay_history CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";


--
-- Name: job_candidate PK_JobCandidate_JobCandidateID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_candidate
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (job_candidate_id);

ALTER TABLE human_resources.job_candidate CLUSTER ON "PK_JobCandidate_JobCandidateID";


--
-- Name: shift PK_Shift_ShiftID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shift_id);

ALTER TABLE human_resources.shift CLUSTER ON "PK_Shift_ShiftID";


--
-- Name: address_type PK_AddressType_AddressTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address_type
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (address_type_id);

ALTER TABLE person.address_type CLUSTER ON "PK_AddressType_AddressTypeID";


--
-- Name: address PK_Address_AddressID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (address_id);

ALTER TABLE person.address CLUSTER ON "PK_Address_AddressID";


--
-- Name: business_entity_address PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (business_entity_id, address_id, address_type_id);

ALTER TABLE person.business_entity_address CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";


--
-- Name: business_entity_contact PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (business_entity_id, person_id, contact_type_id);

ALTER TABLE person.business_entity_contact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";


--
-- Name: business_entity PK_BusinessEntity_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE person.business_entity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";


--
-- Name: contact_type PK_ContactType_ContactTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.contact_type
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contact_type_id);

ALTER TABLE person.contact_type CLUSTER ON "PK_ContactType_ContactTypeID";


--
-- Name: country_region PK_CountryRegion_CountryRegionCode; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.country_region
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (country_region_code);

ALTER TABLE person.country_region CLUSTER ON "PK_CountryRegion_CountryRegionCode";


--
-- Name: email_address PK_EmailAddress_BusinessEntityID_EmailAddressID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.email_address
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (business_entity_id, email_address_id);

ALTER TABLE person.email_address CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";


--
-- Name: password PK_Password_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.password
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE person.password CLUSTER ON "PK_Password_BusinessEntityID";


--
-- Name: person PK_Person_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE person.person CLUSTER ON "PK_Person_BusinessEntityID";


--
-- Name: phone_number_type PK_PhoneNumberType_PhoneNumberTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.phone_number_type
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phone_number_type_id);

ALTER TABLE person.phone_number_type CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";


--
-- Name: state_province PK_StateProvince_StateProvinceID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (state_province_id);

ALTER TABLE person.state_province CLUSTER ON "PK_StateProvince_StateProvinceID";


--
-- Name: bill_of_materials PK_BillOfMaterials_BillOfMaterialsID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (bill_of_materials_id);


--
-- Name: culture PK_Culture_CultureID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (culture_id);

ALTER TABLE production.culture CLUSTER ON "PK_Culture_CultureID";


--
-- Name: document PK_Document_DocumentNode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (document_node);

ALTER TABLE production.document CLUSTER ON "PK_Document_DocumentNode";


--
-- Name: illustration PK_Illustration_IllustrationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.illustration
    ADD CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illustration_id);

ALTER TABLE production.illustration CLUSTER ON "PK_Illustration_IllustrationID";


--
-- Name: location PK_Location_LocationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.location
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (location_id);

ALTER TABLE production.location CLUSTER ON "PK_Location_LocationID";


--
-- Name: product_category PK_ProductCategory_ProductCategoryID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_category
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (product_category_id);

ALTER TABLE production.product_category CLUSTER ON "PK_ProductCategory_ProductCategoryID";


--
-- Name: product_cost_history PK_ProductCostHistory_ProductID_StartDate; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_cost_history
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (product_id, start_date);

ALTER TABLE production.product_cost_history CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";


--
-- Name: product_description PK_ProductDescription_ProductDescriptionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_description
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (product_description_id);

ALTER TABLE production.product_description CLUSTER ON "PK_ProductDescription_ProductDescriptionID";


--
-- Name: product_document PK_ProductDocument_ProductID_DocumentNode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_document
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (product_id, document_node);

ALTER TABLE production.product_document CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";


--
-- Name: product_inventory PK_ProductInventory_ProductID_LocationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_inventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (product_id, location_id);

ALTER TABLE production.product_inventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";


--
-- Name: product_list_price_history PK_ProductListPriceHistory_ProductID_StartDate; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_list_price_history
    ADD CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY (product_id, start_date);

ALTER TABLE production.product_list_price_history CLUSTER ON "PK_ProductListPriceHistory_ProductID_StartDate";


--
-- Name: product_model_illustration PK_ProductModelIllustration_ProductModelID_IllustrationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_illustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (product_model_id, illustration_id);

ALTER TABLE production.product_model_illustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";


--
-- Name: product_model_product_description_culture PK_ProductModelProductDescriptionCulture_ProductModelID_Product; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (product_model_id, product_description_id, culture_id);

ALTER TABLE production.product_model_product_description_culture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";


--
-- Name: product_model PK_ProductModel_ProductModelID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (product_model_id);

ALTER TABLE production.product_model CLUSTER ON "PK_ProductModel_ProductModelID";


--
-- Name: product_photo PK_ProductPhoto_ProductPhotoID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_photo
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (product_photo_id);

ALTER TABLE production.product_photo CLUSTER ON "PK_ProductPhoto_ProductPhotoID";


--
-- Name: product_product_photo PK_ProductProductPhoto_ProductID_ProductPhotoID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_product_photo
    ADD CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY (product_id, product_photo_id);


--
-- Name: product_review PK_ProductReview_ProductReviewID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_review
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (product_review_id);

ALTER TABLE production.product_review CLUSTER ON "PK_ProductReview_ProductReviewID";


--
-- Name: product_subcategory PK_ProductSubcategory_ProductSubcategoryID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_subcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (product_subcategory_id);

ALTER TABLE production.product_subcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";


--
-- Name: product PK_Product_ProductID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (product_id);

ALTER TABLE production.product CLUSTER ON "PK_Product_ProductID";


--
-- Name: scrap_reason PK_ScrapReason_ScrapReasonID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.scrap_reason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrap_reason_id);

ALTER TABLE production.scrap_reason CLUSTER ON "PK_ScrapReason_ScrapReasonID";


--
-- Name: transaction_history_archive PK_TransactionHistoryArchive_TransactionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history_archive
    ADD CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE production.transaction_history_archive CLUSTER ON "PK_TransactionHistoryArchive_TransactionID";


--
-- Name: transaction_history PK_TransactionHistory_TransactionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE production.transaction_history CLUSTER ON "PK_TransactionHistory_TransactionID";


--
-- Name: unit_measure PK_UnitMeasure_UnitMeasureCode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.unit_measure
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unit_measure_code);

ALTER TABLE production.unit_measure CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";


--
-- Name: work_order_routing PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order_routing
    ADD CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY (work_order_id, product_id, operation_sequence);

ALTER TABLE production.work_order_routing CLUSTER ON "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence";


--
-- Name: work_order PK_WorkOrder_WorkOrderID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (work_order_id);

ALTER TABLE production.work_order CLUSTER ON "PK_WorkOrder_WorkOrderID";


--
-- Name: document document_rowguid_key; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT document_rowguid_key UNIQUE (row_guid);


--
-- Name: product_vendor PK_ProductVendor_ProductID_BusinessEntityID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (product_id, business_entity_id);

ALTER TABLE purchasing.product_vendor CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";


--
-- Name: purchase_order_detail PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (purchase_order_id, purchase_order_detail_id);

ALTER TABLE purchasing.purchase_order_detail CLUSTER ON "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";


--
-- Name: purchase_order_header PK_PurchaseOrderHeader_PurchaseOrderID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (purchase_order_id);

ALTER TABLE purchasing.purchase_order_header CLUSTER ON "PK_PurchaseOrderHeader_PurchaseOrderID";


--
-- Name: ship_method PK_ShipMethod_ShipMethodID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.ship_method
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (ship_method_id);

ALTER TABLE purchasing.ship_method CLUSTER ON "PK_ShipMethod_ShipMethodID";


--
-- Name: vendor PK_Vendor_BusinessEntityID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE purchasing.vendor CLUSTER ON "PK_Vendor_BusinessEntityID";


--
-- Name: country_region_currency PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.country_region_currency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (country_region_code, currency_code);

ALTER TABLE sales.country_region_currency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";


--
-- Name: credit_card PK_CreditCard_CreditCardID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.credit_card
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (credit_card_id);

ALTER TABLE sales.credit_card CLUSTER ON "PK_CreditCard_CreditCardID";


--
-- Name: currency_rate PK_CurrencyRate_CurrencyRateID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currency_rate_id);

ALTER TABLE sales.currency_rate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";


--
-- Name: currency PK_Currency_CurrencyCode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currency_code);

ALTER TABLE sales.currency CLUSTER ON "PK_Currency_CurrencyCode";


--
-- Name: customer PK_Customer_CustomerID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customer_id);

ALTER TABLE sales.customer CLUSTER ON "PK_Customer_CustomerID";


--
-- Name: person_credit_card PK_PersonCreditCard_BusinessEntityID_CreditCardID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.person_credit_card
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (business_entity_id, credit_card_id);

ALTER TABLE sales.person_credit_card CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";


--
-- Name: sales_order_detail PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (sales_order_id, sales_order_detail_id);

ALTER TABLE sales.sales_order_detail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";


--
-- Name: sales_order_header_sales_reason PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header_sales_reason
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (sales_order_id, sales_reason_id);

ALTER TABLE sales.sales_order_header_sales_reason CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";


--
-- Name: sales_order_header PK_SalesOrderHeader_SalesOrderID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (sales_order_id);

ALTER TABLE sales.sales_order_header CLUSTER ON "PK_SalesOrderHeader_SalesOrderID";


--
-- Name: sales_person_quota_history PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person_quota_history
    ADD CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (business_entity_id, quota_date);

ALTER TABLE sales.sales_person_quota_history CLUSTER ON "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";


--
-- Name: sales_person PK_SalesPerson_BusinessEntityID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE sales.sales_person CLUSTER ON "PK_SalesPerson_BusinessEntityID";


--
-- Name: sales_reason PK_SalesReason_SalesReasonID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_reason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (sales_reason_id);

ALTER TABLE sales.sales_reason CLUSTER ON "PK_SalesReason_SalesReasonID";


--
-- Name: sales_tax_rate PK_SalesTaxRate_SalesTaxRateID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_tax_rate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (sales_tax_rate_id);

ALTER TABLE sales.sales_tax_rate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";


--
-- Name: sales_territory_history PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory_history
    ADD CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (business_entity_id, start_date, territory_id);

ALTER TABLE sales.sales_territory_history CLUSTER ON "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";


--
-- Name: sales_territory PK_SalesTerritory_TerritoryID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territory_id);

ALTER TABLE sales.sales_territory CLUSTER ON "PK_SalesTerritory_TerritoryID";


--
-- Name: shopping_cart_item PK_ShoppingCartItem_ShoppingCartItemID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shopping_cart_item
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shopping_cart_item_id);

ALTER TABLE sales.shopping_cart_item CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";


--
-- Name: special_offer_product PK_SpecialOfferProduct_SpecialOfferID_ProductID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer_product
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (special_offer_id, product_id);

ALTER TABLE sales.special_offer_product CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";


--
-- Name: special_offer PK_SpecialOffer_SpecialOfferID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (special_offer_id);

ALTER TABLE sales.special_offer CLUSTER ON "PK_SpecialOffer_SpecialOfferID";


--
-- Name: store PK_Store_BusinessEntityID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE sales.store CLUSTER ON "PK_Store_BusinessEntityID";


--
-- Name: employee_department_history FK_EmployeeDepartmentHistory_Department_DepartmentID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (department_id) REFERENCES human_resources.department(department_id);


--
-- Name: employee_department_history FK_EmployeeDepartmentHistory_Shift_ShiftID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shift_id) REFERENCES human_resources.shift(shift_id);


--
-- Name: address FK_Address_StateProvince_StateProvinceID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (state_province_id) REFERENCES person.state_province(state_province_id);


--
-- Name: business_entity_address FK_BusinessEntityAddress_AddressType_AddressTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (address_type_id) REFERENCES person.address_type(address_type_id);


--
-- Name: business_entity_address FK_BusinessEntityAddress_Address_AddressID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (address_id) REFERENCES person.address(address_id);


--
-- Name: business_entity_address FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.business_entity(business_entity_id);


--
-- Name: business_entity_contact FK_BusinessEntityContact_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.business_entity(business_entity_id);


--
-- Name: business_entity_contact FK_BusinessEntityContact_ContactType_ContactTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (contact_type_id) REFERENCES person.contact_type(contact_type_id);


--
-- Name: business_entity_contact FK_BusinessEntityContact_Person_PersonID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (person_id) REFERENCES person.person(business_entity_id);


--
-- Name: email_address FK_EmailAddress_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.email_address
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.person(business_entity_id);


--
-- Name: password FK_Password_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.person(business_entity_id);


--
-- Name: person_phone FK_PersonPhone_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person_phone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.person(business_entity_id);


--
-- Name: person_phone FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person_phone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phone_number_type_id) REFERENCES person.phone_number_type(phone_number_type_id);


--
-- Name: person FK_Person_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.business_entity(business_entity_id);


--
-- Name: state_province FK_StateProvince_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES person.country_region(country_region_code);


--
-- Name: state_province FK_StateProvince_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES sales.sales_territory(territory_id);


--
-- Name: bill_of_materials FK_BillOfMaterials_Product_ComponentID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (component_id) REFERENCES production.product(product_id);


--
-- Name: bill_of_materials FK_BillOfMaterials_Product_ProductAssemblyID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (product_assembly_id) REFERENCES production.product(product_id);


--
-- Name: bill_of_materials FK_BillOfMaterials_UnitMeasure_UnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES production.unit_measure(unit_measure_code);


--
-- Name: product_cost_history FK_ProductCostHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_cost_history
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: product_document FK_ProductDocument_Document_DocumentNode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_document
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (document_node) REFERENCES production.document(document_node);


--
-- Name: product_document FK_ProductDocument_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_document
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: product_inventory FK_ProductInventory_Location_LocationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (location_id) REFERENCES production.location(location_id);


--
-- Name: product_inventory FK_ProductInventory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: product_list_price_history FK_ProductListPriceHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_list_price_history
    ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: product_model_illustration FK_ProductModelIllustration_Illustration_IllustrationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustration_id) REFERENCES production.illustration(illustration_id);


--
-- Name: product_model_illustration FK_ProductModelIllustration_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES production.product_model(product_model_id);


--
-- Name: product_model_product_description_culture FK_ProductModelProductDescriptionCulture_Culture_CultureID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (culture_id) REFERENCES production.culture(culture_id);


--
-- Name: product_model_product_description_culture FK_ProductModelProductDescriptionCulture_ProductDescription_Pro; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (product_description_id) REFERENCES production.product_description(product_description_id);


--
-- Name: product_model_product_description_culture FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (product_model_id) REFERENCES production.product_model(product_model_id);


--
-- Name: product_product_photo FK_ProductProductPhoto_ProductPhoto_ProductPhotoID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_product_photo
    ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY (product_photo_id) REFERENCES production.product_photo(product_photo_id);


--
-- Name: product_product_photo FK_ProductProductPhoto_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_product_photo
    ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: product_subcategory FK_ProductSubcategory_ProductCategory_ProductCategoryID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_subcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (product_category_id) REFERENCES production.product_category(product_category_id);


--
-- Name: product FK_Product_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES production.product_model(product_model_id);


--
-- Name: product FK_Product_ProductSubcategory_ProductSubcategoryID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (product_subcategory_id) REFERENCES production.product_subcategory(product_subcategory_id);


--
-- Name: product FK_Product_UnitMeasure_SizeUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (size_unit_measure_code) REFERENCES production.unit_measure(unit_measure_code);


--
-- Name: product FK_Product_UnitMeasure_WeightUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weight_unit_measure_code) REFERENCES production.unit_measure(unit_measure_code);


--
-- Name: transaction_history FK_TransactionHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: work_order_routing FK_WorkOrderRouting_Location_LocationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (location_id) REFERENCES production.location(location_id);


--
-- Name: work_order_routing FK_WorkOrderRouting_WorkOrder_WorkOrderID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (work_order_id) REFERENCES production.work_order(work_order_id);


--
-- Name: work_order FK_WorkOrder_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: work_order FK_WorkOrder_ScrapReason_ScrapReasonID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrap_reason_id) REFERENCES production.scrap_reason(scrap_reason_id);


--
-- Name: product_vendor FK_ProductVendor_Product_ProductID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: product_vendor FK_ProductVendor_UnitMeasure_UnitMeasureCode; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES production.unit_measure(unit_measure_code);


--
-- Name: product_vendor FK_ProductVendor_Vendor_BusinessEntityID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES purchasing.vendor(business_entity_id);


--
-- Name: purchase_order_detail FK_PurchaseOrderDetail_Product_ProductID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: purchase_order_detail FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (purchase_order_id) REFERENCES purchasing.purchase_order_header(purchase_order_id);


--
-- Name: purchase_order_header FK_PurchaseOrderHeader_ShipMethod_ShipMethodID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (ship_method_id) REFERENCES purchasing.ship_method(ship_method_id);


--
-- Name: purchase_order_header FK_PurchaseOrderHeader_Vendor_VendorID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (vendor_id) REFERENCES purchasing.vendor(business_entity_id);


--
-- Name: vendor FK_Vendor_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.business_entity(business_entity_id);


--
-- Name: country_region_currency FK_CountryRegionCurrency_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES person.country_region(country_region_code);


--
-- Name: country_region_currency FK_CountryRegionCurrency_Currency_CurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currency_code) REFERENCES sales.currency(currency_code);


--
-- Name: currency_rate FK_CurrencyRate_Currency_FromCurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (from_currency_code) REFERENCES sales.currency(currency_code);


--
-- Name: currency_rate FK_CurrencyRate_Currency_ToCurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (to_currency_code) REFERENCES sales.currency(currency_code);


--
-- Name: customer FK_Customer_Person_PersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (person_id) REFERENCES person.person(business_entity_id);


--
-- Name: customer FK_Customer_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES sales.sales_territory(territory_id);


--
-- Name: customer FK_Customer_Store_StoreID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (store_id) REFERENCES sales.store(business_entity_id);


--
-- Name: person_credit_card FK_PersonCreditCard_CreditCard_CreditCardID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (credit_card_id) REFERENCES sales.credit_card(credit_card_id);


--
-- Name: person_credit_card FK_PersonCreditCard_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.person(business_entity_id);


--
-- Name: sales_order_detail FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (sales_order_id) REFERENCES sales.sales_order_header(sales_order_id) ON DELETE CASCADE;


--
-- Name: sales_order_detail FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (special_offer_id, product_id) REFERENCES sales.special_offer_product(special_offer_id, product_id);


--
-- Name: sales_order_header_sales_reason FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header_sales_reason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (sales_order_id) REFERENCES sales.sales_order_header(sales_order_id) ON DELETE CASCADE;


--
-- Name: sales_order_header_sales_reason FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header_sales_reason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (sales_reason_id) REFERENCES sales.sales_reason(sales_reason_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_Address_BillToAddressID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (bill_to_address_id) REFERENCES person.address(address_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_Address_ShipToAddressID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (ship_to_address_id) REFERENCES person.address(address_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_CreditCard_CreditCardID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (credit_card_id) REFERENCES sales.credit_card(credit_card_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_CurrencyRate_CurrencyRateID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY (currency_rate_id) REFERENCES sales.currency_rate(currency_rate_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_Customer_CustomerID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY (customer_id) REFERENCES sales.customer(customer_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_SalesPerson_SalesPersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (sales_person_id) REFERENCES sales.sales_person(business_entity_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES sales.sales_territory(territory_id);


--
-- Name: sales_order_header FK_SalesOrderHeader_ShipMethod_ShipMethodID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (ship_method_id) REFERENCES purchasing.ship_method(ship_method_id);


--
-- Name: sales_person_quota_history FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person_quota_history
    ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES sales.sales_person(business_entity_id);


--
-- Name: sales_person FK_SalesPerson_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person
    ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES sales.sales_territory(territory_id);


--
-- Name: sales_tax_rate FK_SalesTaxRate_StateProvince_StateProvinceID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_tax_rate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (state_province_id) REFERENCES person.state_province(state_province_id);


--
-- Name: sales_territory_history FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES sales.sales_person(business_entity_id);


--
-- Name: sales_territory_history FK_SalesTerritoryHistory_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES sales.sales_territory(territory_id);


--
-- Name: sales_territory FK_SalesTerritory_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES person.country_region(country_region_code);


--
-- Name: shopping_cart_item FK_ShoppingCartItem_Product_ProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shopping_cart_item
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: special_offer_product FK_SpecialOfferProduct_Product_ProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer_product
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (product_id) REFERENCES production.product(product_id);


--
-- Name: special_offer_product FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer_product
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (special_offer_id) REFERENCES sales.special_offer(special_offer_id);


--
-- Name: store FK_Store_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES person.business_entity(business_entity_id);


--
-- Name: store FK_Store_SalesPerson_SalesPersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (sales_person_id) REFERENCES sales.sales_person(business_entity_id);


--
-- PostgreSQL database dump complete
--

