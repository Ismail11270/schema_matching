

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


CREATE TABLE db.ads (
    ads_id integer NOT NULL,
    street_name_1 character varying(60) NOT NULL,
    city character varying(30) NOT NULL,
    zip_code character varying(15) NOT NULL,
    geo_location character varying(44),
    row_guid uuid NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.ads OWNER TO postgres;


CREATE SEQUENCE db.address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.address_addressid_seq OWNER TO postgres;


ALTER SEQUENCE db.address_addressid_seq OWNED BY db.ads.ads_id;



CREATE TABLE db.ads_typ (
    ads_typ_id integer NOT NULL,
    row_guid uuid NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.ads_typ OWNER TO postgres;


CREATE SEQUENCE db.addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.addresstype_addresstypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.addresstype_addresstypeid_seq OWNED BY db.ads_typ.ads_typ_id;



CREATE TABLE db.applicant_for_job (
    applicant_for_job_id integer NOT NULL,
    busin_entity_id integer,
    cv xml,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.applicant_for_job OWNER TO postgres;


CREATE TABLE db.area (
    lct_id integer NOT NULL,
    cost_rate numeric DEFAULT 0.00 NOT NULL,
    avail numeric(8,2) DEFAULT 0.00 NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((avail >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((cost_rate >= 0.00))
);


ALTER TABLE db.area OWNER TO postgres;


CREATE TABLE db.b_details (
    b_details_id integer NOT NULL,
    end_date timestamp without time zone NOT NULL,
    quantity_order smallint NOT NULL,
    product_id integer NOT NULL,
    unit_price numeric NOT NULL,
    quantity_received numeric(8,2) NOT NULL,
    quantity_rejected numeric(8,2) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK ((quantity_order > 0)),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK ((quantity_received >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK ((quantity_rejected >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK ((unit_price >= 0.00))
);


ALTER TABLE db.b_details OWNER TO postgres;


CREATE TABLE db.materials_bills (
    bill_of_materials_id integer NOT NULL,
    product_assembly_id integer,
    compnt_id integer NOT NULL,
    start_date timestamp without time zone DEFAULT now() NOT NULL,
    end_date timestamp without time zone,
    unit_measure_code character(3) NOT NULL,
    bom_level smallint NOT NULL,
    per_assembly_qty numeric(8,2) DEFAULT 1.00 NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK ((((product_assembly_id IS NULL) AND (bom_level = 0) AND (per_assembly_qty = 1.00)) OR ((product_assembly_id IS NOT NULL) AND (bom_level >= 1)))),
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (((end_date > start_date) OR (end_date IS NULL))),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK ((per_assembly_qty >= 1.00)),
    CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK ((product_assembly_id <> compnt_id))
);


ALTER TABLE db.materials_bills OWNER TO postgres;


CREATE SEQUENCE db.billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.billofmaterials_billofmaterialsid_seq OWNER TO postgres;


ALTER SEQUENCE db.billofmaterials_billofmaterialsid_seq OWNED BY db.materials_bills.bill_of_materials_id;



CREATE TABLE db.busi_enty (
    busi_enty_id integer NOT NULL,
    row_guid uuid NOT NULL,
    date_modified timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.busi_enty OWNER TO postgres;


CREATE TABLE db.busi_enty_ads (
    busi_enty_id integer NOT NULL,
    ads_id integer NOT NULL,
    ads_typ_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.busi_enty_ads OWNER TO postgres;


CREATE TABLE db.busi_enty_contc (
    busi_enty_id integer NOT NULL,
    person_id integer NOT NULL,
    type_contact_id integer NOT NULL
);


ALTER TABLE db.busi_enty_contc OWNER TO postgres;


CREATE SEQUENCE db.businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.businessentity_businessentityid_seq OWNER TO postgres;


ALTER SEQUENCE db.businessentity_businessentityid_seq OWNED BY db.busi_enty.busi_enty_id;



CREATE TABLE db.buyer (
    busi_enty_id integer NOT NULL,
    credit_rate smallint NOT NULL,
    website_url character varying(1024),
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((credit_rate >= 1) AND (credit_rate <= 5)))
);


ALTER TABLE db.buyer OWNER TO postgres;


CREATE TABLE db.cont_typ (
    cont_typ_id integer NOT NULL
);


ALTER TABLE db.cont_typ OWNER TO postgres;


CREATE SEQUENCE db.contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.contacttype_contacttypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.contacttype_contacttypeid_seq OWNED BY db.cont_typ.cont_typ_id;



CREATE TABLE db.country_currency (
    country_code character varying(3) NOT NULL,
    currency_code character(3) NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.country_currency OWNER TO postgres;


CREATE TABLE db.country_region (
    country_code character varying(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.country_region OWNER TO postgres;


CREATE TABLE db.payment_card (
    card_id integer NOT NULL,
    card_typ character varying(50) NOT NULL,
    card_num character varying(25) NOT NULL,
    expire_month smallint NOT NULL,
    expire_year smallint NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.payment_card OWNER TO postgres;


CREATE SEQUENCE db.creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.creditcard_creditcardid_seq OWNER TO postgres;


ALTER SEQUENCE db.creditcard_creditcardid_seq OWNED BY db.payment_card.card_id;



CREATE TABLE db.culture (
    culture_id character(6) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.culture OWNER TO postgres;


CREATE TABLE db.currency (
    currency_code character(3) NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.currency OWNER TO postgres;


CREATE TABLE db.currency_exchange_rate (
    currency_exchange_rate_id integer NOT NULL,
    currency_rate_date timestamp without time zone NOT NULL,
    from_currency_code character(3) NOT NULL,
    to_currency_code character(3) NOT NULL,
    average_rate numeric NOT NULL,
    end_of_day_rate numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.currency_exchange_rate OWNER TO postgres;


CREATE SEQUENCE db.currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.currencyrate_currencyrateid_seq OWNER TO postgres;


ALTER SEQUENCE db.currencyrate_currencyrateid_seq OWNED BY db.currency_exchange_rate.currency_exchange_rate_id;



CREATE TABLE db.customer (
    customer_id integer NOT NULL,
    person_id integer,
    store_id integer,
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
    branch_id integer NOT NULL,
    updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.department OWNER TO postgres;


CREATE TABLE db.discount (
    discount_id integer NOT NULL,
    description character varying(255) NOT NULL,
    discount_amount numeric DEFAULT 0.00 NOT NULL,
    discount_type character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    min_quantity integer DEFAULT 0 NOT NULL,
    max_quantity integer,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK ((discount_amount >= 0.00)),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK ((end_date >= start_date)),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK ((max_quantity >= 0)),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK ((min_quantity >= 0))
);


ALTER TABLE db.discount OWNER TO postgres;


CREATE TABLE db.doc (
    title character varying(50) NOT NULL,
    owner integer NOT NULL,
    file_name character varying(400) NOT NULL,
    file_ext character varying(8),
    revision character(5) NOT NULL,
    change_num integer DEFAULT 0 NOT NULL,
    status smallint NOT NULL,
    doc_sum text,
    doc bytea,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    document_node character varying DEFAULT '/'::character varying NOT NULL,
    CONSTRAINT "CK_Document_Status" CHECK (((status >= 1) AND (status <= 3)))
);


ALTER TABLE db.doc OWNER TO postgres;


CREATE TABLE db.email_ads (
    busi_enty_id integer NOT NULL,
    email_id integer NOT NULL,
    email character varying(50),
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.email_ads OWNER TO postgres;


CREATE SEQUENCE db.emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.emailaddress_emailaddressid_seq OWNER TO postgres;


ALTER SEQUENCE db.emailaddress_emailaddressid_seq OWNED BY db.email_ads.email_id;



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


CREATE TABLE db.history_employee_depart (
    busi_enty_id integer NOT NULL,
    depart_id smallint NOT NULL,
    shift_id smallint NOT NULL,
    joining_date date NOT NULL,
    end_date date,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((end_date >= joining_date) OR (end_date IS NULL)))
);


ALTER TABLE db.history_employee_depart OWNER TO postgres;


CREATE TABLE db.history_transaction (
    transaction_id integer NOT NULL,
    product_id integer NOT NULL,
    ref_order_id integer NOT NULL,
    ref_order_line_id integer DEFAULT 0 NOT NULL,
    transaction_date timestamp without time zone DEFAULT now() NOT NULL,
    transaction_type character(1) NOT NULL,
    qnty integer NOT NULL,
    actual_cost numeric NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK ((upper((transaction_type)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE db.history_transaction OWNER TO postgres;


CREATE TABLE db.illus (
    illus_id integer NOT NULL,
    diagram xml,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.illus OWNER TO postgres;


CREATE SEQUENCE db.illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.illustration_illustrationid_seq OWNER TO postgres;


ALTER SEQUENCE db.illustration_illustrationid_seq OWNED BY db.illus.illus_id;



CREATE SEQUENCE db.jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.jobcandidate_jobcandidateid_seq OWNER TO postgres;


ALTER SEQUENCE db.jobcandidate_jobcandidateid_seq OWNED BY db.applicant_for_job.applicant_for_job_id;



CREATE SEQUENCE db.location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.location_locationid_seq OWNER TO postgres;


ALTER SEQUENCE db.location_locationid_seq OWNED BY db.area.lct_id;



CREATE TABLE db.measure_unit (
    unit_measure_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.measure_unit OWNER TO postgres;


CREATE TABLE db.pass (
    busi_enty_id integer NOT NULL,
    pass_hash character varying(128) NOT NULL,
    pass_salt character varying(10) NOT NULL,
    row_guid uuid NOT NULL,
    update_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pass OWNER TO postgres;


CREATE TABLE db.payment_card_person (
    business_entity_id integer NOT NULL,
    card_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.payment_card_person OWNER TO postgres;


CREATE TABLE db.person (
    business_entity_id integer NOT NULL,
    gender_person character(2) NOT NULL,
    title_name character varying(8),
    email_promotion integer DEFAULT 0 NOT NULL,
    extra_contact_information xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (((email_promotion >= 0) AND (email_promotion <= 2))),
    CONSTRAINT "CK_Person_PersonType" CHECK (((gender_person IS NULL) OR (upper((gender_person)::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text]))))
);


ALTER TABLE db.person OWNER TO postgres;


CREATE TABLE db.person_phone (
    business_entity_id integer NOT NULL,
    phn_num_typ_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.person_phone OWNER TO postgres;


CREATE TABLE db.phn_num_typ (
    phone_number_type_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.phn_num_typ OWNER TO postgres;


CREATE SEQUENCE db.phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.phonenumbertype_phonenumbertypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.phonenumbertype_phonenumbertypeid_seq OWNED BY db.phn_num_typ.phone_number_type_id;



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


CREATE TABLE db.product_dealer (
    product_id integer NOT NULL,
    busi_enty_id integer NOT NULL,
    avg_time integer NOT NULL,
    standard_price numeric NOT NULL,
    last_receipt_cost numeric,
    last_receipt_date timestamp without time zone,
    min_order_qty integer NOT NULL,
    max_order_qty integer NOT NULL,
    on_order_qunt integer,
    unit_measure_code character(3) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK ((avg_time >= 1)),
    CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK ((last_receipt_cost > 0.00)),
    CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK ((max_order_qty >= 1)),
    CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK ((min_order_qty >= 1)),
    CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK ((on_order_qunt >= 0)),
    CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK ((standard_price > 0.00))
);


ALTER TABLE db.product_dealer OWNER TO postgres;


CREATE TABLE db.product_desc (
    product_description_id integer NOT NULL,
    description character varying(400) NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_desc OWNER TO postgres;


CREATE TABLE db.product_doc (
    product_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    doc_node character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE db.product_doc OWNER TO postgres;


CREATE TABLE db.product_dscnt (
    product_dscnt_id integer NOT NULL,
    product_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_dscnt OWNER TO postgres;


CREATE TABLE db.product_img (
    product_photo_id integer NOT NULL,
    thumb_photo bytea,
    thumb_photo_file_name character varying(50),
    large_photo bytea,
    large_photo_file_name character varying(50),
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_img OWNER TO postgres;


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


CREATE TABLE db.product_model (
    product_model_id integer NOT NULL,
    catalog_desc xml,
    instructions xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_model OWNER TO postgres;


CREATE TABLE db.product_model_illustration (
    product_model_id integer NOT NULL,
    illus_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_model_illustration OWNER TO postgres;


CREATE TABLE db.product_model_product_desc_culture (
    product_model_id integer NOT NULL,
    product_desc_id integer NOT NULL,
    culture_id character(6) NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_model_product_desc_culture OWNER TO postgres;


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
    email_ads character varying(50) NOT NULL,
    rating integer NOT NULL,
    cmnt character varying(3850),
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE db.product_review OWNER TO postgres;


CREATE TABLE db.product_section (
    product_ctgr_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_section OWNER TO postgres;


CREATE TABLE db.product_subcategory (
    product_subcategory_id integer NOT NULL,
    product_ctgr_id integer NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.product_subcategory OWNER TO postgres;


CREATE SEQUENCE db.productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productcategory_productcategoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.productcategory_productcategoryid_seq OWNED BY db.product_section.product_ctgr_id;



CREATE SEQUENCE db.productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.productdescription_productdescriptionid_seq OWNER TO postgres;


ALTER SEQUENCE db.productdescription_productdescriptionid_seq OWNED BY db.product_desc.product_description_id;



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


ALTER SEQUENCE db.productphoto_productphotoid_seq OWNED BY db.product_img.product_photo_id;



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



CREATE SEQUENCE db.purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.purchaseorderdetail_purchaseorderdetailid_seq OWNER TO postgres;


ALTER SEQUENCE db.purchaseorderdetail_purchaseorderdetailid_seq OWNED BY db.b_details.b_details_id;



CREATE TABLE db.sales_order (
    sales_order_id integer NOT NULL,
    sales_reason_id integer NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.sales_order OWNER TO postgres;


CREATE TABLE db.sales_order_detail (
    sales_order_id integer NOT NULL,
    sales_order_detail_id integer NOT NULL,
    tracking_num character varying(25),
    order_qty smallint NOT NULL,
    product_id integer NOT NULL,
    discount_id integer NOT NULL,
    unit_price numeric NOT NULL,
    unit_price_dscnt numeric DEFAULT 0.0 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((order_qty > 0)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unit_price >= 0.00)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unit_price_dscnt >= 0.00))
);


ALTER TABLE db.sales_order_detail OWNER TO postgres;


CREATE TABLE db.sales_person (
    busi_enty_id integer NOT NULL,
    bonus numeric DEFAULT 0.00 NOT NULL,
    commission numeric DEFAULT 0.00 NOT NULL,
    sales_ytd numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commission >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((sales_ytd >= 0.00))
);


ALTER TABLE db.sales_person OWNER TO postgres;


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


CREATE SEQUENCE db.salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.salesorderdetail_salesorderdetailid_seq OWNER TO postgres;


ALTER SEQUENCE db.salesorderdetail_salesorderdetailid_seq OWNED BY db.sales_order_detail.sales_order_detail_id;



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
    starting_shift time without time zone NOT NULL,
    ending_shift time without time zone NOT NULL,
    date_updated timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.shift OWNER TO postgres;


CREATE TABLE db.shipment_method (
    shipment_method_id integer NOT NULL,
    shipping_price numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shipping_price > 0.00))
);


ALTER TABLE db.shipment_method OWNER TO postgres;


CREATE SEQUENCE db.shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.shipmethod_shipmethodid_seq OWNER TO postgres;


ALTER SEQUENCE db.shipmethod_shipmethodid_seq OWNED BY db.shipment_method.shipment_method_id;



CREATE TABLE db.shopping_cart (
    shopping_cart_item_id integer NOT NULL,
    shopping_cart_id character varying(50) NOT NULL,
    num_of_product integer DEFAULT 1 NOT NULL,
    product_id integer NOT NULL,
    date_created timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((num_of_product >= 1))
);


ALTER TABLE db.shopping_cart OWNER TO postgres;


CREATE SEQUENCE db.shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.shoppingcartitem_shoppingcartitemid_seq OWNER TO postgres;


ALTER SEQUENCE db.shoppingcartitem_shoppingcartitemid_seq OWNED BY db.shopping_cart.shopping_cart_item_id;



CREATE SEQUENCE db.specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.specialoffer_specialofferid_seq OWNER TO postgres;


ALTER SEQUENCE db.specialoffer_specialofferid_seq OWNED BY db.discount.discount_id;



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
    busi_enty_id integer NOT NULL,
    sales_person_id integer,
    demographics xml,
    row_guid uuid NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.store OWNER TO postgres;


CREATE SEQUENCE db.transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.transactionhistory_transactionid_seq OWNER TO postgres;


ALTER SEQUENCE db.transactionhistory_transactionid_seq OWNED BY db.history_transaction.transaction_id;



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


CREATE SEQUENCE db.workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.workorder_workorderid_seq OWNER TO postgres;


ALTER SEQUENCE db.workorder_workorderid_seq OWNED BY db.work_order.work_order_id;



ALTER TABLE ONLY db.ads ALTER COLUMN ads_id SET DEFAULT nextval('db.address_addressid_seq'::regclass);



ALTER TABLE ONLY db.ads_typ ALTER COLUMN ads_typ_id SET DEFAULT nextval('db.addresstype_addresstypeid_seq'::regclass);



ALTER TABLE ONLY db.applicant_for_job ALTER COLUMN applicant_for_job_id SET DEFAULT nextval('db.jobcandidate_jobcandidateid_seq'::regclass);



ALTER TABLE ONLY db.area ALTER COLUMN lct_id SET DEFAULT nextval('db.location_locationid_seq'::regclass);



ALTER TABLE ONLY db.b_details ALTER COLUMN b_details_id SET DEFAULT nextval('db.purchaseorderdetail_purchaseorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.busi_enty ALTER COLUMN busi_enty_id SET DEFAULT nextval('db.businessentity_businessentityid_seq'::regclass);



ALTER TABLE ONLY db.cont_typ ALTER COLUMN cont_typ_id SET DEFAULT nextval('db.contacttype_contacttypeid_seq'::regclass);



ALTER TABLE ONLY db.currency_exchange_rate ALTER COLUMN currency_exchange_rate_id SET DEFAULT nextval('db.currencyrate_currencyrateid_seq'::regclass);



ALTER TABLE ONLY db.customer ALTER COLUMN customer_id SET DEFAULT nextval('db.customer_customerid_seq'::regclass);



ALTER TABLE ONLY db.discount ALTER COLUMN discount_id SET DEFAULT nextval('db.specialoffer_specialofferid_seq'::regclass);



ALTER TABLE ONLY db.email_ads ALTER COLUMN email_id SET DEFAULT nextval('db.emailaddress_emailaddressid_seq'::regclass);



ALTER TABLE ONLY db.history_transaction ALTER COLUMN transaction_id SET DEFAULT nextval('db.transactionhistory_transactionid_seq'::regclass);



ALTER TABLE ONLY db.illus ALTER COLUMN illus_id SET DEFAULT nextval('db.illustration_illustrationid_seq'::regclass);



ALTER TABLE ONLY db.materials_bills ALTER COLUMN bill_of_materials_id SET DEFAULT nextval('db.billofmaterials_billofmaterialsid_seq'::regclass);



ALTER TABLE ONLY db.payment_card ALTER COLUMN card_id SET DEFAULT nextval('db.creditcard_creditcardid_seq'::regclass);



ALTER TABLE ONLY db.phn_num_typ ALTER COLUMN phone_number_type_id SET DEFAULT nextval('db.phonenumbertype_phonenumbertypeid_seq'::regclass);



ALTER TABLE ONLY db.product ALTER COLUMN product_id SET DEFAULT nextval('db.product_productid_seq'::regclass);



ALTER TABLE ONLY db.product_desc ALTER COLUMN product_description_id SET DEFAULT nextval('db.productdescription_productdescriptionid_seq'::regclass);



ALTER TABLE ONLY db.product_img ALTER COLUMN product_photo_id SET DEFAULT nextval('db.productphoto_productphotoid_seq'::regclass);



ALTER TABLE ONLY db.product_model ALTER COLUMN product_model_id SET DEFAULT nextval('db.productmodel_productmodelid_seq'::regclass);



ALTER TABLE ONLY db.product_review ALTER COLUMN product_review_id SET DEFAULT nextval('db.productreview_productreviewid_seq'::regclass);



ALTER TABLE ONLY db.product_section ALTER COLUMN product_ctgr_id SET DEFAULT nextval('db.productcategory_productcategoryid_seq'::regclass);



ALTER TABLE ONLY db.product_subcategory ALTER COLUMN product_subcategory_id SET DEFAULT nextval('db.productsubcategory_productsubcategoryid_seq'::regclass);



ALTER TABLE ONLY db.sales_order_detail ALTER COLUMN sales_order_detail_id SET DEFAULT nextval('db.salesorderdetail_salesorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.sales_reason ALTER COLUMN sales_reason_id SET DEFAULT nextval('db.salesreason_salesreasonid_seq'::regclass);



ALTER TABLE ONLY db.sales_tax_rate ALTER COLUMN sales_tax_rate_id SET DEFAULT nextval('db.salestaxrate_salestaxrateid_seq'::regclass);



ALTER TABLE ONLY db.sales_territory ALTER COLUMN territory_id SET DEFAULT nextval('db.salesterritory_territoryid_seq'::regclass);



ALTER TABLE ONLY db.scrap_reason ALTER COLUMN scrap_reason_id SET DEFAULT nextval('db.scrapreason_scrapreasonid_seq'::regclass);



ALTER TABLE ONLY db.shipment_method ALTER COLUMN shipment_method_id SET DEFAULT nextval('db.shipmethod_shipmethodid_seq'::regclass);



ALTER TABLE ONLY db.shopping_cart ALTER COLUMN shopping_cart_item_id SET DEFAULT nextval('db.shoppingcartitem_shoppingcartitemid_seq'::regclass);



ALTER TABLE ONLY db.state_province ALTER COLUMN state_province_id SET DEFAULT nextval('db.stateprovince_stateprovinceid_seq'::regclass);



ALTER TABLE ONLY db.work_order ALTER COLUMN work_order_id SET DEFAULT nextval('db.workorder_workorderid_seq'::regclass);



ALTER TABLE ONLY db.ads_typ
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (ads_typ_id);

ALTER TABLE db.ads_typ CLUSTER ON "PK_AddressType_AddressTypeID";



ALTER TABLE ONLY db.ads
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (ads_id);

ALTER TABLE db.ads CLUSTER ON "PK_Address_AddressID";



ALTER TABLE ONLY db.materials_bills
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (bill_of_materials_id);



ALTER TABLE ONLY db.busi_enty_ads
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (busi_enty_id, ads_id, ads_typ_id);

ALTER TABLE db.busi_enty_ads CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";



ALTER TABLE ONLY db.busi_enty_contc
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (busi_enty_id, person_id, type_contact_id);

ALTER TABLE db.busi_enty_contc CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";



ALTER TABLE ONLY db.busi_enty
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (busi_enty_id);

ALTER TABLE db.busi_enty CLUSTER ON "PK_BusinessEntity_BusinessEntityID";



ALTER TABLE ONLY db.cont_typ
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (cont_typ_id);

ALTER TABLE db.cont_typ CLUSTER ON "PK_ContactType_ContactTypeID";



ALTER TABLE ONLY db.country_currency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (country_code, currency_code);

ALTER TABLE db.country_currency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";



ALTER TABLE ONLY db.country_region
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (country_code);

ALTER TABLE db.country_region CLUSTER ON "PK_CountryRegion_CountryRegionCode";



ALTER TABLE ONLY db.payment_card
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (card_id);

ALTER TABLE db.payment_card CLUSTER ON "PK_CreditCard_CreditCardID";



ALTER TABLE ONLY db.culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (culture_id);

ALTER TABLE db.culture CLUSTER ON "PK_Culture_CultureID";



ALTER TABLE ONLY db.currency_exchange_rate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currency_exchange_rate_id);

ALTER TABLE db.currency_exchange_rate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";



ALTER TABLE ONLY db.currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currency_code);

ALTER TABLE db.currency CLUSTER ON "PK_Currency_CurrencyCode";



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customer_id);

ALTER TABLE db.customer CLUSTER ON "PK_Customer_CustomerID";



ALTER TABLE ONLY db.department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (branch_id);

ALTER TABLE db.department CLUSTER ON "PK_Department_DepartmentID";



ALTER TABLE ONLY db.doc
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (document_node);

ALTER TABLE db.doc CLUSTER ON "PK_Document_DocumentNode";



ALTER TABLE ONLY db.email_ads
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (busi_enty_id, email_id);

ALTER TABLE db.email_ads CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";



ALTER TABLE ONLY db.history_employee_depart
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (busi_enty_id, joining_date, depart_id, shift_id);

ALTER TABLE db.history_employee_depart CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";



ALTER TABLE ONLY db.employee_pay_history
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (business_entity_id, rate_change_date);

ALTER TABLE db.employee_pay_history CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";



ALTER TABLE ONLY db.illus
    ADD CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illus_id);

ALTER TABLE db.illus CLUSTER ON "PK_Illustration_IllustrationID";



ALTER TABLE ONLY db.applicant_for_job
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (applicant_for_job_id);

ALTER TABLE db.applicant_for_job CLUSTER ON "PK_JobCandidate_JobCandidateID";



ALTER TABLE ONLY db.area
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (lct_id);

ALTER TABLE db.area CLUSTER ON "PK_Location_LocationID";



ALTER TABLE ONLY db.pass
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (busi_enty_id);

ALTER TABLE db.pass CLUSTER ON "PK_Password_BusinessEntityID";



ALTER TABLE ONLY db.payment_card_person
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (business_entity_id, card_id);

ALTER TABLE db.payment_card_person CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";



ALTER TABLE ONLY db.person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.person CLUSTER ON "PK_Person_BusinessEntityID";



ALTER TABLE ONLY db.phn_num_typ
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phone_number_type_id);

ALTER TABLE db.phn_num_typ CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";



ALTER TABLE ONLY db.product_section
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (product_ctgr_id);

ALTER TABLE db.product_section CLUSTER ON "PK_ProductCategory_ProductCategoryID";



ALTER TABLE ONLY db.product_cost_history
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (product_id, start_date);

ALTER TABLE db.product_cost_history CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";



ALTER TABLE ONLY db.product_desc
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (product_description_id);

ALTER TABLE db.product_desc CLUSTER ON "PK_ProductDescription_ProductDescriptionID";



ALTER TABLE ONLY db.product_doc
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (product_id, doc_node);

ALTER TABLE db.product_doc CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";



ALTER TABLE ONLY db.product_inventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (product_id, location_id);

ALTER TABLE db.product_inventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";



ALTER TABLE ONLY db.product_model_illustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (product_model_id, illus_id);

ALTER TABLE db.product_model_illustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";



ALTER TABLE ONLY db.product_model_product_desc_culture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (product_model_id, product_desc_id, culture_id);

ALTER TABLE db.product_model_product_desc_culture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";



ALTER TABLE ONLY db.product_model
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (product_model_id);

ALTER TABLE db.product_model CLUSTER ON "PK_ProductModel_ProductModelID";



ALTER TABLE ONLY db.product_img
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (product_photo_id);

ALTER TABLE db.product_img CLUSTER ON "PK_ProductPhoto_ProductPhotoID";



ALTER TABLE ONLY db.product_review
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (product_review_id);

ALTER TABLE db.product_review CLUSTER ON "PK_ProductReview_ProductReviewID";



ALTER TABLE ONLY db.product_subcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (product_subcategory_id);

ALTER TABLE db.product_subcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";



ALTER TABLE ONLY db.product_dealer
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (product_id, busi_enty_id);

ALTER TABLE db.product_dealer CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (product_id);

ALTER TABLE db.product CLUSTER ON "PK_Product_ProductID";



ALTER TABLE ONLY db.sales_order_detail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (sales_order_id, sales_order_detail_id);

ALTER TABLE db.sales_order_detail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";



ALTER TABLE ONLY db.sales_order
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (sales_order_id, sales_reason_id);

ALTER TABLE db.sales_order CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";



ALTER TABLE ONLY db.sales_person
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (busi_enty_id);

ALTER TABLE db.sales_person CLUSTER ON "PK_SalesPerson_BusinessEntityID";



ALTER TABLE ONLY db.sales_reason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (sales_reason_id);

ALTER TABLE db.sales_reason CLUSTER ON "PK_SalesReason_SalesReasonID";



ALTER TABLE ONLY db.sales_tax_rate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (sales_tax_rate_id);

ALTER TABLE db.sales_tax_rate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";



ALTER TABLE ONLY db.sales_territory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territory_id);

ALTER TABLE db.sales_territory CLUSTER ON "PK_SalesTerritory_TerritoryID";



ALTER TABLE ONLY db.scrap_reason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrap_reason_id);

ALTER TABLE db.scrap_reason CLUSTER ON "PK_ScrapReason_ScrapReasonID";



ALTER TABLE ONLY db.shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shift_id);

ALTER TABLE db.shift CLUSTER ON "PK_Shift_ShiftID";



ALTER TABLE ONLY db.shipment_method
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (shipment_method_id);

ALTER TABLE db.shipment_method CLUSTER ON "PK_ShipMethod_ShipMethodID";



ALTER TABLE ONLY db.shopping_cart
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shopping_cart_item_id);

ALTER TABLE db.shopping_cart CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";



ALTER TABLE ONLY db.product_dscnt
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (product_dscnt_id, product_id);

ALTER TABLE db.product_dscnt CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";



ALTER TABLE ONLY db.discount
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (discount_id);

ALTER TABLE db.discount CLUSTER ON "PK_SpecialOffer_SpecialOfferID";



ALTER TABLE ONLY db.state_province
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (state_province_id);

ALTER TABLE db.state_province CLUSTER ON "PK_StateProvince_StateProvinceID";



ALTER TABLE ONLY db.store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (busi_enty_id);

ALTER TABLE db.store CLUSTER ON "PK_Store_BusinessEntityID";



ALTER TABLE ONLY db.history_transaction
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE db.history_transaction CLUSTER ON "PK_TransactionHistory_TransactionID";



ALTER TABLE ONLY db.measure_unit
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unit_measure_code);

ALTER TABLE db.measure_unit CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";



ALTER TABLE ONLY db.buyer
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (busi_enty_id);

ALTER TABLE db.buyer CLUSTER ON "PK_Vendor_BusinessEntityID";



ALTER TABLE ONLY db.work_order
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (work_order_id);

ALTER TABLE db.work_order CLUSTER ON "PK_WorkOrder_WorkOrderID";



ALTER TABLE ONLY db.doc
    ADD CONSTRAINT document_rowguid_key UNIQUE (row_guid);



ALTER TABLE ONLY db.materials_bills
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (compnt_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.materials_bills
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (product_assembly_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.materials_bills
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES db.measure_unit(unit_measure_code);



ALTER TABLE ONLY db.busi_enty_ads
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (ads_typ_id) REFERENCES db.ads_typ(ads_typ_id);



ALTER TABLE ONLY db.busi_enty_ads
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (ads_id) REFERENCES db.ads(ads_id);



ALTER TABLE ONLY db.busi_enty_ads
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.busi_enty(busi_enty_id);



ALTER TABLE ONLY db.busi_enty_contc
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.busi_enty(busi_enty_id);



ALTER TABLE ONLY db.busi_enty_contc
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (type_contact_id) REFERENCES db.cont_typ(cont_typ_id);



ALTER TABLE ONLY db.busi_enty_contc
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (person_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.country_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (country_code) REFERENCES db.country_region(country_code);



ALTER TABLE ONLY db.country_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currency_code) REFERENCES db.currency(currency_code);



ALTER TABLE ONLY db.currency_exchange_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (from_currency_code) REFERENCES db.currency(currency_code);



ALTER TABLE ONLY db.currency_exchange_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (to_currency_code) REFERENCES db.currency(currency_code);



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (person_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (store_id) REFERENCES db.store(busi_enty_id);



ALTER TABLE ONLY db.email_ads
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.history_employee_depart
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (depart_id) REFERENCES db.department(branch_id);



ALTER TABLE ONLY db.history_employee_depart
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shift_id) REFERENCES db.shift(shift_id);



ALTER TABLE ONLY db.pass
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.payment_card_person
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (card_id) REFERENCES db.payment_card(card_id);



ALTER TABLE ONLY db.payment_card_person
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.person_phone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.person(business_entity_id);



ALTER TABLE ONLY db.person_phone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phn_num_typ_id) REFERENCES db.phn_num_typ(phone_number_type_id);



ALTER TABLE ONLY db.person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.busi_enty(busi_enty_id);



ALTER TABLE ONLY db.product_cost_history
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_doc
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (doc_node) REFERENCES db.doc(document_node);



ALTER TABLE ONLY db.product_doc
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (location_id) REFERENCES db.area(lct_id);



ALTER TABLE ONLY db.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illus_id) REFERENCES db.illus(illus_id);



ALTER TABLE ONLY db.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES db.product_model(product_model_id);



ALTER TABLE ONLY db.product_model_product_desc_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (culture_id) REFERENCES db.culture(culture_id);



ALTER TABLE ONLY db.product_model_product_desc_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (product_desc_id) REFERENCES db.product_desc(product_description_id);



ALTER TABLE ONLY db.product_model_product_desc_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (product_model_id) REFERENCES db.product_model(product_model_id);



ALTER TABLE ONLY db.product_subcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (product_ctgr_id) REFERENCES db.product_section(product_ctgr_id);



ALTER TABLE ONLY db.product_dealer
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_dealer
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES db.measure_unit(unit_measure_code);



ALTER TABLE ONLY db.product_dealer
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.buyer(busi_enty_id);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES db.product_model(product_model_id);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (product_subcategory_id) REFERENCES db.product_subcategory(product_subcategory_id);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (size_unit_measure_code) REFERENCES db.measure_unit(unit_measure_code);



ALTER TABLE ONLY db.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weight_unit_measure_code) REFERENCES db.measure_unit(unit_measure_code);



ALTER TABLE ONLY db.b_details
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (discount_id, product_id) REFERENCES db.product_dscnt(product_dscnt_id, product_id);



ALTER TABLE ONLY db.sales_order
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (sales_reason_id) REFERENCES db.sales_reason(sales_reason_id);



ALTER TABLE ONLY db.sales_tax_rate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (state_province_id) REFERENCES db.state_province(state_province_id);



ALTER TABLE ONLY db.sales_territory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.country_region(country_code);



ALTER TABLE ONLY db.shopping_cart
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_dscnt
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.product_dscnt
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (product_dscnt_id) REFERENCES db.discount(discount_id);



ALTER TABLE ONLY db.state_province
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.country_region(country_code);



ALTER TABLE ONLY db.state_province
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.sales_territory(territory_id);



ALTER TABLE ONLY db.store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.busi_enty(busi_enty_id);



ALTER TABLE ONLY db.store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (sales_person_id) REFERENCES db.sales_person(busi_enty_id);



ALTER TABLE ONLY db.history_transaction
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.buyer
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (busi_enty_id) REFERENCES db.busi_enty(busi_enty_id);



ALTER TABLE ONLY db.work_order
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.product(product_id);



ALTER TABLE ONLY db.work_order
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrap_reason_id) REFERENCES db.scrap_reason(scrap_reason_id);



