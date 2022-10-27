

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


ALTER SCHEMA db owner TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE db.pl_address (
    pl_address_id integer NOT NULL,
    pl_address_line_1 character varying(60) NOT NULL,
    pl_address_line_2 character varying(60),
    pl_city character varying(30) NOT NULL,
    pl_stat_id integer NOT NULL,
    pl_zipcode character varying(15) NOT NULL,
    pl_spatial_location character varying(44),
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_address owner TO postgres;


CREATE SEQUENCE db.pl_address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_address_addressid_seq owner TO postgres;


-- db.pl_address_addressid_seq OWNED BY db.pl_address.pl_address_id;



CREATE TABLE db.pl_address_type (
    pl_address_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_address_type owner TO postgres;


CREATE SEQUENCE db.pl_addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_addresstype_addresstypeid_seq owner TO postgres;


-- db.pl_addresstype_addresstypeid_seq OWNED BY db.pl_address_type.pl_address_type_id;



CREATE TABLE db.pl_bom (
    pl_bom_id integer NOT NULL,
    pl_merchandise_assembly_id integer,
    pl_component_id integer NOT NULL,
    pl_start_date timestamp without time zone DEFAULT now() NOT NULL,
    pl_end_date timestamp without time zone,
    pl_unit_measure_code character(3) NOT NULL,
    pl_bom_lvl smallint NOT NULL,
    pl_per_assembly_qty numeric(8,2) DEFAULT 1.00 NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_BillOfMaterials_BOMlvl" CHECK ((((pl_merchandise_assembly_id IS NULL) AND (pl_bom_lvl = 0) AND (pl_per_assembly_qty = 1.00)) OR ((pl_merchandise_assembly_id IS NOT NULL) AND (pl_bom_lvl >= 1)))),
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (((pl_end_date > pl_start_date) OR (pl_end_date IS NULL))),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK ((pl_per_assembly_qty >= 1.00)),
    CONSTRAINT "CK_BillOfMaterials_merchandiseAssemblyID" CHECK ((pl_merchandise_assembly_id <> pl_component_id))
);


ALTER TABLE db.pl_bom owner TO postgres;


CREATE SEQUENCE db.pl_billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_billofmaterials_billofmaterialsid_seq owner TO postgres;


-- db.pl_billofmaterials_billofmaterialsid_seq OWNED BY db.pl_bom.pl_bom_id;



CREATE TABLE db.pl_business_entity (
    pl_business_entity_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_business_entity owner TO postgres;


CREATE TABLE db.pl_business_entity_address (
    pl_business_entity_id integer NOT NULL,
    pl_address_id integer NOT NULL,
    pl_address_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_business_entity_address owner TO postgres;


CREATE TABLE db.pl_business_entity_contact (
    pl_business_entity_id integer NOT NULL,
    pl_person_id integer NOT NULL,
    pl_contact_type_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_business_entity_contact owner TO postgres;


CREATE SEQUENCE db.pl_businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_businessentity_businessentityid_seq owner TO postgres;


-- db.pl_businessentity_businessentityid_seq OWNED BY db.pl_business_entity.pl_business_entity_id;



CREATE TABLE db.pl_contact_type (
    pl_contact_type_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_contact_type owner TO postgres;


CREATE SEQUENCE db.pl_contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_contacttype_contacttypeid_seq owner TO postgres;


-- db.pl_contacttype_contacttypeid_seq OWNED BY db.pl_contact_type.pl_contact_type_id;



CREATE TABLE db.pl_country_region (
    pl_country_region_code character varying(3) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_country_region owner TO postgres;


CREATE TABLE db.pl_country_region_currency (
    pl_country_region_code character varying(3) NOT NULL,
    pl_currency_code character(3) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_country_region_currency owner TO postgres;


CREATE TABLE db.pl_credit_card (
    pl_bank_card_id integer NOT NULL,
    pl_card_type character varying(50) NOT NULL,
    pl_card_number character varying(25) NOT NULL,
    pl_exp_month smallint NOT NULL,
    pl_exp_year smallint NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_credit_card owner TO postgres;


CREATE SEQUENCE db.pl_creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_creditcard_creditcardid_seq owner TO postgres;


-- db.pl_creditcard_creditcardid_seq OWNED BY db.pl_credit_card.pl_bank_card_id;



CREATE TABLE db.pl_culture (
    pl_culture_id character(6) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_culture owner TO postgres;


CREATE TABLE db.pl_currency (
    pl_currency_code character(3) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_currency owner TO postgres;


CREATE TABLE db.pl_exchange_pl_rate (
    pl_exchange_rate_it integer NOT NULL,
    pl_exchange_rate_date timestamp without time zone NOT NULL,
    pl_from_currency_code character(3) NOT NULL,
    pl_to_currency_code character(3) NOT NULL,
    pl_avg_rate numeric NOT NULL,
    pl_closing_rate numeric NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_exchange_pl_rate owner TO postgres;


CREATE SEQUENCE db.pl_currencypl_rate_currencypl_rateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_currencypl_rate_currencypl_rateid_seq owner TO postgres;


-- db.pl_currencypl_rate_currencypl_rateid_seq OWNED BY db.pl_exchange_pl_rate.pl_exchange_rate_it;



CREATE TABLE db.pl_client (
    pl_client_id integer NOT NULL,
    pl_person_id integer,
    pl_shop_id integer,
    pl_zone_id integer,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_client owner TO postgres;


CREATE SEQUENCE db.pl_client_clientid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_client_clientid_seq owner TO postgres;


-- db.pl_client_clientid_seq OWNED BY db.pl_client.pl_client_id;



CREATE TABLE db.pl_department (
    pl_department_id integer NOT NULL,
	pl_department_pl_name character(30) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_department owner TO postgres;


CREATE TABLE db.pl_document (
    pl_title character varying(50) NOT NULL,
    pl_owner integer NOT NULL,
    pl_file_path character varying(400) NOT NULL,
    pl_file_type character varying(8),
    pl_status smallint NOT NULL,
    pl_doc_summary text,
    pl_doc bytea,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    pl_document_node character varying DEFAULT '/'::character varying NOT NULL,
    CONSTRAINT "CK_Document_pl_status" CHECK (((pl_status >= 1) AND (pl_status <= 3)))
);


ALTER TABLE db.pl_document owner TO postgres;


CREATE TABLE db.pl_email (
    pl_business_entity_id integer NOT NULL,
    pl_email_id integer NOT NULL,
    pl_email character varying(50),
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_email owner TO postgres;


CREATE SEQUENCE db.pl_emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_emailaddress_emailaddressid_seq owner TO postgres;


-- db.pl_emailaddress_emailaddressid_seq OWNED BY db.pl_email.pl_email_id;



CREATE TABLE db.pl_employee_department_history (
    pl_business_entity_id integer NOT NULL,
    pl_department_id smallint NOT NULL,
    pl_shift_id smallint NOT NULL,
    pl_start_date date NOT NULL,
    pl_end_date date,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((pl_end_date >= pl_start_date) OR (pl_end_date IS NULL)))
);


ALTER TABLE db.pl_employee_department_history owner TO postgres;


CREATE TABLE db.pl_employee_wage_history (
    pl_business_entity_id integer NOT NULL,
    pl_last_wage_change timestamp without time zone NOT NULL,
    pl_rate numeric NOT NULL,
    pl_payment_period smallint NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((pl_payment_period = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_pl_rate" CHECK (((pl_rate >= 6.50) AND (pl_rate <= 200.00)))
);


ALTER TABLE db.pl_employee_wage_history owner TO postgres;


CREATE TABLE db.pl_graphic (
    pl_graphic_id integer NOT NULL,
    pl_diagram xml,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_graphic owner TO postgres;


CREATE SEQUENCE db.pl_graphic_graphicid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_graphic_graphicid_seq owner TO postgres;


-- db.pl_graphic_graphicid_seq OWNED BY db.pl_graphic.pl_graphic_id;



CREATE TABLE db.pl_job_candidate (
    pl_job_candidate_id integer NOT NULL,
    pl_business_entity_id integer,
    pl_cv xml,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_job_candidate owner TO postgres;


CREATE SEQUENCE db.pl_jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_jobcandidate_jobcandidateid_seq owner TO postgres;


-- db.pl_jobcandidate_jobcandidateid_seq OWNED BY db.pl_job_candidate.pl_job_candidate_id;



CREATE TABLE db.pl_location (
    pl_location_id integer NOT NULL,
    pl_cost_of_rent numeric DEFAULT 0.00 NOT NULL,
    pl_availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_pl_availability" CHECK ((pl_availability >= 0.00)),
    CONSTRAINT "CK_Location_Costpl_rate" CHECK ((pl_cost_of_rent >= 0.00))
);


ALTER TABLE db.pl_location owner TO postgres;


CREATE SEQUENCE db.pl_location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_location_locationid_seq owner TO postgres;


-- db.pl_location_locationid_seq OWNED BY db.pl_location.pl_location_id;



CREATE TABLE db.pl_password (
    pl_business_entity_id integer NOT NULL,
    pl_hash_pwd character varying(128) NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_password owner TO postgres;


CREATE TABLE db.pl_person (
    pl_business_entity_id integer NOT NULL,
    pl_person_type character(2) NOT NULL,
    pl_name character varying(8),
    pl_suffix character varying(10),
    pl_pl_basic_pricetion integer DEFAULT 0 NOT NULL,
    pl_extract_info xml,
    pl_demo_graphics xml,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (((pl_pl_basic_pricetion >= 0) AND (pl_pl_basic_pricetion <= 2))),
    CONSTRAINT "CK_Person_PersonType" CHECK (((pl_person_type IS NULL) OR (upper((pl_person_type)::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text]))))
);


ALTER TABLE db.pl_person owner TO postgres;


CREATE TABLE db.pl_person_credit_card (
    pl_business_entity_id integer NOT NULL,
    pl_bank_card_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_person_credit_card owner TO postgres;


CREATE TABLE db.pl_person_phone (
    pl_business_entity_id integer NOT NULL,
    pl_phone_number_type_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_person_phone owner TO postgres;


CREATE TABLE db.pl_phone_number_type (
    pl_phone_number_type_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_phone_number_type owner TO postgres;


CREATE SEQUENCE db.pl_phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_phonenumbertype_phonenumbertypeid_seq owner TO postgres;


-- db.pl_phonenumbertype_phonenumbertypeid_seq OWNED BY db.pl_phone_number_type.pl_phone_number_type_id;



CREATE TABLE db.pl_merchandise (
    pl_merch_id integer NOT NULL,
    pl_merchandise_number character varying(25) NOT NULL,
    pl_color character varying(15),
    pl_safety_stock_lvl smallint NOT NULL,
    pl_reorder_point smallint NOT NULL,
    pl_pl_basic_price numeric NOT NULL,
    pl_list_price numeric NOT NULL,
    size character varying(5),
    size_pl_unit_measure_code character(3),
    weight_pl_unit_measure_code character(3),
    pl_weight numeric(8,2),
    pl_days_to_manufacture integer NOT NULL,
    pl_merchandise_line character(2),
    class character(2),
    pl_style character(2),
    pl_merchandise_subcategory_id integer,
    merchandise_model_id integer,
    pl_sell_start_date timestamp without time zone NOT NULL,
    pl_sell_end_date timestamp without time zone,
    pl_discontinued_date timestamp without time zone,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_merchandise_Class" CHECK (((upper((class)::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR (class IS NULL))),
    CONSTRAINT "CK_merchandise_DaysToManufacture" CHECK ((pl_days_to_manufacture >= 0)),
    CONSTRAINT "CK_merchandise_ListPrice" CHECK ((pl_list_price >= 0.00)),
    CONSTRAINT "CK_merchandise_merchandiseLine" CHECK (((upper((pl_merchandise_line)::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR (pl_merchandise_line IS NULL))),
    CONSTRAINT "CK_merchandise_ReorderPoint" CHECK ((pl_reorder_point > 0)),
    CONSTRAINT "CK_merchandise_SafetyStocklvl" CHECK ((pl_safety_stock_lvl > 0)),
    CONSTRAINT "CK_merchandise_SellEndDate" CHECK (((pl_sell_end_date >= pl_sell_start_date) OR (pl_sell_end_date IS NULL))),
    CONSTRAINT "CK_merchandise_StandardCost" CHECK ((pl_basic_price >= 0.00)),
    CONSTRAINT "CK_merchandise_Style" CHECK (((upper((pl_style)::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR (pl_style IS NULL))),
    CONSTRAINT "CK_merchandise_Weight" CHECK ((weight > 0.00))
);


ALTER TABLE db.pl_merchandise owner TO postgres;


CREATE TABLE db.pl_merchandise_category (
    pl_merchandise_category_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_category owner TO postgres;


CREATE TABLE db.pl_merchandise_cost_history (
    pl_merch_id integer NOT NULL,
    pl_start_date timestamp without time zone NOT NULL,
    pl_end_date timestamp without time zone,
    pl_basic_price numeric NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_merchandiseCostHistory_EndDate" CHECK (((pl_end_date >= pl_start_date) OR (pl_end_date IS NULL))),
    CONSTRAINT "CK_merchandiseCostHistory_StandardCost" CHECK ((pl_basic_price >= 0.00))
);


ALTER TABLE db.pl_merchandise_cost_history owner TO postgres;


CREATE TABLE db.pl_merchandise_description (
    merch_descr_id integer NOT NULL,
    description character varying(400) NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_description owner TO postgres;


CREATE TABLE db.pl_merchandise_document (
    pl_merch_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    pl_document_node character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE db.pl_merchandise_document owner TO postgres;


CREATE TABLE db.pl_merchandise_stock (
    pl_merch_id integer NOT NULL,
    pl_location_id smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    amount smallint DEFAULT 0 NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_merchandiseInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE db.pl_merchandise_stock owner TO postgres;


CREATE TABLE db.pl_merchandise_list_price_history (
    pl_merch_id integer NOT NULL,
    pl_start_date timestamp without time zone NOT NULL,
    pl_end_date timestamp without time zone,
    list_price numeric NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_merchandiseListPriceHistory_EndDate" CHECK (((pl_end_date >= pl_start_date) OR (pl_end_date IS NULL))),
    CONSTRAINT "CK_merchandiseListPriceHistory_ListPrice" CHECK ((list_price > 0.00))
);


ALTER TABLE db.pl_merchandise_list_price_history owner TO postgres;


CREATE TABLE db.pl_merchandise_model (
    merchandise_model_id integer NOT NULL,
    catalog_description xml,
    instructions xml,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_model owner TO postgres;


CREATE TABLE db.pl_merchandise_model_graphic (
    merchandise_model_id integer NOT NULL,
    pl_graphic_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_model_graphic owner TO postgres;


CREATE TABLE db.pl_merchandise_model_merchandise_description_culture (
    merchandise_model_id integer NOT NULL,
    merch_descr_id integer NOT NULL,
    pl_culture_id character(6) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_model_merchandise_description_culture owner TO postgres;


CREATE TABLE db.pl_merchandise_image (
    merchandise_image_id integer NOT NULL,
    thumbnail_image bytea,
    thumbnail_image_pl_file_path character varying(50),
    original_image bytea,
    original_image_pl_file_path character varying(50),
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_image owner TO postgres;


CREATE TABLE db.pl_merchandise_merchandise_image (
    pl_merch_id integer NOT NULL,
    merchandise_image_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_merchandise_image owner TO postgres;


CREATE SEQUENCE db.pl_merchandise_merchandiseid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandise_merchandiseid_seq owner TO postgres;


-- db.pl_merchandise_merchandiseid_seq OWNED BY db.pl_merchandise.pl_merch_id;



CREATE TABLE db.pl_merchandise_review (
    merchandise_review_id integer NOT NULL,
    pl_merch_id integer NOT NULL,
    date_posted timestamp without time zone DEFAULT now() NOT NULL,
    email_address character varying(50) NOT NULL,
    review_rating integer NOT NULL,
    notes character varying(3850),
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_merchandiseReview_review_rating" CHECK (((review_rating >= 1) AND (review_rating <= 5)))
);


ALTER TABLE db.pl_merchandise_review owner TO postgres;


CREATE TABLE db.pl_merchandise_subcategory (
    pl_merchandise_subcategory_id integer NOT NULL,
    pl_merchandise_category_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_merchandise_subcategory owner TO postgres;


CREATE TABLE db.pl_merchandise_vendor (
    pl_merch_id integer NOT NULL,
    pl_business_entity_id integer NOT NULL,
    pl_avg_lead_time integer NOT NULL,
    pl_basic_price numeric NOT NULL,
    pl_last_bill_amount numeric,
    pl_last_bill_date timestamp without time zone,
    pl_min_order_amount integer NOT NULL,
    pl_order_amount_limit integer NOT NULL,
    pl_on_order_amount integer,
    pl_unit_measure_code character(3) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_merchandiseVendor_avgLeadTime" CHECK ((pl_avg_lead_time >= 1)),
    CONSTRAINT "CK_merchandiseVendor_LastReceiptCost" CHECK ((pl_last_bill_amount > 0.00)),
    CONSTRAINT "CK_merchandiseVendor_MaxOrderQty" CHECK ((pl_order_amount_limit >= 1)),
    CONSTRAINT "CK_merchandiseVendor_MinOrderQty" CHECK ((pl_min_order_amount >= 1)),
    CONSTRAINT "CK_merchandiseVendor_OnOrderQty" CHECK ((pl_on_order_amount >= 0)),
    CONSTRAINT "CK_merchandiseVendor_StandardPrice" CHECK ((pl_basic_price > 0.00))
);


ALTER TABLE db.pl_merchandise_vendor owner TO postgres;


CREATE SEQUENCE db.pl_merchandisecategory_merchandisecategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandisecategory_merchandisecategoryid_seq owner TO postgres;


-- db.pl_merchandisecategory_merchandisecategoryid_seq OWNED BY db.pl_merchandise_category.pl_merchandise_category_id;



CREATE SEQUENCE db.pl_merchandisedescription_merchandisedescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandisedescription_merchandisedescriptionid_seq owner TO postgres;


-- db.pl_merchandisedescription_merchandisedescriptionid_seq OWNED BY db.pl_merchandise_description.merch_descr_id;



CREATE SEQUENCE db.pl_merchandisemodel_merchandisemodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandisemodel_merchandisemodelid_seq owner TO postgres;


-- db.pl_merchandisemodel_merchandisemodelid_seq OWNED BY db.pl_merchandise_model.merchandise_model_id;



CREATE SEQUENCE db.pl_merchandiseimage_merchandiseimageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandiseimage_merchandiseimageid_seq owner TO postgres;


-- db.pl_merchandiseimage_merchandiseimageid_seq OWNED BY db.pl_merchandise_image.merchandise_image_id;



CREATE SEQUENCE db.pl_merchandisereview_merchandisereviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandisereview_merchandisereviewid_seq owner TO postgres;


-- db.pl_merchandisereview_merchandisereviewid_seq OWNED BY db.pl_merchandise_review.merchandise_review_id;



CREATE SEQUENCE db.pl_merchandisesubcategory_merchandisesubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_merchandisesubcategory_merchandisesubcategoryid_seq owner TO postgres;


-- db.pl_merchandisesubcategory_merchandisesubcategoryid_seq OWNED BY db.pl_merchandise_subcategory.pl_merchandise_subcategory_id;



CREATE TABLE db.pl_purchase_order_detail (
    pl_purchase_order_id integer NOT NULL,
    pl_purchase_order_detail_id integer NOT NULL,
    pl_due_date timestamp without time zone NOT NULL,
    pl_order_qty smallint NOT NULL,
    pl_merch_id integer NOT NULL,
    pl_unit_price numeric NOT NULL,
    pl_received_qty numeric(8,2) NOT NULL,
    pl_rejected_qty numeric(8,2) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK ((pl_order_qty > 0)),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK ((pl_received_qty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK ((pl_rejected_qty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK ((pl_unit_price >= 0.00))
);


ALTER TABLE db.pl_purchase_order_detail owner TO postgres;


CREATE TABLE db.pl_purchase_order_header (
    pl_purchase_order_id integer NOT NULL,
    pl_audit_num smallint DEFAULT 0 NOT NULL,
    pl_status smallint DEFAULT 1 NOT NULL,
    pl_employee_id integer NOT NULL,
    pl_seller integer NOT NULL,
    pl_shipment_method integer NOT NULL,
    pl_order_date timestamp without time zone DEFAULT now() NOT NULL,
    pl_shipment_date timestamp without time zone,
    pl_subtotal numeric DEFAULT 0.00 NOT NULL,
    pl_tax_amt numeric DEFAULT 0.00 NOT NULL,
    pl_cargo numeric DEFAULT 0.00 NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderHeader_pl_cargo" CHECK ((pl_cargo >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK (((pl_shipment_date >= pl_order_date) OR (pl_shipment_date IS NULL))),
    CONSTRAINT "CK_PurchaseOrderHeader_pl_status" CHECK (((pl_status >= 1) AND (pl_status <= 4))),
    CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK ((pl_subtotal >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK ((pl_tax_amt >= 0.00))
);


ALTER TABLE db.pl_purchase_order_header owner TO postgres;


CREATE SEQUENCE db.pl_purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_purchaseorderdetail_purchaseorderdetailid_seq owner TO postgres;


-- db.pl_purchaseorderdetail_purchaseorderdetailid_seq OWNED BY db.pl_purchase_order_detail.purchase_order_detail_id;



CREATE SEQUENCE db.pl_purchaseorderheader_purchaseorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_purchaseorderheader_purchaseorderid_seq owner TO postgres;


-- db.pl_purchaseorderheader_purchaseorderid_seq OWNED BY db.pl_purchase_order_header.pl_purchase_order_id;



CREATE TABLE db.pl_sales_order_detail (
    sales_order_id integer NOT NULL,
    sales_order_detail_id integer NOT NULL,
    courier_tracking_number character varying(25),
    order_qty smallint NOT NULL,
    pl_merch_id integer NOT NULL,
    promotion_id integer NOT NULL,
    unit_price numeric NOT NULL,
    unit_price_discount numeric DEFAULT 0.0 NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((order_qty > 0)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unit_price >= 0.00)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unit_price_discount >= 0.00))
);


ALTER TABLE db.pl_sales_order_detail owner TO postgres;


CREATE TABLE db.pl_sales_order_header (
    sales_order_id integer NOT NULL,
    audit_num smallint DEFAULT 0 NOT NULL,
    order_date timestamp without time zone DEFAULT now() NOT NULL,
    pl_due_date timestamp without time zone NOT NULL,
    shipment_date timestamp without time zone,
    pl_status smallint DEFAULT 1 NOT NULL,
    pl_client_id integer NOT NULL,
    salesman_id integer,
    pl_zone_id integer,
    billing_address integer NOT NULL,
    shipping_address integer NOT NULL,
    pl_shipment_method integer NOT NULL,
    pl_bank_card_id integer,
    bank_card_verification_code character varying(15),
    pl_exchange_rate_it integer,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    tax_amt numeric DEFAULT 0.00 NOT NULL,
    pl_cargo numeric DEFAULT 0.00 NOT NULL,
    total_due numeric,
    comment character varying(128),
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ((pl_due_date >= order_date)),
    CONSTRAINT "CK_SalesOrderHeader_pl_cargo" CHECK ((pl_cargo >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (((shipment_date >= order_date) OR (shipment_date IS NULL))),
    CONSTRAINT "CK_SalesOrderHeader_pl_status" CHECK (((pl_status >= 0) AND (pl_status <= 8))),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ((tax_amt >= 0.00))
);


ALTER TABLE db.pl_sales_order_header owner TO postgres;


CREATE TABLE db.pl_sales_order_header_sale_justification (
    sales_order_id integer NOT NULL,
    sale_justification_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_sales_order_header_sale_justification owner TO postgres;


CREATE TABLE db.pl_sales_person (
    pl_business_entity_id integer NOT NULL,
    pl_zone_id integer,
    sales_quota numeric,
    bonus numeric DEFAULT 0.00 NOT NULL,
    commission_pct numeric DEFAULT 0.00 NOT NULL,
    sales_ytd numeric DEFAULT 0.00 NOT NULL,
    sales_last_year numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commission_pct >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK ((sales_last_year >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK ((sales_quota > 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((sales_ytd >= 0.00))
);


ALTER TABLE db.pl_sales_person owner TO postgres;


CREATE TABLE db.pl_sales_person_quota_history (
    pl_business_entity_id integer NOT NULL,
    quota_date timestamp without time zone NOT NULL,
    sales_quota numeric NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((sales_quota > 0.00))
);


ALTER TABLE db.pl_sales_person_quota_history owner TO postgres;


CREATE TABLE db.pl_sale_justification (
    sale_justification_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_sale_justification owner TO postgres;


CREATE TABLE db.pl_sale_tax_pl_rate (
    sale_tax_pl_rate_id integer NOT NULL,
    pl_stat_id integer NOT NULL,
    tax_type smallint NOT NULL,
    tax_pl_rate numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxpl_rate_TaxType" CHECK (((tax_type >= 1) AND (tax_type <= 3)))
);


ALTER TABLE db.pl_sale_tax_pl_rate owner TO postgres;


CREATE TABLE db.pl_sales_zone (
    pl_zone_id integer NOT NULL,
    pl_country_region_code character varying(3) NOT NULL,
    "group" character varying(50) NOT NULL,
    sales_ytd numeric DEFAULT 0.00 NOT NULL,
    sales_last_year numeric DEFAULT 0.00 NOT NULL,
    cost_ytd numeric DEFAULT 0.00 NOT NULL,
    cost_last_year numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK ((cost_last_year >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK ((cost_ytd >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK ((sales_last_year >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK ((sales_ytd >= 0.00))
);


ALTER TABLE db.pl_sales_zone owner TO postgres;


CREATE TABLE db.pl_sales_zone_history (
    pl_business_entity_id integer NOT NULL,
    pl_zone_id integer NOT NULL,
    pl_start_date timestamp without time zone NOT NULL,
    pl_end_date timestamp without time zone,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((pl_end_date >= pl_start_date) OR (pl_end_date IS NULL)))
);


ALTER TABLE db.pl_sales_zone_history owner TO postgres;


CREATE SEQUENCE db.pl_salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesorderdetail_salesorderdetailid_seq owner TO postgres;


-- db.pl_salesorderdetail_salesorderdetailid_seq OWNED BY db.pl_sales_order_detail.sales_order_detail_id;



CREATE SEQUENCE db.pl_salesorderheader_salesorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesorderheader_salesorderid_seq owner TO postgres;


-- db.pl_salesorderheader_salesorderid_seq OWNED BY db.pl_sales_order_header.sales_order_id;



CREATE SEQUENCE db.pl_salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesreason_salesreasonid_seq owner TO postgres;


-- db.pl_salesreason_salesreasonid_seq OWNED BY db.pl_sale_justification.sale_justification_id;



CREATE SEQUENCE db.pl_salestaxpl_rate_salestaxpl_rateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salestaxpl_rate_salestaxpl_rateid_seq owner TO postgres;


-- db.pl_salestaxpl_rate_salestaxpl_rateid_seq OWNED BY db.pl_sale_tax_pl_rate.sale_tax_pl_rate_id;



CREATE SEQUENCE db.pl_salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesterritory_territoryid_seq owner TO postgres;


-- db.pl_salesterritory_territoryid_seq OWNED BY db.pl_sales_zone.pl_zone_id;



CREATE TABLE db.pl_scrap_reason (
    scrap_reason_id integer NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_scrap_reason owner TO postgres;


CREATE SEQUENCE db.pl_scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_scrapreason_scrapreasonid_seq owner TO postgres;


-- db.pl_scrapreason_scrapreasonid_seq OWNED BY db.pl_scrap_reason.scrap_reason_id;



CREATE TABLE db.pl_shift (
    pl_shift_id integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_shift owner TO postgres;


CREATE TABLE db.pl_ship_method (
    pl_shipment_method integer NOT NULL,
    ship_base numeric DEFAULT 0.00 NOT NULL,
    ship_pl_rate numeric DEFAULT 0.00 NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((ship_base > 0.00)),
    CONSTRAINT "CK_ShipMethod_Shippl_rate" CHECK ((ship_pl_rate > 0.00))
);


ALTER TABLE db.pl_ship_method owner TO postgres;


CREATE SEQUENCE db.pl_shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_shipmethod_shipmethodid_seq owner TO postgres;


-- db.pl_shipmethod_shipmethodid_seq OWNED BY db.pl_ship_method.pl_shipment_method;



CREATE TABLE db.pl_shopping_cart_item (
    shopping_cart_item_id integer NOT NULL,
    shopping_cart_id character varying(50) NOT NULL,
    amount integer DEFAULT 1 NOT NULL,
    pl_merch_id integer NOT NULL,
    date_created timestamp without time zone DEFAULT now() NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_amount" CHECK ((amount >= 1))
);


ALTER TABLE db.pl_shopping_cart_item owner TO postgres;


CREATE SEQUENCE db.pl_shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_shoppingcartitem_shoppingcartitemid_seq owner TO postgres;


-- db.pl_shoppingcartitem_shoppingcartitemid_seq OWNED BY db.pl_shopping_cart_item.shopping_cart_item_id;



CREATE TABLE db.pl_special_offer (
    promotion_id integer NOT NULL,
    description character varying(255) NOT NULL,
    discount_pct numeric DEFAULT 0.00 NOT NULL,
    type character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    pl_start_date timestamp without time zone NOT NULL,
    pl_end_date timestamp without time zone NOT NULL,
    min_qty integer DEFAULT 0 NOT NULL,
    max_qty integer,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK ((discount_pct >= 0.00)),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK ((pl_end_date >= pl_start_date)),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK ((max_qty >= 0)),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK ((min_qty >= 0))
);


ALTER TABLE db.pl_special_offer owner TO postgres;


CREATE TABLE db.pl_special_offer_merchandise (
    promotion_id integer NOT NULL,
    pl_merch_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_special_offer_merchandise owner TO postgres;


CREATE SEQUENCE db.pl_specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_specialoffer_specialofferid_seq owner TO postgres;


-- db.pl_specialoffer_specialofferid_seq OWNED BY db.pl_special_offer.promotion_id;



CREATE TABLE db.pl_state_province (
    pl_stat_id integer NOT NULL,
    state_province_code character(3) NOT NULL,
    pl_country_region_code character varying(3) NOT NULL,
    pl_zone_id integer NOT NULL,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_state_province owner TO postgres;


CREATE SEQUENCE db.pl_stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_stateprovince_stateprovinceid_seq owner TO postgres;


-- db.pl_stateprovince_stateprovinceid_seq OWNED BY db.pl_state_province.pl_stat_id;



CREATE TABLE db.pl_store (
    pl_business_entity_id integer NOT NULL,
    salesman_id integer,
    demographics xml,
    row_guid uuid NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_store owner TO postgres;


CREATE TABLE db.pl_transaction_history (
    transaction_id integer NOT NULL,
    pl_merch_id integer NOT NULL,
    order_ref_id integer NOT NULL,
    transaction_date timestamp without time zone DEFAULT now() NOT NULL,
    transaction_type character(1) NOT NULL,
    amount integer NOT NULL,
    real_price numeric NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK ((upper((transaction_type)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE db.pl_transaction_history owner TO postgres;


CREATE TABLE db.pl_transaction_history_archive (
    transaction_id integer NOT NULL,
    pl_merch_id integer NOT NULL,
    order_ref_id integer NOT NULL,
    transaction_date timestamp without time zone DEFAULT now() NOT NULL,
    transaction_type character(1) NOT NULL,
    amount integer NOT NULL,
    real_price numeric NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK ((upper((transaction_type)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE db.pl_transaction_history_archive owner TO postgres;


CREATE SEQUENCE db.pl_transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_transactionhistory_transactionid_seq owner TO postgres;


-- db.pl_transactionhistory_transactionid_seq OWNED BY db.pl_transaction_history.transaction_id;



CREATE TABLE db.pl_unit_measure (
    pl_unit_measure_code character(3) NOT NULL,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_unit_measure owner TO postgres;


CREATE TABLE db.pl_pl_seller (
    pl_business_entity_id integer NOT NULL,
    credit_score smallint NOT NULL,
    purchase_webpage_address character varying(1024),
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((credit_score >= 1) AND (credit_score <= 5)))
);


ALTER TABLE db.pl_pl_seller owner TO postgres;


CREATE TABLE db.pl_work_order (
    work_order_id integer NOT NULL,
    pl_merch_id integer NOT NULL,
    order_qty integer NOT NULL,
    scrapped_qty smallint NOT NULL,
    pl_start_date timestamp without time zone NOT NULL,
    pl_end_date timestamp without time zone,
    pl_due_date timestamp without time zone NOT NULL,
    scrap_reason_id smallint,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrder_EndDate" CHECK (((pl_end_date >= pl_start_date) OR (pl_end_date IS NULL))),
    CONSTRAINT "CK_WorkOrder_OrderQty" CHECK ((order_qty > 0)),
    CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK ((scrapped_qty >= 0))
);


ALTER TABLE db.pl_work_order owner TO postgres;


CREATE TABLE db.pl_work_order_routing (
    work_order_id integer NOT NULL,
    pl_merch_id integer NOT NULL,
    operation_sequence smallint NOT NULL,
    pl_location_id smallint NOT NULL,
    planned_starting_time timestamp without time zone NOT NULL,
    planned_ending_time timestamp without time zone NOT NULL,
    actual_pl_start_date timestamp without time zone,
    actual_pl_end_date timestamp without time zone,
    actual_resource_hrs numeric(9,4),
    expected_price numeric NOT NULL,
    real_price numeric,
    pl_modification_timestamp timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK ((real_price > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK (((actual_pl_end_date >= actual_pl_start_date) OR (actual_pl_end_date IS NULL) OR (actual_pl_start_date IS NULL))),
    CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK ((actual_resource_hrs >= 0.0000)),
    CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK ((expected_price > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK ((planned_ending_time >= planned_starting_time))
);


ALTER TABLE db.pl_work_order_routing owner TO postgres;


CREATE SEQUENCE db.pl_workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_workorder_workorderid_seq owner TO postgres;


-- db.pl_workorder_workorderid_seq OWNED BY db.pl_work_order.work_order_id;



ALTER TABLE ONLY db.pl_address ALTER COLUMN pl_address_id SET DEFAULT nextval('db.pl_address_addressid_seq'::regclass);



ALTER TABLE ONLY db.pl_address_type ALTER COLUMN pl_address_type_id SET DEFAULT nextval('db.pl_addresstype_addresstypeid_seq'::regclass);



ALTER TABLE ONLY db.pl_bom ALTER COLUMN pl_bom_id SET DEFAULT nextval('db.pl_billofmaterials_billofmaterialsid_seq'::regclass);



ALTER TABLE ONLY db.pl_business_entity ALTER COLUMN pl_business_entity_id SET DEFAULT nextval('db.pl_businessentity_businessentityid_seq'::regclass);



ALTER TABLE ONLY db.pl_contact_type ALTER COLUMN pl_contact_type_id SET DEFAULT nextval('db.pl_contacttype_contacttypeid_seq'::regclass);



ALTER TABLE ONLY db.pl_credit_card ALTER COLUMN pl_bank_card_id SET DEFAULT nextval('db.pl_creditcard_creditcardid_seq'::regclass);



ALTER TABLE ONLY db.pl_exchange_pl_rate ALTER COLUMN pl_exchange_rate_it SET DEFAULT nextval('db.pl_currencypl_rate_currencypl_rateid_seq'::regclass);



ALTER TABLE ONLY db.pl_client ALTER COLUMN pl_client_id SET DEFAULT nextval('db.pl_client_clientid_seq'::regclass);



ALTER TABLE ONLY db.pl_email ALTER COLUMN pl_email_id SET DEFAULT nextval('db.pl_emailaddress_emailaddressid_seq'::regclass);



ALTER TABLE ONLY db.pl_graphic ALTER COLUMN pl_graphic_id SET DEFAULT nextval('db.pl_graphic_graphicid_seq'::regclass);



ALTER TABLE ONLY db.pl_job_candidate ALTER COLUMN pl_job_candidate_id SET DEFAULT nextval('db.pl_jobcandidate_jobcandidateid_seq'::regclass);



ALTER TABLE ONLY db.pl_location ALTER COLUMN pl_location_id SET DEFAULT nextval('db.pl_location_locationid_seq'::regclass);



ALTER TABLE ONLY db.pl_phone_number_type ALTER COLUMN pl_phone_number_type_id SET DEFAULT nextval('db.pl_phonenumbertype_phonenumbertypeid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise ALTER COLUMN pl_merch_id SET DEFAULT nextval('db.pl_merchandise_merchandiseid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise_category ALTER COLUMN pl_merchandise_category_id SET DEFAULT nextval('db.pl_merchandisecategory_merchandisecategoryid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise_description ALTER COLUMN merch_descr_id SET DEFAULT nextval('db.pl_merchandisedescription_merchandisedescriptionid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise_model ALTER COLUMN merchandise_model_id SET DEFAULT nextval('db.pl_merchandisemodel_merchandisemodelid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise_image ALTER COLUMN merchandise_image_id SET DEFAULT nextval('db.pl_merchandiseimage_merchandiseimageid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise_review ALTER COLUMN merchandise_review_id SET DEFAULT nextval('db.pl_merchandisereview_merchandisereviewid_seq'::regclass);



ALTER TABLE ONLY db.pl_merchandise_subcategory ALTER COLUMN pl_merchandise_subcategory_id SET DEFAULT nextval('db.pl_merchandisesubcategory_merchandisesubcategoryid_seq'::regclass);



ALTER TABLE ONLY db.pl_purchase_order_detail ALTER COLUMN purchase_order_detail_id SET DEFAULT nextval('db.pl_purchaseorderdetail_purchaseorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.pl_purchase_order_header ALTER COLUMN pl_purchase_order_id SET DEFAULT nextval('db.pl_purchaseorderheader_purchaseorderid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_order_detail ALTER COLUMN sales_order_detail_id SET DEFAULT nextval('db.pl_salesorderdetail_salesorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_order_header ALTER COLUMN sales_order_id SET DEFAULT nextval('db.pl_salesorderheader_salesorderid_seq'::regclass);



ALTER TABLE ONLY db.pl_sale_justification ALTER COLUMN sale_justification_id SET DEFAULT nextval('db.pl_salesreason_salesreasonid_seq'::regclass);



ALTER TABLE ONLY db.pl_sale_tax_pl_rate ALTER COLUMN sale_tax_pl_rate_id SET DEFAULT nextval('db.pl_salestaxpl_rate_salestaxpl_rateid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_zone ALTER COLUMN pl_zone_id SET DEFAULT nextval('db.pl_salesterritory_territoryid_seq'::regclass);



ALTER TABLE ONLY db.pl_scrap_reason ALTER COLUMN scrap_reason_id SET DEFAULT nextval('db.pl_scrapreason_scrapreasonid_seq'::regclass);



ALTER TABLE ONLY db.pl_ship_method ALTER COLUMN pl_shipment_method SET DEFAULT nextval('db.pl_shipmethod_shipmethodid_seq'::regclass);



ALTER TABLE ONLY db.pl_shopping_cart_item ALTER COLUMN shopping_cart_item_id SET DEFAULT nextval('db.pl_shoppingcartitem_shoppingcartitemid_seq'::regclass);



ALTER TABLE ONLY db.pl_special_offer ALTER COLUMN promotion_id SET DEFAULT nextval('db.pl_specialoffer_specialofferid_seq'::regclass);



ALTER TABLE ONLY db.pl_state_province ALTER COLUMN pl_stat_id SET DEFAULT nextval('db.pl_stateprovince_stateprovinceid_seq'::regclass);



ALTER TABLE ONLY db.pl_transaction_history ALTER COLUMN transaction_id SET DEFAULT nextval('db.pl_transactionhistory_transactionid_seq'::regclass);



ALTER TABLE ONLY db.pl_work_order ALTER COLUMN work_order_id SET DEFAULT nextval('db.pl_workorder_workorderid_seq'::regclass);



ALTER TABLE ONLY db.pl_address_type
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (pl_address_type_id);

ALTER TABLE db.pl_address_type CLUSTER ON "PK_AddressType_AddressTypeID";



ALTER TABLE ONLY db.pl_address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (pl_address_id);

ALTER TABLE db.pl_address CLUSTER ON "PK_Address_AddressID";



ALTER TABLE ONLY db.pl_bom
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (pl_bom_id);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (pl_business_entity_id, pl_address_id, pl_address_type_id);

ALTER TABLE db.pl_business_entity_address CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (pl_business_entity_id, pl_person_id, pl_contact_type_id);

ALTER TABLE db.pl_business_entity_contact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";



ALTER TABLE ONLY db.pl_business_entity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (pl_business_entity_id);

ALTER TABLE db.pl_business_entity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";



ALTER TABLE ONLY db.pl_contact_type
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (pl_contact_type_id);

ALTER TABLE db.pl_contact_type CLUSTER ON "PK_ContactType_ContactTypeID";



ALTER TABLE ONLY db.pl_country_region_currency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (pl_country_region_code, pl_currency_code);

ALTER TABLE db.pl_country_region_currency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";



ALTER TABLE ONLY db.pl_country_region
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (pl_country_region_code);

ALTER TABLE db.pl_country_region CLUSTER ON "PK_CountryRegion_CountryRegionCode";



ALTER TABLE ONLY db.pl_credit_card
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (pl_bank_card_id);

ALTER TABLE db.pl_credit_card CLUSTER ON "PK_CreditCard_CreditCardID";



ALTER TABLE ONLY db.pl_culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (pl_culture_id);

ALTER TABLE db.pl_culture CLUSTER ON "PK_Culture_CultureID";



ALTER TABLE ONLY db.pl_exchange_pl_rate
    ADD CONSTRAINT "PK_Currencypl_rate_Currencypl_rateID" PRIMARY KEY (pl_exchange_rate_it);

ALTER TABLE db.pl_exchange_pl_rate CLUSTER ON "PK_Currencypl_rate_Currencypl_rateID";



ALTER TABLE ONLY db.pl_currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (pl_currency_code);

ALTER TABLE db.pl_currency CLUSTER ON "PK_Currency_CurrencyCode";



ALTER TABLE ONLY db.pl_client
    ADD CONSTRAINT "PK_client_clientID" PRIMARY KEY (pl_client_id);

ALTER TABLE db.pl_client CLUSTER ON "PK_client_clientID";



ALTER TABLE ONLY db.pl_department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (pl_department_id);

ALTER TABLE db.pl_department CLUSTER ON "PK_Department_DepartmentID";



ALTER TABLE ONLY db.pl_document
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (pl_document_node);

ALTER TABLE db.pl_document CLUSTER ON "PK_Document_DocumentNode";



ALTER TABLE ONLY db.pl_email
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (pl_business_entity_id, pl_email_id);

ALTER TABLE db.pl_email CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";



ALTER TABLE ONLY db.pl_employee_department_history
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (pl_business_entity_id, pl_start_date, pl_department_id, pl_shift_id);

ALTER TABLE db.pl_employee_department_history CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";



ALTER TABLE ONLY db.pl_employee_wage_history
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_pl_rateChangeDate" PRIMARY KEY (pl_business_entity_id, pl_last_wage_change);

ALTER TABLE db.pl_employee_wage_history CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_pl_rateChangeDate";



ALTER TABLE ONLY db.pl_graphic
    ADD CONSTRAINT "PK_graphic_graphicID" PRIMARY KEY (pl_graphic_id);

ALTER TABLE db.pl_graphic CLUSTER ON "PK_graphic_graphicID";



ALTER TABLE ONLY db.pl_job_candidate
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (pl_job_candidate_id);

ALTER TABLE db.pl_job_candidate CLUSTER ON "PK_JobCandidate_JobCandidateID";



ALTER TABLE ONLY db.pl_location
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (pl_location_id);

ALTER TABLE db.pl_location CLUSTER ON "PK_Location_LocationID";



ALTER TABLE ONLY db.pl_password
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (pl_business_entity_id);

ALTER TABLE db.pl_password CLUSTER ON "PK_Password_BusinessEntityID";



ALTER TABLE ONLY db.pl_person_credit_card
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (pl_business_entity_id, pl_bank_card_id);

ALTER TABLE db.pl_person_credit_card CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";



ALTER TABLE ONLY db.pl_person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (pl_business_entity_id);

ALTER TABLE db.pl_person CLUSTER ON "PK_Person_BusinessEntityID";



ALTER TABLE ONLY db.pl_phone_number_type
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (pl_phone_number_type_id);

ALTER TABLE db.pl_phone_number_type CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";



ALTER TABLE ONLY db.pl_merchandise_category
    ADD CONSTRAINT "PK_merchandiseCategory_merchandiseCategoryID" PRIMARY KEY (pl_merchandise_category_id);

ALTER TABLE db.pl_merchandise_category CLUSTER ON "PK_merchandiseCategory_merchandiseCategoryID";



ALTER TABLE ONLY db.pl_merchandise_cost_history
    ADD CONSTRAINT "PK_merchandiseCostHistory_merchandiseID_StartDate" PRIMARY KEY (pl_merch_id, pl_start_date);

ALTER TABLE db.pl_merchandise_cost_history CLUSTER ON "PK_merchandiseCostHistory_merchandiseID_StartDate";



ALTER TABLE ONLY db.pl_merchandise_description
    ADD CONSTRAINT "PK_merchandiseDescription_merchandiseDescriptionID" PRIMARY KEY (merch_descr_id);

ALTER TABLE db.pl_merchandise_description CLUSTER ON "PK_merchandiseDescription_merchandiseDescriptionID";



ALTER TABLE ONLY db.pl_merchandise_document
    ADD CONSTRAINT "PK_merchandiseDocument_merchandiseID_DocumentNode" PRIMARY KEY (pl_merch_id, pl_document_node);

ALTER TABLE db.pl_merchandise_document CLUSTER ON "PK_merchandiseDocument_merchandiseID_DocumentNode";



ALTER TABLE ONLY db.pl_merchandise_stock
    ADD CONSTRAINT "PK_merchandiseInventory_merchandiseID_LocationID" PRIMARY KEY (pl_merch_id, pl_location_id);

ALTER TABLE db.pl_merchandise_stock CLUSTER ON "PK_merchandiseInventory_merchandiseID_LocationID";



ALTER TABLE ONLY db.pl_merchandise_list_price_history
    ADD CONSTRAINT "PK_merchandiseListPriceHistory_merchandiseID_StartDate" PRIMARY KEY (pl_merch_id, pl_start_date);

ALTER TABLE db.pl_merchandise_list_price_history CLUSTER ON "PK_merchandiseListPriceHistory_merchandiseID_StartDate";



ALTER TABLE ONLY db.pl_merchandise_model_graphic
    ADD CONSTRAINT "PK_merchandiseModelgraphic_merchandiseModelID_graphicID" PRIMARY KEY (merchandise_model_id, pl_graphic_id);

ALTER TABLE db.pl_merchandise_model_graphic CLUSTER ON "PK_merchandiseModelgraphic_merchandiseModelID_graphicID";



ALTER TABLE ONLY db.pl_merchandise_model_merchandise_description_culture
    ADD CONSTRAINT "PK_merchandiseModelmerchandiseDescriptionCulture_merchandiseModelID_merchandise" PRIMARY KEY (merchandise_model_id, merch_descr_id, pl_culture_id);

ALTER TABLE db.pl_merchandise_model_merchandise_description_culture CLUSTER ON "PK_merchandiseModelmerchandiseDescriptionCulture_merchandiseModelID_merchandise";



ALTER TABLE ONLY db.pl_merchandise_model
    ADD CONSTRAINT "PK_merchandiseModel_merchandiseModelID" PRIMARY KEY (merchandise_model_id);

ALTER TABLE db.pl_merchandise_model CLUSTER ON "PK_merchandiseModel_merchandiseModelID";



ALTER TABLE ONLY db.pl_merchandise_image
    ADD CONSTRAINT "PK_merchandiseimage_merchandiseimageID" PRIMARY KEY (merchandise_image_id);

ALTER TABLE db.pl_merchandise_image CLUSTER ON "PK_merchandiseimage_merchandiseimageID";



ALTER TABLE ONLY db.pl_merchandise_merchandise_image
    ADD CONSTRAINT "PK_merchandisemerchandiseimage_merchandiseID_merchandiseimageID" PRIMARY KEY (pl_merch_id, merchandise_image_id);



ALTER TABLE ONLY db.pl_merchandise_review
    ADD CONSTRAINT "PK_merchandiseReview_merchandiseReviewID" PRIMARY KEY (merchandise_review_id);

ALTER TABLE db.pl_merchandise_review CLUSTER ON "PK_merchandiseReview_merchandiseReviewID";



ALTER TABLE ONLY db.pl_merchandise_subcategory
    ADD CONSTRAINT "PK_merchandiseSubcategory_merchandiseSubcategoryID" PRIMARY KEY (pl_merchandise_subcategory_id);

ALTER TABLE db.pl_merchandise_subcategory CLUSTER ON "PK_merchandiseSubcategory_merchandiseSubcategoryID";



ALTER TABLE ONLY db.pl_merchandise_vendor
    ADD CONSTRAINT "PK_merchandiseVendor_merchandiseID_BusinessEntityID" PRIMARY KEY (pl_merch_id, pl_business_entity_id);

ALTER TABLE db.pl_merchandise_vendor CLUSTER ON "PK_merchandiseVendor_merchandiseID_BusinessEntityID";



ALTER TABLE ONLY db.pl_merchandise
    ADD CONSTRAINT "PK_merchandise_merchandiseID" PRIMARY KEY (pl_merch_id);

ALTER TABLE db.pl_merchandise CLUSTER ON "PK_merchandise_merchandiseID";



ALTER TABLE ONLY db.pl_purchase_order_detail
    ADD CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (pl_purchase_order_id, purchase_order_detail_id);

ALTER TABLE db.pl_purchase_order_detail CLUSTER ON "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";



ALTER TABLE ONLY db.pl_purchase_order_header
    ADD CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (pl_purchase_order_id);

ALTER TABLE db.pl_purchase_order_header CLUSTER ON "PK_PurchaseOrderHeader_PurchaseOrderID";



ALTER TABLE ONLY db.pl_sales_order_detail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (sales_order_id, sales_order_detail_id);

ALTER TABLE db.pl_sales_order_detail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";



ALTER TABLE ONLY db.pl_sales_order_header_sale_justification
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (sales_order_id, sale_justification_id);

ALTER TABLE db.pl_sales_order_header_sale_justification CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (sales_order_id);

ALTER TABLE db.pl_sales_order_header CLUSTER ON "PK_SalesOrderHeader_SalesOrderID";



ALTER TABLE ONLY db.pl_sales_person_quota_history
    ADD CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (pl_business_entity_id, quota_date);

ALTER TABLE db.pl_sales_person_quota_history CLUSTER ON "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";



ALTER TABLE ONLY db.pl_sales_person
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (pl_business_entity_id);

ALTER TABLE db.pl_sales_person CLUSTER ON "PK_SalesPerson_BusinessEntityID";



ALTER TABLE ONLY db.pl_sale_justification
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (sale_justification_id);

ALTER TABLE db.pl_sale_justification CLUSTER ON "PK_SalesReason_SalesReasonID";



ALTER TABLE ONLY db.pl_sale_tax_pl_rate
    ADD CONSTRAINT "PK_SalesTaxpl_rate_SalesTaxpl_rateID" PRIMARY KEY (sale_tax_pl_rate_id);

ALTER TABLE db.pl_sale_tax_pl_rate CLUSTER ON "PK_SalesTaxpl_rate_SalesTaxpl_rateID";



ALTER TABLE ONLY db.pl_sales_zone_history
    ADD CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (pl_business_entity_id, pl_start_date, pl_zone_id);

ALTER TABLE db.pl_sales_zone_history CLUSTER ON "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";



ALTER TABLE ONLY db.pl_sales_zone
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (pl_zone_id);

ALTER TABLE db.pl_sales_zone CLUSTER ON "PK_SalesTerritory_TerritoryID";



ALTER TABLE ONLY db.pl_scrap_reason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrap_reason_id);

ALTER TABLE db.pl_scrap_reason CLUSTER ON "PK_ScrapReason_ScrapReasonID";



ALTER TABLE ONLY db.pl_shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (pl_shift_id);

ALTER TABLE db.pl_shift CLUSTER ON "PK_Shift_ShiftID";



ALTER TABLE ONLY db.pl_ship_method
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (pl_shipment_method);

ALTER TABLE db.pl_ship_method CLUSTER ON "PK_ShipMethod_ShipMethodID";



ALTER TABLE ONLY db.pl_shopping_cart_item
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shopping_cart_item_id);

ALTER TABLE db.pl_shopping_cart_item CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";



ALTER TABLE ONLY db.pl_special_offer_merchandise
    ADD CONSTRAINT "PK_SpecialOffermerchandise_SpecialOfferID_merchandiseID" PRIMARY KEY (promotion_id, pl_merch_id);

ALTER TABLE db.pl_special_offer_merchandise CLUSTER ON "PK_SpecialOffermerchandise_SpecialOfferID_merchandiseID";



ALTER TABLE ONLY db.pl_special_offer
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (promotion_id);

ALTER TABLE db.pl_special_offer CLUSTER ON "PK_SpecialOffer_SpecialOfferID";



ALTER TABLE ONLY db.pl_state_province
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (pl_stat_id);

ALTER TABLE db.pl_state_province CLUSTER ON "PK_StateProvince_StateProvinceID";



ALTER TABLE ONLY db.pl_store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (pl_business_entity_id);

ALTER TABLE db.pl_store CLUSTER ON "PK_Store_BusinessEntityID";



ALTER TABLE ONLY db.pl_transaction_history_archive
    ADD CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE db.pl_transaction_history_archive CLUSTER ON "PK_TransactionHistoryArchive_TransactionID";



ALTER TABLE ONLY db.pl_transaction_history
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE db.pl_transaction_history CLUSTER ON "PK_TransactionHistory_TransactionID";



ALTER TABLE ONLY db.pl_unit_measure
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (pl_unit_measure_code);

ALTER TABLE db.pl_unit_measure CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";



ALTER TABLE ONLY db.pl_pl_seller
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (pl_business_entity_id);

ALTER TABLE db.pl_pl_seller CLUSTER ON "PK_Vendor_BusinessEntityID";



ALTER TABLE ONLY db.pl_work_order_routing
    ADD CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_merchandiseID_OperationSequence" PRIMARY KEY (work_order_id, pl_merch_id, operation_sequence);

ALTER TABLE db.pl_work_order_routing CLUSTER ON "PK_WorkOrderRouting_WorkOrderID_merchandiseID_OperationSequence";



ALTER TABLE ONLY db.pl_work_order
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (work_order_id);

ALTER TABLE db.pl_work_order CLUSTER ON "PK_WorkOrder_WorkOrderID";



ALTER TABLE ONLY db.pl_document
    ADD CONSTRAINT document_rowguid_key UNIQUE (row_guid);



ALTER TABLE ONLY db.pl_address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (pl_stat_id) REFERENCES db.pl_state_province(pl_stat_id);



ALTER TABLE ONLY db.pl_bom
    ADD CONSTRAINT "FK_BillOfMaterials_merchandise_ComponentID" FOREIGN KEY (pl_component_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_bom
    ADD CONSTRAINT "FK_BillOfMaterials_merchandise_merchandiseAssemblyID" FOREIGN KEY (pl_merchandise_assembly_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_bom
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (pl_unit_measure_code) REFERENCES db.pl_unit_measure(pl_unit_measure_code);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (pl_address_type_id) REFERENCES db.pl_address_type(pl_address_type_id);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (pl_address_id) REFERENCES db.pl_address(pl_address_id);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_business_entity(pl_business_entity_id);



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_business_entity(pl_business_entity_id);



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (pl_contact_type_id) REFERENCES db.pl_contact_type(pl_contact_type_id);



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (pl_person_id) REFERENCES db.pl_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (pl_country_region_code) REFERENCES db.pl_country_region(pl_country_region_code);



ALTER TABLE ONLY db.pl_country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (pl_currency_code) REFERENCES db.pl_currency(pl_currency_code);



ALTER TABLE ONLY db.pl_exchange_pl_rate
    ADD CONSTRAINT "FK_Currencypl_rate_Currency_FromCurrencyCode" FOREIGN KEY (pl_from_currency_code) REFERENCES db.pl_currency(pl_currency_code);



ALTER TABLE ONLY db.pl_exchange_pl_rate
    ADD CONSTRAINT "FK_Currencypl_rate_Currency_ToCurrencyCode" FOREIGN KEY (pl_to_currency_code) REFERENCES db.pl_currency(pl_currency_code);



ALTER TABLE ONLY db.pl_client
    ADD CONSTRAINT "FK_client_Person_PersonID" FOREIGN KEY (pl_person_id) REFERENCES db.pl_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_client
    ADD CONSTRAINT "FK_client_SalesTerritory_TerritoryID" FOREIGN KEY (pl_zone_id) REFERENCES db.pl_sales_zone(pl_zone_id);



ALTER TABLE ONLY db.pl_client
    ADD CONSTRAINT "FK_client_Store_StoreID" FOREIGN KEY (pl_shop_id) REFERENCES db.pl_store(pl_business_entity_id);



ALTER TABLE ONLY db.pl_email
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (pl_department_id) REFERENCES db.pl_department(pl_department_id);



ALTER TABLE ONLY db.pl_employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (pl_shift_id) REFERENCES db.pl_shift(pl_shift_id);



ALTER TABLE ONLY db.pl_password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (pl_bank_card_id) REFERENCES db.pl_credit_card(pl_bank_card_id);



ALTER TABLE ONLY db.pl_person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_person_phone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_person_phone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (pl_phone_number_type_id) REFERENCES db.pl_phone_number_type(pl_phone_number_type_id);



ALTER TABLE ONLY db.pl_person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_business_entity(pl_business_entity_id);



ALTER TABLE ONLY db.pl_merchandise_cost_history
    ADD CONSTRAINT "FK_merchandiseCostHistory_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_merchandise_document
    ADD CONSTRAINT "FK_merchandiseDocument_Document_DocumentNode" FOREIGN KEY (pl_document_node) REFERENCES db.pl_document(pl_document_node);



ALTER TABLE ONLY db.pl_merchandise_document
    ADD CONSTRAINT "FK_merchandiseDocument_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_merchandise_stock
    ADD CONSTRAINT "FK_merchandiseInventory_Location_LocationID" FOREIGN KEY (pl_location_id) REFERENCES db.pl_location(pl_location_id);



ALTER TABLE ONLY db.pl_merchandise_stock
    ADD CONSTRAINT "FK_merchandiseInventory_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_merchandise_list_price_history
    ADD CONSTRAINT "FK_merchandiseListPriceHistory_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_merchandise_model_graphic
    ADD CONSTRAINT "FK_merchandiseModelgraphic_graphic_graphicID" FOREIGN KEY (pl_graphic_id) REFERENCES db.pl_graphic(pl_graphic_id);



ALTER TABLE ONLY db.pl_merchandise_model_graphic
    ADD CONSTRAINT "FK_merchandiseModelgraphic_merchandiseModel_merchandiseModelID" FOREIGN KEY (merchandise_model_id) REFERENCES db.pl_merchandise_model(merchandise_model_id);



ALTER TABLE ONLY db.pl_merchandise_model_merchandise_description_culture
    ADD CONSTRAINT "FK_merchandiseModelmerchandiseDescriptionCulture_Culture_CultureID" FOREIGN KEY (pl_culture_id) REFERENCES db.pl_culture(pl_culture_id);



ALTER TABLE ONLY db.pl_merchandise_model_merchandise_description_culture
    ADD CONSTRAINT "FK_merchandiseModelmerchandiseDescriptionCulture_merchandiseDescription_Pro" FOREIGN KEY (merch_descr_id) REFERENCES db.pl_merchandise_description(merch_descr_id);



ALTER TABLE ONLY db.pl_merchandise_model_merchandise_description_culture
    ADD CONSTRAINT "FK_merchandiseModelmerchandiseDescriptionCulture_merchandiseModel_merchandiseMo" FOREIGN KEY (merchandise_model_id) REFERENCES db.pl_merchandise_model(merchandise_model_id);



ALTER TABLE ONLY db.pl_merchandise_merchandise_image
    ADD CONSTRAINT "FK_merchandisemerchandiseimage_merchandiseimage_merchandiseimageID" FOREIGN KEY (merchandise_image_id) REFERENCES db.pl_merchandise_image(merchandise_image_id);



ALTER TABLE ONLY db.pl_merchandise_merchandise_image
    ADD CONSTRAINT "FK_merchandisemerchandiseimage_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_merchandise_subcategory
    ADD CONSTRAINT "FK_merchandiseSubcategory_merchandiseCategory_merchandiseCategoryID" FOREIGN KEY (pl_merchandise_category_id) REFERENCES db.pl_merchandise_category(pl_merchandise_category_id);



ALTER TABLE ONLY db.pl_merchandise_vendor
    ADD CONSTRAINT "FK_merchandiseVendor_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_merchandise_vendor
    ADD CONSTRAINT "FK_merchandiseVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (pl_unit_measure_code) REFERENCES db.pl_unit_measure(pl_unit_measure_code);



ALTER TABLE ONLY db.pl_merchandise_vendor
    ADD CONSTRAINT "FK_merchandiseVendor_Vendor_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_pl_seller(pl_business_entity_id);



ALTER TABLE ONLY db.pl_merchandise
    ADD CONSTRAINT "FK_merchandise_merchandiseModel_merchandiseModelID" FOREIGN KEY (merchandise_model_id) REFERENCES db.pl_merchandise_model(merchandise_model_id);



ALTER TABLE ONLY db.pl_merchandise
    ADD CONSTRAINT "FK_merchandise_merchandiseSubcategory_merchandiseSubcategoryID" FOREIGN KEY (pl_merchandise_subcategory_id) REFERENCES db.pl_merchandise_subcategory(pl_merchandise_subcategory_id);



ALTER TABLE ONLY db.pl_merchandise
    ADD CONSTRAINT "FK_merchandise_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (size_pl_unit_measure_code) REFERENCES db.pl_unit_measure(pl_unit_measure_code);



ALTER TABLE ONLY db.pl_merchandise
    ADD CONSTRAINT "FK_merchandise_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weight_pl_unit_measure_code) REFERENCES db.pl_unit_measure(pl_unit_measure_code);



ALTER TABLE ONLY db.pl_purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (pl_purchase_order_id) REFERENCES db.pl_purchase_order_header(pl_purchase_order_id);



ALTER TABLE ONLY db.pl_purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (pl_shipment_method) REFERENCES db.pl_ship_method(pl_shipment_method);



ALTER TABLE ONLY db.pl_purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (pl_seller) REFERENCES db.pl_pl_seller(pl_business_entity_id);



ALTER TABLE ONLY db.pl_sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (sales_order_id) REFERENCES db.pl_sales_order_header(sales_order_id) ON DELETE CASCADE;



ALTER TABLE ONLY db.pl_sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOffermerchandise_SpecialOfferIDmerchandiseID" FOREIGN KEY (promotion_id, pl_merch_id) REFERENCES db.pl_special_offer_merchandise(promotion_id, pl_merch_id);



ALTER TABLE ONLY db.pl_sales_order_header_sale_justification
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (sales_order_id) REFERENCES db.pl_sales_order_header(sales_order_id) ON DELETE CASCADE;



ALTER TABLE ONLY db.pl_sales_order_header_sale_justification
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (sale_justification_id) REFERENCES db.pl_sale_justification(sale_justification_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (billing_address) REFERENCES db.pl_address(pl_address_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (shipping_address) REFERENCES db.pl_address(pl_address_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (pl_bank_card_id) REFERENCES db.pl_credit_card(pl_bank_card_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Currencypl_rate_Currencypl_rateID" FOREIGN KEY (pl_exchange_rate_it) REFERENCES db.pl_exchange_pl_rate(pl_exchange_rate_it);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_client_clientID" FOREIGN KEY (pl_client_id) REFERENCES db.pl_client(pl_client_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (salesman_id) REFERENCES db.pl_sales_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (pl_zone_id) REFERENCES db.pl_sales_zone(pl_zone_id);



ALTER TABLE ONLY db.pl_sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (pl_shipment_method) REFERENCES db.pl_ship_method(pl_shipment_method);



ALTER TABLE ONLY db.pl_sales_person_quota_history
    ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_sales_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_sales_person
    ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (pl_zone_id) REFERENCES db.pl_sales_zone(pl_zone_id);



ALTER TABLE ONLY db.pl_sale_tax_pl_rate
    ADD CONSTRAINT "FK_SalesTaxpl_rate_StateProvince_StateProvinceID" FOREIGN KEY (pl_stat_id) REFERENCES db.pl_state_province(pl_stat_id);



ALTER TABLE ONLY db.pl_sales_zone_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_sales_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_sales_zone_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (pl_zone_id) REFERENCES db.pl_sales_zone(pl_zone_id);



ALTER TABLE ONLY db.pl_sales_zone
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (pl_country_region_code) REFERENCES db.pl_country_region(pl_country_region_code);



ALTER TABLE ONLY db.pl_shopping_cart_item
    ADD CONSTRAINT "FK_ShoppingCartItem_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_special_offer_merchandise
    ADD CONSTRAINT "FK_SpecialOffermerchandise_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_special_offer_merchandise
    ADD CONSTRAINT "FK_SpecialOffermerchandise_SpecialOffer_SpecialOfferID" FOREIGN KEY (promotion_id) REFERENCES db.pl_special_offer(promotion_id);



ALTER TABLE ONLY db.pl_state_province
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (pl_country_region_code) REFERENCES db.pl_country_region(pl_country_region_code);



ALTER TABLE ONLY db.pl_state_province
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (pl_zone_id) REFERENCES db.pl_sales_zone(pl_zone_id);



ALTER TABLE ONLY db.pl_store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_business_entity(pl_business_entity_id);



ALTER TABLE ONLY db.pl_store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (salesman_id) REFERENCES db.pl_sales_person(pl_business_entity_id);



ALTER TABLE ONLY db.pl_transaction_history
    ADD CONSTRAINT "FK_TransactionHistory_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_pl_seller
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (pl_business_entity_id) REFERENCES db.pl_business_entity(pl_business_entity_id);



ALTER TABLE ONLY db.pl_work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (pl_location_id) REFERENCES db.pl_location(pl_location_id);



ALTER TABLE ONLY db.pl_work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (work_order_id) REFERENCES db.pl_work_order(work_order_id);



ALTER TABLE ONLY db.pl_work_order
    ADD CONSTRAINT "FK_WorkOrder_merchandise_merchandiseID" FOREIGN KEY (pl_merch_id) REFERENCES db.pl_merchandise(pl_merch_id);



ALTER TABLE ONLY db.pl_work_order
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrap_reason_id) REFERENCES db.pl_scrap_reason(scrap_reason_id);



