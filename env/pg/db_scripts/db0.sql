

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


CREATE SCHEMA db;


ALTER SCHEMA db OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE db.address (
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


ALTER TABLE db.address OWNER TO postgres;


CREATE SEQUENCE db.address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.address_addressid_seq OWNER TO postgres;


ALTER SEQUENCE db.address_addressid_seq OWNED BY db.address.address_id;



CREATE TABLE db.address_type (
    address_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.address_type OWNER TO postgres;


CREATE SEQUENCE db.addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.addresstype_addresstypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.addresstype_addresstypeid_seq OWNED BY db.address_type.address_type_id;



CREATE TABLE db.bill_of_materials (
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


ALTER TABLE db.bill_of_materials OWNER TO postgres;


CREATE SEQUENCE db.billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.billofmaterials_billofmaterialsid_seq OWNER TO postgres;


ALTER SEQUENCE db.billofmaterials_billofmaterialsid_seq OWNED BY db.bill_of_materials.bill_of_materials_id;



CREATE TABLE db.business_entity (
    business_entity_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.business_entity OWNER TO postgres;


CREATE TABLE db.business_entity_address (
    business_entity_id integer NOT NULL,
    address_id integer NOT NULL,
    address_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.business_entity_address OWNER TO postgres;


CREATE TABLE db.business_entity_contact (
    business_entity_id integer NOT NULL,
    person_id integer NOT NULL,
    contact_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.business_entity_contact OWNER TO postgres;


CREATE SEQUENCE db.businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.businessentity_businessentityid_seq OWNER TO postgres;


ALTER SEQUENCE db.businessentity_businessentityid_seq OWNED BY db.business_entity.business_entity_id;



CREATE TABLE db.contact_type (
    contact_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.contact_type OWNER TO postgres;


CREATE SEQUENCE db.contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.contacttype_contacttypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.contacttype_contacttypeid_seq OWNED BY db.contact_type.contact_type_id;



CREATE TABLE db.country_region (
    country_region_code character varying(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.country_region OWNER TO postgres;


CREATE TABLE db.country_region_currency (
    country_region_code character varying(3) NOT NULL,
    currency_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.country_region_currency OWNER TO postgres;


CREATE TABLE db.credit_card (
    credit_card_id integer NOT NULL,
    card_type character varying(50) NOT NULL,
    card_number character varying(25) NOT NULL,
    exp_month smallint NOT NULL,
    exp_year smallint NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.credit_card OWNER TO postgres;


CREATE SEQUENCE db.creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.creditcard_creditcardid_seq OWNER TO postgres;


ALTER SEQUENCE db.creditcard_creditcardid_seq OWNED BY db.credit_card.credit_card_id;



CREATE TABLE db.culture (
    culture_id character(6) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.culture OWNER TO postgres;


CREATE TABLE db.currency (
    currency_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.currency OWNER TO postgres;


CREATE TABLE db.currency_rate (
    currency_rate_id integer NOT NULL,
    currency_rate_date timestamp without time zone NOT NULL,
    from_currency_code character(3) NOT NULL,
    to_currency_code character(3) NOT NULL,
    average_rate numeric NOT NULL,
    end_of_day_rate numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.currency_rate OWNER TO postgres;


CREATE SEQUENCE db.currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.currencyrate_currencyrateid_seq OWNER TO postgres;


ALTER SEQUENCE db.currencyrate_currencyrateid_seq OWNED BY db.currency_rate.currency_rate_id;



CREATE TABLE db.customer (
    customer_id integer NOT NULL,
    person_id integer,
    store_id integer,
    territory_id integer,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.customer OWNER TO postgres;


CREATE SEQUENCE db.customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.customer_customerid_seq OWNER TO postgres;


ALTER SEQUENCE db.customer_customerid_seq OWNED BY db.customer.customer_id;



CREATE TABLE db.department (
    department_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.department OWNER TO postgres;


CREATE TABLE db.document (
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


ALTER TABLE db.document OWNER TO postgres;


CREATE TABLE db.email_address (
    business_entity_id integer NOT NULL,
    email_address_id integer NOT NULL,
    email_address character varying(50),
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.email_address OWNER TO postgres;


CREATE SEQUENCE db.emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.emailaddress_emailaddressid_seq OWNER TO postgres;


ALTER SEQUENCE db.emailaddress_emailaddressid_seq OWNED BY db.email_address.email_address_id;



CREATE TABLE db.employee_department_history (
    business_entity_id integer NOT NULL,
    department_id smallint NOT NULL,
    shift_id smallint NOT NULL,
    start_date date NOT NULL,
    end_date date,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL)))
);


ALTER TABLE db.employee_department_history OWNER TO postgres;


CREATE TABLE db.employee_pay_history (
    business_entity_id integer NOT NULL,
    rate_change_date timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    pay_frequency smallint NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((pay_frequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);


ALTER TABLE db.employee_pay_history OWNER TO postgres;


CREATE TABLE db.illustration (
    illustration_id integer NOT NULL,
    diagram xml,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.illustration OWNER TO postgres;


CREATE SEQUENCE db.illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.illustration_illustrationid_seq OWNER TO postgres;


ALTER SEQUENCE db.illustration_illustrationid_seq OWNED BY db.illustration.illustration_id;



CREATE TABLE db.job_candidate (
    job_candidate_id integer NOT NULL,
    business_entity_id integer,
    resume xml,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.job_candidate OWNER TO postgres;


CREATE SEQUENCE db.jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.jobcandidate_jobcandidateid_seq OWNER TO postgres;


ALTER SEQUENCE db.jobcandidate_jobcandidateid_seq OWNED BY db.job_candidate.job_candidate_id;



CREATE TABLE db.location (
    location_id integer NOT NULL,
    cost_rate numeric DEFAULT 0.00 NOT NULL,
    availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((cost_rate >= 0.00))
);


ALTER TABLE db.location OWNER TO postgres;


CREATE SEQUENCE db.location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.location_locationid_seq OWNER TO postgres;


ALTER SEQUENCE db.location_locationid_seq OWNED BY db.location.location_id;



CREATE TABLE db.password (
    business_entity_id integer NOT NULL,
    password_hash character varying(128) NOT NULL,
    password_salt character varying(10) NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.password OWNER TO postgres;


CREATE TABLE db.person (
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


ALTER TABLE db.person OWNER TO postgres;


CREATE TABLE db.person_credit_card (
    business_entity_id integer NOT NULL,
    credit_card_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.person_credit_card OWNER TO postgres;


CREATE TABLE db.person_phone (
    business_entity_id integer NOT NULL,
    phone_number_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.person_phone OWNER TO postgres;


CREATE TABLE db.phone_number_type (
    phone_number_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.phone_number_type OWNER TO postgres;


CREATE SEQUENCE db.phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.phonenumbertype_phonenumbertypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.phonenumbertype_phonenumbertypeid_seq OWNED BY db.phone_number_type.phone_number_type_id;



CREATE TABLE db.product (
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


ALTER TABLE db.product OWNER TO postgres;


CREATE TABLE db.product_category (
    product_category_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_category OWNER TO postgres;


CREATE TABLE db.product_cost_history (
    product_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    standard_cost numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standard_cost >= 0.00))
);


ALTER TABLE db.product_cost_history OWNER TO postgres;


CREATE TABLE db.product_description (
    product_description_id integer NOT NULL,
    description character varying(400) NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_description OWNER TO postgres;


CREATE TABLE db.product_document (
    product_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    document_node character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE db.product_document OWNER TO postgres;


CREATE TABLE db.product_inventory (
    product_id integer NOT NULL,
    location_id smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE db.product_inventory OWNER TO postgres;


CREATE TABLE db.product_list_price_history (
    product_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    list_price numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((list_price > 0.00))
);


ALTER TABLE db.product_list_price_history OWNER TO postgres;


CREATE TABLE db.product_model (
    product_model_id integer NOT NULL,
    catalog_description xml,
    instructions xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_model OWNER TO postgres;


CREATE TABLE db.product_model_illustration (
    product_model_id integer NOT NULL,
    illustration_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_model_illustration OWNER TO postgres;


CREATE TABLE db.product_model_product_description_culture (
    product_model_id integer NOT NULL,
    product_description_id integer NOT NULL,
    culture_id character(6) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_model_product_description_culture OWNER TO postgres;


CREATE TABLE db.product_photo (
    product_photo_id integer NOT NULL,
    thumbnail_photo bytea,
    thumbnail_photo_file_name character varying(50),
    large_photo bytea,
    large_photo_file_name character varying(50),
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_photo OWNER TO postgres;


CREATE TABLE db.product_product_photo (
    product_id integer NOT NULL,
    product_photo_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_product_photo OWNER TO postgres;


CREATE SEQUENCE db.product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.product_productid_seq OWNER TO postgres;


ALTER SEQUENCE db.product_productid_seq OWNED BY db.product.product_id;



CREATE TABLE db.product_review (
    product_review_id integer NOT NULL,
    product_id integer NOT NULL,
    review_date timestamp without time zone DEFAULT now() NOT NULL,
    email_address character varying(50) NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850),
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE db.product_review OWNER TO postgres;


CREATE TABLE db.product_subcategory (
    product_subcategory_id integer NOT NULL,
    product_category_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_subcategory OWNER TO postgres;


CREATE TABLE db.product_vendor (
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


ALTER TABLE db.product_vendor OWNER TO postgres;


CREATE SEQUENCE db.productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productcategory_productcategoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.productcategory_productcategoryid_seq OWNED BY db.product_category.product_category_id;



CREATE SEQUENCE db.productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productdescription_productdescriptionid_seq OWNER TO postgres;


ALTER SEQUENCE db.productdescription_productdescriptionid_seq OWNED BY db.product_description.product_description_id;



CREATE SEQUENCE db.productmodel_productmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productmodel_productmodelid_seq OWNER TO postgres;


ALTER SEQUENCE db.productmodel_productmodelid_seq OWNED BY db.product_model.product_model_id;



CREATE SEQUENCE db.productphoto_productphotoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productphoto_productphotoid_seq OWNER TO postgres;


ALTER SEQUENCE db.productphoto_productphotoid_seq OWNED BY db.product_photo.product_photo_id;



CREATE SEQUENCE db.productreview_productreviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productreview_productreviewid_seq OWNER TO postgres;


ALTER SEQUENCE db.productreview_productreviewid_seq OWNED BY db.product_review.product_review_id;



CREATE SEQUENCE db.productsubcategory_productsubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productsubcategory_productsubcategoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.productsubcategory_productsubcategoryid_seq OWNED BY db.product_subcategory.product_subcategory_id;



CREATE TABLE db.purchase_order_detail (
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


ALTER TABLE db.purchase_order_detail OWNER TO postgres;


CREATE TABLE db.purchase_order_header (
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


ALTER TABLE db.purchase_order_header OWNER TO postgres;


CREATE SEQUENCE db.purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.purchaseorderdetail_purchaseorderdetailid_seq OWNER TO postgres;


ALTER SEQUENCE db.purchaseorderdetail_purchaseorderdetailid_seq OWNED BY db.purchase_order_detail.purchase_order_detail_id;



CREATE SEQUENCE db.purchaseorderheader_purchaseorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.purchaseorderheader_purchaseorderid_seq OWNER TO postgres;


ALTER SEQUENCE db.purchaseorderheader_purchaseorderid_seq OWNED BY db.purchase_order_header.purchase_order_id;



CREATE TABLE db.sales_order_detail (
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


ALTER TABLE db.sales_order_detail OWNER TO postgres;


CREATE TABLE db.sales_order_header (
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


ALTER TABLE db.sales_order_header OWNER TO postgres;


CREATE TABLE db.sales_order_header_sales_reason (
    sales_order_id integer NOT NULL,
    sales_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.sales_order_header_sales_reason OWNER TO postgres;


CREATE TABLE db.sales_person (
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


ALTER TABLE db.sales_person OWNER TO postgres;


CREATE TABLE db.sales_person_quota_history (
    business_entity_id integer NOT NULL,
    quota_date timestamp without time zone NOT NULL,
    sales_quota numeric NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((sales_quota > 0.00))
);


ALTER TABLE db.sales_person_quota_history OWNER TO postgres;


CREATE TABLE db.sales_reason (
    sales_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.sales_reason OWNER TO postgres;


CREATE TABLE db.sales_tax_rate (
    sales_tax_rate_id integer NOT NULL,
    state_province_id integer NOT NULL,
    tax_type smallint NOT NULL,
    tax_rate numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((tax_type >= 1) AND (tax_type <= 3)))
);


ALTER TABLE db.sales_tax_rate OWNER TO postgres;


CREATE TABLE db.sales_territory (
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


ALTER TABLE db.sales_territory OWNER TO postgres;


CREATE TABLE db.sales_territory_history (
    business_entity_id integer NOT NULL,
    territory_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL)))
);


ALTER TABLE db.sales_territory_history OWNER TO postgres;


CREATE SEQUENCE db.salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.salesorderdetail_salesorderdetailid_seq OWNER TO postgres;


ALTER SEQUENCE db.salesorderdetail_salesorderdetailid_seq OWNED BY db.sales_order_detail.sales_order_detail_id;



CREATE SEQUENCE db.salesorderheader_salesorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.salesorderheader_salesorderid_seq OWNER TO postgres;


ALTER SEQUENCE db.salesorderheader_salesorderid_seq OWNED BY db.sales_order_header.sales_order_id;



CREATE SEQUENCE db.salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.salesreason_salesreasonid_seq OWNER TO postgres;


ALTER SEQUENCE db.salesreason_salesreasonid_seq OWNED BY db.sales_reason.sales_reason_id;



CREATE SEQUENCE db.salestaxrate_salestaxrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.salestaxrate_salestaxrateid_seq OWNER TO postgres;


ALTER SEQUENCE db.salestaxrate_salestaxrateid_seq OWNED BY db.sales_tax_rate.sales_tax_rate_id;



CREATE SEQUENCE db.salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.salesterritory_territoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.salesterritory_territoryid_seq OWNED BY db.sales_territory.territory_id;



CREATE TABLE db.scrap_reason (
    scrap_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.scrap_reason OWNER TO postgres;


CREATE SEQUENCE db.scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.scrapreason_scrapreasonid_seq OWNER TO postgres;


ALTER SEQUENCE db.scrapreason_scrapreasonid_seq OWNED BY db.scrap_reason.scrap_reason_id;



CREATE TABLE db.shift (
    shift_id integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.shift OWNER TO postgres;


CREATE TABLE db.ship_method (
    ship_method_id integer NOT NULL,
    ship_base numeric DEFAULT 0.00 NOT NULL,
    ship_rate numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((ship_base > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((ship_rate > 0.00))
);


ALTER TABLE db.ship_method OWNER TO postgres;


CREATE SEQUENCE db.shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.shipmethod_shipmethodid_seq OWNER TO postgres;


ALTER SEQUENCE db.shipmethod_shipmethodid_seq OWNED BY db.ship_method.ship_method_id;



CREATE TABLE db.shopping_cart_item (
    shopping_cart_item_id integer NOT NULL,
    shopping_cart_id character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    product_id integer NOT NULL,
    date_created timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);


ALTER TABLE db.shopping_cart_item OWNER TO postgres;


CREATE SEQUENCE db.shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.shoppingcartitem_shoppingcartitemid_seq OWNER TO postgres;


ALTER SEQUENCE db.shoppingcartitem_shoppingcartitemid_seq OWNED BY db.shopping_cart_item.shopping_cart_item_id;



CREATE TABLE db.special_offer (
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


ALTER TABLE db.special_offer OWNER TO postgres;


CREATE TABLE db.special_offer_product (
    special_offer_id integer NOT NULL,
    product_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.special_offer_product OWNER TO postgres;


CREATE SEQUENCE db.specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.specialoffer_specialofferid_seq OWNER TO postgres;


ALTER SEQUENCE db.specialoffer_specialofferid_seq OWNED BY db.special_offer.special_offer_id;



CREATE TABLE db.state_province (
    state_province_id integer NOT NULL,
    state_province_code character(3) NOT NULL,
    country_region_code character varying(3) NOT NULL,
    territory_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.state_province OWNER TO postgres;


CREATE SEQUENCE db.stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.stateprovince_stateprovinceid_seq OWNER TO postgres;


ALTER SEQUENCE db.stateprovince_stateprovinceid_seq OWNED BY db.state_province.state_province_id;



CREATE TABLE db.store (
    business_entity_id integer NOT NULL,
    sales_person_id integer,
    demographics xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.store OWNER TO postgres;


CREATE TABLE db.transaction_history (
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


ALTER TABLE db.transaction_history OWNER TO postgres;


CREATE TABLE db.transaction_history_archive (
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


ALTER TABLE db.transaction_history_archive OWNER TO postgres;


CREATE SEQUENCE db.transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.transactionhistory_transactionid_seq OWNER TO postgres;


ALTER SEQUENCE db.transactionhistory_transactionid_seq OWNED BY db.transaction_history.transaction_id;



CREATE TABLE db.unit_measure (
    unit_measure_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.unit_measure OWNER TO postgres;


CREATE TABLE db.vendor (
    business_entity_id integer NOT NULL,
    credit_rating smallint NOT NULL,
    purchasing_web_service_url character varying(1024),
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((credit_rating >= 1) AND (credit_rating <= 5)))
);


ALTER TABLE db.vendor OWNER TO postgres;


CREATE TABLE db.work_order (
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


ALTER TABLE db.work_order OWNER TO postgres;


CREATE TABLE db.work_order_routing (
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


ALTER TABLE db.work_order_routing OWNER TO postgres;


CREATE SEQUENCE db.workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.workorder_workorderid_seq OWNER TO postgres;


ALTER SEQUENCE db.workorder_workorderid_seq OWNED BY db.work_order.work_order_id;



ALTER TABLE ONLY db.address ALTER COLUMN address_id SET DEFAULT nextval('db.address_addressid_seq'::regclass);



ALTER TABLE ONLY db.address_type ALTER COLUMN address_type_id SET DEFAULT nextval('db.addresstype_addresstypeid_seq'::regclass);



ALTER TABLE ONLY db.bill_of_materials ALTER COLUMN bill_of_materials_id SET DEFAULT nextval('db.billofmaterials_billofmaterialsid_seq'::regclass);



ALTER TABLE ONLY db.business_entity ALTER COLUMN business_entity_id SET DEFAULT nextval('db.businessentity_businessentityid_seq'::regclass);



ALTER TABLE ONLY db.contact_type ALTER COLUMN contact_type_id SET DEFAULT nextval('db.contacttype_contacttypeid_seq'::regclass);



ALTER TABLE ONLY db.credit_card ALTER COLUMN credit_card_id SET DEFAULT nextval('db.creditcard_creditcardid_seq'::regclass);



ALTER TABLE ONLY db.currency_rate ALTER COLUMN currency_rate_id SET DEFAULT nextval('db.currencyrate_currencyrateid_seq'::regclass);



ALTER TABLE ONLY db.customer ALTER COLUMN customer_id SET DEFAULT nextval('db.customer_customerid_seq'::regclass);



ALTER TABLE ONLY db.email_address ALTER COLUMN email_address_id SET DEFAULT nextval('db.emailaddress_emailaddressid_seq'::regclass);



ALTER TABLE ONLY db.illustration ALTER COLUMN illustration_id SET DEFAULT nextval('db.illustration_illustrationid_seq'::regclass);



ALTER TABLE ONLY db.job_candidate ALTER COLUMN job_candidate_id SET DEFAULT nextval('db.jobcandidate_jobcandidateid_seq'::regclass);



ALTER TABLE ONLY db.location ALTER COLUMN location_id SET DEFAULT nextval('db.location_locationid_seq'::regclass);



ALTER TABLE ONLY db.phone_number_type ALTER COLUMN phone_number_type_id SET DEFAULT nextval('db.phonenumbertype_phonenumbertypeid_seq'::regclass);



ALTER TABLE ONLY db.product ALTER COLUMN product_id SET DEFAULT nextval('db.product_productid_seq'::regclass);



ALTER TABLE ONLY db.product_category ALTER COLUMN product_category_id SET DEFAULT nextval('db.productcategory_productcategoryid_seq'::regclass);



ALTER TABLE ONLY db.product_description ALTER COLUMN product_description_id SET DEFAULT nextval('db.productdescription_productdescriptionid_seq'::regclass);



ALTER TABLE ONLY db.product_model ALTER COLUMN product_model_id SET DEFAULT nextval('db.productmodel_productmodelid_seq'::regclass);



ALTER TABLE ONLY db.product_photo ALTER COLUMN product_photo_id SET DEFAULT nextval('db.productphoto_productphotoid_seq'::regclass);



ALTER TABLE ONLY db.product_review ALTER COLUMN product_review_id SET DEFAULT nextval('db.productreview_productreviewid_seq'::regclass);



ALTER TABLE ONLY db.product_subcategory ALTER COLUMN product_subcategory_id SET DEFAULT nextval('db.productsubcategory_productsubcategoryid_seq'::regclass);



ALTER TABLE ONLY db.purchase_order_detail ALTER COLUMN purchase_order_detail_id SET DEFAULT nextval('db.purchaseorderdetail_purchaseorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.purchase_order_header ALTER COLUMN purchase_order_id SET DEFAULT nextval('db.purchaseorderheader_purchaseorderid_seq'::regclass);



ALTER TABLE ONLY db.sales_order_detail ALTER COLUMN sales_order_detail_id SET DEFAULT nextval('db.salesorderdetail_salesorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.sales_order_header ALTER COLUMN sales_order_id SET DEFAULT nextval('db.salesorderheader_salesorderid_seq'::regclass);



ALTER TABLE ONLY db.sales_reason ALTER COLUMN sales_reason_id SET DEFAULT nextval('db.salesreason_salesreasonid_seq'::regclass);



ALTER TABLE ONLY db.sales_tax_rate ALTER COLUMN sales_tax_rate_id SET DEFAULT nextval('db.salestaxrate_salestaxrateid_seq'::regclass);



ALTER TABLE ONLY db.sales_territory ALTER COLUMN territory_id SET DEFAULT nextval('db.salesterritory_territoryid_seq'::regclass);



ALTER TABLE ONLY db.scrap_reason ALTER COLUMN scrap_reason_id SET DEFAULT nextval('db.scrapreason_scrapreasonid_seq'::regclass);



ALTER TABLE ONLY db.ship_method ALTER COLUMN ship_method_id SET DEFAULT nextval('db.shipmethod_shipmethodid_seq'::regclass);



ALTER TABLE ONLY db.shopping_cart_item ALTER COLUMN shopping_cart_item_id SET DEFAULT nextval('db.shoppingcartitem_shoppingcartitemid_seq'::regclass);



ALTER TABLE ONLY db.special_offer ALTER COLUMN special_offer_id SET DEFAULT nextval('db.specialoffer_specialofferid_seq'::regclass);



ALTER TABLE ONLY db.state_province ALTER COLUMN state_province_id SET DEFAULT nextval('db.stateprovince_stateprovinceid_seq'::regclass);



ALTER TABLE ONLY db.transaction_history ALTER COLUMN transaction_id SET DEFAULT nextval('db.transactionhistory_transactionid_seq'::regclass);



ALTER TABLE ONLY db.work_order ALTER COLUMN work_order_id SET DEFAULT nextval('db.workorder_workorderid_seq'::regclass);



ALTER TABLE ONLY db.address_type
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (address_type_id);

ALTER TABLE db.address_type CLUSTER ON "PK_AddressType_AddressTypeID";



ALTER TABLE ONLY db.address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (address_id);

ALTER TABLE db.address CLUSTER ON "PK_Address_AddressID";



ALTER TABLE ONLY db.bill_of_materials
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (bill_of_materials_id);



ALTER TABLE ONLY db.business_entity_address
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (business_entity_id, address_id, address_type_id);

ALTER TABLE db.business_entity_address CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";



ALTER TABLE ONLY db.business_entity_contact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (business_entity_id, person_id, contact_type_id);

ALTER TABLE db.business_entity_contact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";



ALTER TABLE ONLY db.business_entity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.business_entity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";



ALTER TABLE ONLY db.contact_type
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contact_type_id);

ALTER TABLE db.contact_type CLUSTER ON "PK_ContactType_ContactTypeID";



ALTER TABLE ONLY db.country_region_currency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (country_region_code, currency_code);

ALTER TABLE db.country_region_currency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";



ALTER TABLE ONLY db.country_region
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (country_region_code);

ALTER TABLE db.country_region CLUSTER ON "PK_CountryRegion_CountryRegionCode";



ALTER TABLE ONLY db.credit_card
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (credit_card_id);

ALTER TABLE db.credit_card CLUSTER ON "PK_CreditCard_CreditCardID";



ALTER TABLE ONLY db.culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (culture_id);

ALTER TABLE db.culture CLUSTER ON "PK_Culture_CultureID";



ALTER TABLE ONLY db.currency_rate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currency_rate_id);

ALTER TABLE db.currency_rate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";



ALTER TABLE ONLY db.currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currency_code);

ALTER TABLE db.currency CLUSTER ON "PK_Currency_CurrencyCode";



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customer_id);

ALTER TABLE db.customer CLUSTER ON "PK_Customer_CustomerID";



ALTER TABLE ONLY db.department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (department_id);

ALTER TABLE db.department CLUSTER ON "PK_Department_DepartmentID";



ALTER TABLE ONLY db.document
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (document_node);

ALTER TABLE db.document CLUSTER ON "PK_Document_DocumentNode";



ALTER TABLE ONLY db.email_address
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (business_entity_id, email_address_id);

ALTER TABLE db.email_address CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";



ALTER TABLE ONLY db.employee_department_history
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (business_entity_id, start_date, department_id, shift_id);

ALTER TABLE db.employee_department_history CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";



ALTER TABLE ONLY db.employee_pay_history
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (business_entity_id, rate_change_date);

ALTER TABLE db.employee_pay_history CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";



ALTER TABLE ONLY db.illustration
    ADD CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illustration_id);

ALTER TABLE db.illustration CLUSTER ON "PK_Illustration_IllustrationID";



ALTER TABLE ONLY db.job_candidate
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (job_candidate_id);

ALTER TABLE db.job_candidate CLUSTER ON "PK_JobCandidate_JobCandidateID";



ALTER TABLE ONLY db.location
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (location_id);

ALTER TABLE db.location CLUSTER ON "PK_Location_LocationID";



ALTER TABLE ONLY db.password
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.password CLUSTER ON "PK_Password_BusinessEntityID";



ALTER TABLE ONLY db.person_credit_card
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (business_entity_id, credit_card_id);

ALTER TABLE db.person_credit_card CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";



ALTER TABLE ONLY db.person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.person CLUSTER ON "PK_Person_BusinessEntityID";



ALTER TABLE ONLY db.phone_number_type
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phone_number_type_id);

ALTER TABLE db.phone_number_type CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";



ALTER TABLE ONLY db.product_category
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (product_category_id);

ALTER TABLE db.product_category CLUSTER ON "PK_ProductCategory_ProductCategoryID";



ALTER TABLE ONLY db.product_cost_history
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (product_id, start_date);

ALTER TABLE db.product_cost_history CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";



ALTER TABLE ONLY db.product_description
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (product_description_id);

ALTER TABLE db.product_description CLUSTER ON "PK_ProductDescription_ProductDescriptionID";



ALTER TABLE ONLY db.product_document
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (product_id, document_node);

ALTER TABLE db.product_document CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";



ALTER TABLE ONLY db.product_inventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (product_id, location_id);

ALTER TABLE db.product_inventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";



ALTER TABLE ONLY db.product_list_price_history
    ADD CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY (product_id, start_date);

ALTER TABLE db.product_list_price_history CLUSTER ON "PK_ProductListPriceHistory_ProductID_StartDate";



ALTER TABLE ONLY db.product_model_illustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (product_model_id, illustration_id);

ALTER TABLE db.product_model_illustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";



ALTER TABLE ONLY db.product_model_product_description_culture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (product_model_id, product_description_id, culture_id);

ALTER TABLE db.product_model_product_description_culture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";



ALTER TABLE ONLY db.product_model
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (product_model_id);

ALTER TABLE db.product_model CLUSTER ON "PK_ProductModel_ProductModelID";



ALTER TABLE ONLY db.product_photo
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (product_photo_id);

ALTER TABLE db.product_photo CLUSTER ON "PK_ProductPhoto_ProductPhotoID";



ALTER TABLE ONLY db.product_product_photo
    ADD CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY (product_id, product_photo_id);



ALTER TABLE ONLY db.product_review
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (product_review_id);

ALTER TABLE db.product_review CLUSTER ON "PK_ProductReview_ProductReviewID";



ALTER TABLE ONLY db.product_subcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (product_subcategory_id);

ALTER TABLE db.product_subcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";



ALTER TABLE ONLY db.product_vendor
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (product_id, business_entity_id);

ALTER TABLE db.product_vendor CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (product_id);

ALTER TABLE db.product CLUSTER ON "PK_Product_ProductID";



ALTER TABLE ONLY db.purchase_order_detail
    ADD CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (purchase_order_id, purchase_order_detail_id);

ALTER TABLE db.purchase_order_detail CLUSTER ON "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";



ALTER TABLE ONLY db.purchase_order_header
    ADD CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (purchase_order_id);

ALTER TABLE db.purchase_order_header CLUSTER ON "PK_PurchaseOrderHeader_PurchaseOrderID";



ALTER TABLE ONLY db.sales_order_detail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (sales_order_id, sales_order_detail_id);

ALTER TABLE db.sales_order_detail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";



ALTER TABLE ONLY db.sales_order_header_sales_reason
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (sales_order_id, sales_reason_id);

ALTER TABLE db.sales_order_header_sales_reason CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (sales_order_id);

ALTER TABLE db.sales_order_header CLUSTER ON "PK_SalesOrderHeader_SalesOrderID";



ALTER TABLE ONLY db.sales_person_quota_history
    ADD CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (business_entity_id, quota_date);

ALTER TABLE db.sales_person_quota_history CLUSTER ON "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";



ALTER TABLE ONLY db.sales_person
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.sales_person CLUSTER ON "PK_SalesPerson_BusinessEntityID";



ALTER TABLE ONLY db.sales_reason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (sales_reason_id);

ALTER TABLE db.sales_reason CLUSTER ON "PK_SalesReason_SalesReasonID";



ALTER TABLE ONLY db.sales_tax_rate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (sales_tax_rate_id);

ALTER TABLE db.sales_tax_rate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";



ALTER TABLE ONLY db.sales_territory_history
    ADD CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (business_entity_id, start_date, territory_id);

ALTER TABLE db.sales_territory_history CLUSTER ON "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";



ALTER TABLE ONLY db.sales_territory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territory_id);

ALTER TABLE db.sales_territory CLUSTER ON "PK_SalesTerritory_TerritoryID";



ALTER TABLE ONLY db.scrap_reason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrap_reason_id);

ALTER TABLE db.scrap_reason CLUSTER ON "PK_ScrapReason_ScrapReasonID";



ALTER TABLE ONLY db.shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shift_id);

ALTER TABLE db.shift CLUSTER ON "PK_Shift_ShiftID";



ALTER TABLE ONLY db.ship_method
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (ship_method_id);

ALTER TABLE db.ship_method CLUSTER ON "PK_ShipMethod_ShipMethodID";



ALTER TABLE ONLY db.shopping_cart_item
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shopping_cart_item_id);

ALTER TABLE db.shopping_cart_item CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";



ALTER TABLE ONLY db.special_offer_product
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (special_offer_id, product_id);

ALTER TABLE db.special_offer_product CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";



ALTER TABLE ONLY db.special_offer
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (special_offer_id);

ALTER TABLE db.special_offer CLUSTER ON "PK_SpecialOffer_SpecialOfferID";



ALTER TABLE ONLY db.state_province
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (state_province_id);

ALTER TABLE db.state_province CLUSTER ON "PK_StateProvince_StateProvinceID";



ALTER TABLE ONLY db.store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.store CLUSTER ON "PK_Store_BusinessEntityID";



ALTER TABLE ONLY db.transaction_history_archive
    ADD CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE db.transaction_history_archive CLUSTER ON "PK_TransactionHistoryArchive_TransactionID";



ALTER TABLE ONLY db.transaction_history
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE db.transaction_history CLUSTER ON "PK_TransactionHistory_TransactionID";



ALTER TABLE ONLY db.unit_measure
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unit_measure_code);

ALTER TABLE db.unit_measure CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";



ALTER TABLE ONLY db.vendor
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.vendor CLUSTER ON "PK_Vendor_BusinessEntityID";



ALTER TABLE ONLY db.work_order_routing
    ADD CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY (work_order_id, product_id, operation_sequence);

ALTER TABLE db.work_order_routing CLUSTER ON "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence";



ALTER TABLE ONLY db.work_order
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (work_order_id);

ALTER TABLE db.work_order CLUSTER ON "PK_WorkOrder_WorkOrderID";



ALTER TABLE ONLY db.document
    ADD CONSTRAINT document_rowguid_key UNIQUE (row_guid);



ALTER TABLE ONLY db.address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (state_province_id) REFERENCES db.state_province(state_province_id);



ALTER TABLE ONLY db.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (component_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (product_assembly_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES db.unit_measure(unit_measure_code);



ALTER TABLE ONLY db.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (address_type_id) REFERENCES db.address_type(address_type_id);



ALTER TABLE ONLY db.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (address_id) REFERENCES db.address(address_id);



ALTER TABLE ONLY db.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.business_entity(business_entity_id);



ALTER TABLE ONLY db.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.business_entity(business_entity_id);



ALTER TABLE ONLY db.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (contact_type_id) REFERENCES db.contact_type(contact_type_id);



ALTER TABLE ONLY db.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (person_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.country_region(country_region_code);



ALTER TABLE ONLY db.country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currency_code) REFERENCES db.currency(currency_code);



ALTER TABLE ONLY db.currency_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (from_currency_code) REFERENCES db.currency(currency_code);



ALTER TABLE ONLY db.currency_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (to_currency_code) REFERENCES db.currency(currency_code);



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (person_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.sales_territory(territory_id);



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (store_id) REFERENCES db.store(business_entity_id);



ALTER TABLE ONLY db.email_address
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (department_id) REFERENCES db.department(department_id);



ALTER TABLE ONLY db.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shift_id) REFERENCES db.shift(shift_id);



ALTER TABLE ONLY db.password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (credit_card_id) REFERENCES db.credit_card(credit_card_id);



ALTER TABLE ONLY db.person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.person_phone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.person_phone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phone_number_type_id) REFERENCES db.phone_number_type(phone_number_type_id);



ALTER TABLE ONLY db.person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.business_entity(business_entity_id);



ALTER TABLE ONLY db.product_cost_history
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_document
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (document_node) REFERENCES db.document(document_node);



ALTER TABLE ONLY db.product_document
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (location_id) REFERENCES db.location(location_id);



ALTER TABLE ONLY db.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_list_price_history
    ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustration_id) REFERENCES db.illustration(illustration_id);



ALTER TABLE ONLY db.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES db.product_model(product_model_id);



ALTER TABLE ONLY db.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (culture_id) REFERENCES db.culture(culture_id);



ALTER TABLE ONLY db.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (product_description_id) REFERENCES db.product_description(product_description_id);



ALTER TABLE ONLY db.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (product_model_id) REFERENCES db.product_model(product_model_id);



ALTER TABLE ONLY db.product_product_photo
    ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY (product_photo_id) REFERENCES db.product_photo(product_photo_id);



ALTER TABLE ONLY db.product_product_photo
    ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_subcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (product_category_id) REFERENCES db.product_category(product_category_id);



ALTER TABLE ONLY db.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES db.unit_measure(unit_measure_code);



ALTER TABLE ONLY db.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.vendor(business_entity_id);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES db.product_model(product_model_id);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (product_subcategory_id) REFERENCES db.product_subcategory(product_subcategory_id);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (size_unit_measure_code) REFERENCES db.unit_measure(unit_measure_code);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weight_unit_measure_code) REFERENCES db.unit_measure(unit_measure_code);



ALTER TABLE ONLY db.purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (purchase_order_id) REFERENCES db.purchase_order_header(purchase_order_id);



ALTER TABLE ONLY db.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (ship_method_id) REFERENCES db.ship_method(ship_method_id);



ALTER TABLE ONLY db.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (vendor_id) REFERENCES db.vendor(business_entity_id);



ALTER TABLE ONLY db.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (sales_order_id) REFERENCES db.sales_order_header(sales_order_id) ON DELETE CASCADE;



ALTER TABLE ONLY db.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (special_offer_id, product_id) REFERENCES db.special_offer_product(special_offer_id, product_id);



ALTER TABLE ONLY db.sales_order_header_sales_reason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (sales_order_id) REFERENCES db.sales_order_header(sales_order_id) ON DELETE CASCADE;



ALTER TABLE ONLY db.sales_order_header_sales_reason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (sales_reason_id) REFERENCES db.sales_reason(sales_reason_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (bill_to_address_id) REFERENCES db.address(address_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (ship_to_address_id) REFERENCES db.address(address_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (credit_card_id) REFERENCES db.credit_card(credit_card_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY (currency_rate_id) REFERENCES db.currency_rate(currency_rate_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY (customer_id) REFERENCES db.customer(customer_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (sales_person_id) REFERENCES db.sales_person(business_entity_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.sales_territory(territory_id);



ALTER TABLE ONLY db.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (ship_method_id) REFERENCES db.ship_method(ship_method_id);



ALTER TABLE ONLY db.sales_person_quota_history
    ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.sales_person(business_entity_id);



ALTER TABLE ONLY db.sales_person
    ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.sales_territory(territory_id);



ALTER TABLE ONLY db.sales_tax_rate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (state_province_id) REFERENCES db.state_province(state_province_id);



ALTER TABLE ONLY db.sales_territory_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.sales_person(business_entity_id);



ALTER TABLE ONLY db.sales_territory_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.sales_territory(territory_id);



ALTER TABLE ONLY db.sales_territory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.country_region(country_region_code);



ALTER TABLE ONLY db.shopping_cart_item
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.special_offer_product
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.special_offer_product
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (special_offer_id) REFERENCES db.special_offer(special_offer_id);



ALTER TABLE ONLY db.state_province
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.country_region(country_region_code);



ALTER TABLE ONLY db.state_province
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.sales_territory(territory_id);



ALTER TABLE ONLY db.store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.business_entity(business_entity_id);



ALTER TABLE ONLY db.store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (sales_person_id) REFERENCES db.sales_person(business_entity_id);



ALTER TABLE ONLY db.transaction_history
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.vendor
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.business_entity(business_entity_id);



ALTER TABLE ONLY db.work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (location_id) REFERENCES db.location(location_id);



ALTER TABLE ONLY db.work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (work_order_id) REFERENCES db.work_order(work_order_id);



ALTER TABLE ONLY db.work_order
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.work_order
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrap_reason_id) REFERENCES db.scrap_reason(scrap_reason_id);



