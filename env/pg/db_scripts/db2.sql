

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


CREATE TABLE db.pl_address (
                               address_id integer NOT NULL,
                               street_name_1 character varying(60) NOT NULL,
                               street_name_2 character varying(60),
                               city character varying(30) NOT NULL,
                               district_id integer NOT NULL,
                               zipcode character varying(15) NOT NULL,
                               geographical_location character varying(44),
                               row_guid uuid NOT NULL,
                               updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_address OWNER TO postgres;


CREATE SEQUENCE db.pl_address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_address_addressid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_address_addressid_seq OWNED BY db.pl_address.address_id;



CREATE TABLE db.pl_address_type (
                                    address_type_id integer NOT NULL,
                                    row_guid uuid NOT NULL,
                                    updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_address_type OWNER TO postgres;


CREATE SEQUENCE db.pl_addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_addresstype_addresstypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_addresstype_addresstypeid_seq OWNED BY db.pl_address_type.address_type_id;



CREATE TABLE db.pl_applicant_for_job (
                                         applicant_for_job_id integer NOT NULL,
                                         business_entity_id integer,
                                         curriculum_vitae xml,
                                         modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_applicant_for_job OWNER TO postgres;


CREATE TABLE db.pl_area (
                            location_id integer NOT NULL,
                            cost_rate numeric DEFAULT 0.00 NOT NULL,
                            availability numeric(8,2) DEFAULT 0.00 NOT NULL,
                            modified_date timestamp without time zone DEFAULT now() NOT NULL,
                            CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
                            CONSTRAINT "CK_Location_CostRate" CHECK ((cost_rate >= 0.00))
);


ALTER TABLE db.pl_area OWNER TO postgres;


CREATE TABLE db.pl_materials_bills (
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


ALTER TABLE db.pl_materials_bills OWNER TO postgres;


CREATE SEQUENCE db.pl_billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_billofmaterials_billofmaterialsid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_billofmaterials_billofmaterialsid_seq OWNED BY db.pl_materials_bills.bill_of_materials_id;



CREATE TABLE db.pl_business_entity (
                                       business_entity_id integer NOT NULL,
                                       row_guid uuid NOT NULL,
                                       date_modified timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_business_entity OWNER TO postgres;


CREATE TABLE db.pl_business_entity_address (
                                               business_entity_id integer NOT NULL,
                                               address_id integer NOT NULL,
                                               address_type_id integer NOT NULL,
                                               row_guid uuid NOT NULL,
                                               modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_business_entity_address OWNER TO postgres;


CREATE TABLE db.pl_business_entity_contact (
                                               business_entity_id integer NOT NULL,
                                               person_id integer NOT NULL,
                                               type_contact_id integer NOT NULL,
                                               row_guid uuid NOT NULL,
                                               modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_business_entity_contact OWNER TO postgres;


CREATE SEQUENCE db.pl_businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_businessentity_businessentityid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_businessentity_businessentityid_seq OWNED BY db.pl_business_entity.business_entity_id;



CREATE TABLE db.pl_buy_details (
                                   buy_details_id integer NOT NULL,
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


ALTER TABLE db.pl_buy_details OWNER TO postgres;


CREATE TABLE db.pl_buyer (
                             business_entity_id integer NOT NULL,
                             rating_credit smallint NOT NULL,
                             website_url character varying(1024),
                             modified_date timestamp without time zone DEFAULT now() NOT NULL,
                             CONSTRAINT "CK_Vendor_CreditRating" CHECK (((rating_credit >= 1) AND (rating_credit <= 5)))
);


ALTER TABLE db.pl_buyer OWNER TO postgres;


CREATE TABLE db.pl_contact_type (
                                    contact_type_id integer NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_contact_type OWNER TO postgres;


CREATE SEQUENCE db.pl_contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_contacttype_contacttypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_contacttype_contacttypeid_seq OWNED BY db.pl_contact_type.contact_type_id;



CREATE TABLE db.pl_country_currency (
                                        country_code character varying(3) NOT NULL,
                                        currency_code character(3) NOT NULL,
                                        updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_country_currency OWNER TO postgres;


CREATE TABLE db.pl_country_region (
                                      country_code character varying(3) NOT NULL,
                                      modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_country_region OWNER TO postgres;


CREATE TABLE db.pl_payment_card (
                                    card_id integer NOT NULL,
                                    card_type character varying(50) NOT NULL,
                                    card_number character varying(25) NOT NULL,
                                    expire_month smallint NOT NULL,
                                    expire_year smallint NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_payment_card OWNER TO postgres;


CREATE SEQUENCE db.pl_creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_creditcard_creditcardid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_creditcard_creditcardid_seq OWNED BY db.pl_payment_card.card_id;



CREATE TABLE db.pl_culture (
                               culture_id character(6) NOT NULL,
                               modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_culture OWNER TO postgres;


CREATE TABLE db.pl_currency (
                                currency_code character(3) NOT NULL,
                                updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_currency OWNER TO postgres;


CREATE TABLE db.pl_currency_exchange_rate (
                                              currency_exchange_rate_id integer NOT NULL,
                                              currency_rate_date timestamp without time zone NOT NULL,
                                              from_currency_code character(3) NOT NULL,
                                              to_currency_code character(3) NOT NULL,
                                              average_rate numeric NOT NULL,
                                              end_of_day_rate numeric NOT NULL,
                                              modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_currency_exchange_rate OWNER TO postgres;


CREATE SEQUENCE db.pl_currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_currencyrate_currencyrateid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_currencyrate_currencyrateid_seq OWNED BY db.pl_currency_exchange_rate.currency_exchange_rate_id;



CREATE TABLE db.pl_customer (
                                customer_id integer NOT NULL,
                                person_id integer,
                                store_id integer,
                                row_guid uuid NOT NULL,
                                modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_customer OWNER TO postgres;


CREATE SEQUENCE db.pl_customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_customer_customerid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_customer_customerid_seq OWNED BY db.pl_customer.customer_id;



CREATE TABLE db.pl_department (
                                  branch_id integer NOT NULL,
                                  updated_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_department OWNER TO postgres;


CREATE TABLE db.pl_discount (
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


ALTER TABLE db.pl_discount OWNER TO postgres;


CREATE TABLE db.pl_document (
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


ALTER TABLE db.pl_document OWNER TO postgres;


CREATE TABLE db.pl_email_address (
                                     business_entity_id integer NOT NULL,
                                     email_id integer NOT NULL,
                                     email character varying(50),
                                     row_guid uuid NOT NULL,
                                     modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_email_address OWNER TO postgres;


CREATE SEQUENCE db.pl_emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_emailaddress_emailaddressid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_emailaddress_emailaddressid_seq OWNED BY db.pl_email_address.email_id;



CREATE TABLE db.pl_employee_pay_history (
                                            business_entity_id integer NOT NULL,
                                            rate_change_date timestamp without time zone NOT NULL,
                                            rate numeric NOT NULL,
                                            pay_frequency smallint NOT NULL,
                                            modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                            CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((pay_frequency = ANY (ARRAY[1, 2]))),
                                            CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);


ALTER TABLE db.pl_employee_pay_history OWNER TO postgres;


CREATE TABLE db.pl_history_employee_department (
                                                   business_entity_id integer NOT NULL,
                                                   department_id smallint NOT NULL,
                                                   shift_id smallint NOT NULL,
                                                   joining_date date NOT NULL,
                                                   end_date date,
                                                   modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                                   CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((end_date >= joining_date) OR (end_date IS NULL)))
);


ALTER TABLE db.pl_history_employee_department OWNER TO postgres;


CREATE TABLE db.pl_history_transaction (
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


ALTER TABLE db.pl_history_transaction OWNER TO postgres;


CREATE TABLE db.pl_illustration (
                                    illustration_id integer NOT NULL,
                                    diagram xml,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_illustration OWNER TO postgres;


CREATE SEQUENCE db.pl_illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_illustration_illustrationid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_illustration_illustrationid_seq OWNED BY db.pl_illustration.illustration_id;



CREATE SEQUENCE db.pl_jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_jobcandidate_jobcandidateid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_jobcandidate_jobcandidateid_seq OWNED BY db.pl_applicant_for_job.applicant_for_job_id;



CREATE SEQUENCE db.pl_location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_location_locationid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_location_locationid_seq OWNED BY db.pl_area.location_id;



CREATE TABLE db.pl_measure_unit (
                                    unit_measure_code character(3) NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_measure_unit OWNER TO postgres;


CREATE TABLE db.pl_password (
                                business_entity_id integer NOT NULL,
                                password_hash character varying(128) NOT NULL,
                                password_salt character varying(10) NOT NULL,
                                row_guid uuid NOT NULL,
                                update_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_password OWNER TO postgres;


CREATE TABLE db.pl_payment_card_person (
                                           business_entity_id integer NOT NULL,
                                           card_id integer NOT NULL,
                                           modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_payment_card_person OWNER TO postgres;


CREATE TABLE db.pl_person (
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


ALTER TABLE db.pl_person OWNER TO postgres;


CREATE TABLE db.pl_person_phone (
                                    business_entity_id integer NOT NULL,
                                    phone_number_type_id integer NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_person_phone OWNER TO postgres;


CREATE TABLE db.pl_phone_number_type (
                                         phone_number_type_id integer NOT NULL,
                                         modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_phone_number_type OWNER TO postgres;


CREATE SEQUENCE db.pl_phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_phonenumbertype_phonenumbertypeid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_phonenumbertype_phonenumbertypeid_seq OWNED BY db.pl_phone_number_type.phone_number_type_id;



CREATE TABLE db.pl_product (
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


ALTER TABLE db.pl_product OWNER TO postgres;


CREATE TABLE db.pl_product_cost_history (
                                            product_id integer NOT NULL,
                                            start_date timestamp without time zone NOT NULL,
                                            end_date timestamp without time zone,
                                            standard_cost numeric NOT NULL,
                                            modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                            CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((end_date >= start_date) OR (end_date IS NULL))),
                                            CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standard_cost >= 0.00))
);


ALTER TABLE db.pl_product_cost_history OWNER TO postgres;


CREATE TABLE db.pl_product_dealer (
                                      product_id integer NOT NULL,
                                      business_entity_id integer NOT NULL,
                                      average_time integer NOT NULL,
                                      standard_price numeric NOT NULL,
                                      last_receipt_cost numeric,
                                      last_receipt_date timestamp without time zone,
                                      min_order_qty integer NOT NULL,
                                      max_order_qty integer NOT NULL,
                                      on_order_quantity integer,
                                      unit_measure_code character(3) NOT NULL,
                                      modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                      CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK ((average_time >= 1)),
                                      CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK ((last_receipt_cost > 0.00)),
                                      CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK ((max_order_qty >= 1)),
                                      CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK ((min_order_qty >= 1)),
                                      CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK ((on_order_quantity >= 0)),
                                      CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK ((standard_price > 0.00))
);


ALTER TABLE db.pl_product_dealer OWNER TO postgres;


CREATE TABLE db.pl_product_description (
                                           product_description_id integer NOT NULL,
                                           description character varying(400) NOT NULL,
                                           row_guid uuid NOT NULL,
                                           modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_description OWNER TO postgres;


CREATE TABLE db.pl_product_discount (
                                        product_discount_id integer NOT NULL,
                                        product_id integer NOT NULL,
                                        row_guid uuid NOT NULL,
                                        modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_discount OWNER TO postgres;


CREATE TABLE db.pl_product_document (
                                        product_id integer NOT NULL,
                                        modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                        document_node character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE db.pl_product_document OWNER TO postgres;


CREATE TABLE db.pl_product_image (
                                     product_photo_id integer NOT NULL,
                                     thumbnail_photo bytea,
                                     thumbnail_photo_file_name character varying(50),
                                     large_photo bytea,
                                     large_photo_file_name character varying(50),
                                     modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_image OWNER TO postgres;


CREATE TABLE db.pl_product_inventory (
                                         product_id integer NOT NULL,
                                         location_id smallint NOT NULL,
                                         shelf character varying(10) NOT NULL,
                                         bin smallint NOT NULL,
                                         quantity smallint DEFAULT 0 NOT NULL,
                                         row_guid uuid NOT NULL,
                                         modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                         CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE db.pl_product_inventory OWNER TO postgres;


CREATE TABLE db.pl_product_model (
                                     product_model_id integer NOT NULL,
                                     catalog_description xml,
                                     instructions xml,
                                     row_guid uuid NOT NULL,
                                     modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_model OWNER TO postgres;


CREATE TABLE db.pl_product_model_illustration (
                                                  product_model_id integer NOT NULL,
                                                  illustration_id integer NOT NULL,
                                                  modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_model_illustration OWNER TO postgres;


CREATE TABLE db.pl_product_model_product_description_culture (
                                                                 product_model_id integer NOT NULL,
                                                                 product_description_id integer NOT NULL,
                                                                 culture_id character(6) NOT NULL,
                                                                 modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_model_product_description_culture OWNER TO postgres;


CREATE SEQUENCE db.pl_product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_product_productid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_product_productid_seq OWNED BY db.pl_product.product_id;



CREATE TABLE db.pl_product_review (
                                      product_review_id integer NOT NULL,
                                      product_id integer NOT NULL,
                                      review_date timestamp without time zone DEFAULT now() NOT NULL,
                                      email_address character varying(50) NOT NULL,
                                      rating integer NOT NULL,
                                      comments character varying(3850),
                                      modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                      CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE db.pl_product_review OWNER TO postgres;


CREATE TABLE db.pl_product_section (
                                       product_category_id integer NOT NULL,
                                       row_guid uuid NOT NULL,
                                       modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_section OWNER TO postgres;


CREATE TABLE db.pl_product_subcategory (
                                           product_subcategory_id integer NOT NULL,
                                           product_category_id integer NOT NULL,
                                           row_guid uuid NOT NULL,
                                           modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_product_subcategory OWNER TO postgres;


CREATE SEQUENCE db.pl_productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_productcategory_productcategoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_productcategory_productcategoryid_seq OWNED BY db.pl_product_section.product_category_id;



CREATE SEQUENCE db.pl_productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_productdescription_productdescriptionid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_productdescription_productdescriptionid_seq OWNED BY db.pl_product_description.product_description_id;



CREATE SEQUENCE db.pl_productmodel_productmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_productmodel_productmodelid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_productmodel_productmodelid_seq OWNED BY db.pl_product_model.product_model_id;



CREATE SEQUENCE db.pl_productphoto_productphotoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_productphoto_productphotoid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_productphoto_productphotoid_seq OWNED BY db.pl_product_image.product_photo_id;



CREATE SEQUENCE db.pl_productreview_productreviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_productreview_productreviewid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_productreview_productreviewid_seq OWNED BY db.pl_product_review.product_review_id;



CREATE SEQUENCE db.pl_productsubcategory_productsubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_productsubcategory_productsubcategoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_productsubcategory_productsubcategoryid_seq OWNED BY db.pl_product_subcategory.product_subcategory_id;



CREATE SEQUENCE db.pl_purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_purchaseorderdetail_purchaseorderdetailid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_purchaseorderdetail_purchaseorderdetailid_seq OWNED BY db.pl_buy_details.buy_details_id;



CREATE TABLE db.pl_sales_order (
                                   sales_order_id integer NOT NULL,
                                   sales_reason_id integer NOT NULL,
                                   modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_sales_order OWNER TO postgres;


CREATE TABLE db.pl_sales_order_detail (
                                          sales_order_id integer NOT NULL,
                                          sales_order_detail_id integer NOT NULL,
                                          tracking_number character varying(25),
                                          order_quantity smallint NOT NULL,
                                          product_id integer NOT NULL,
                                          discount_id integer NOT NULL,
                                          unit_price numeric NOT NULL,
                                          unit_price_discount numeric DEFAULT 0.0 NOT NULL,
                                          row_guid uuid NOT NULL,
                                          modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                          CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((order_quantity > 0)),
                                          CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unit_price >= 0.00)),
                                          CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unit_price_discount >= 0.00))
);


ALTER TABLE db.pl_sales_order_detail OWNER TO postgres;


CREATE TABLE db.pl_sales_person (
                                    business_entity_id integer NOT NULL,
                                    bonus numeric DEFAULT 0.00 NOT NULL,
                                    commission numeric DEFAULT 0.00 NOT NULL,
                                    sales_ytd numeric DEFAULT 0.00 NOT NULL,
                                    row_guid uuid NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
                                    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commission >= 0.00)),
                                    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((sales_ytd >= 0.00))
);


ALTER TABLE db.pl_sales_person OWNER TO postgres;


CREATE TABLE db.pl_sales_reason (
                                    sales_reason_id integer NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_sales_reason OWNER TO postgres;


CREATE TABLE db.pl_sales_tax_rate (
                                      sales_tax_rate_id integer NOT NULL,
                                      state_province_id integer NOT NULL,
                                      tax_type smallint NOT NULL,
                                      tax_rate numeric DEFAULT 0.00 NOT NULL,
                                      row_guid uuid NOT NULL,
                                      modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                      CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((tax_type >= 1) AND (tax_type <= 3)))
);


ALTER TABLE db.pl_sales_tax_rate OWNER TO postgres;


CREATE TABLE db.pl_sales_territory (
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


ALTER TABLE db.pl_sales_territory OWNER TO postgres;


CREATE SEQUENCE db.pl_salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesorderdetail_salesorderdetailid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_salesorderdetail_salesorderdetailid_seq OWNED BY db.pl_sales_order_detail.sales_order_detail_id;



CREATE SEQUENCE db.pl_salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesreason_salesreasonid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_salesreason_salesreasonid_seq OWNED BY db.pl_sales_reason.sales_reason_id;



CREATE SEQUENCE db.pl_salestaxrate_salestaxrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salestaxrate_salestaxrateid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_salestaxrate_salestaxrateid_seq OWNED BY db.pl_sales_tax_rate.sales_tax_rate_id;



CREATE SEQUENCE db.pl_salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_salesterritory_territoryid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_salesterritory_territoryid_seq OWNED BY db.pl_sales_territory.territory_id;



CREATE TABLE db.pl_scrap_reason (
                                    scrap_reason_id integer NOT NULL,
                                    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_scrap_reason OWNER TO postgres;


CREATE SEQUENCE db.pl_scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_scrapreason_scrapreasonid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_scrapreason_scrapreasonid_seq OWNED BY db.pl_scrap_reason.scrap_reason_id;



CREATE TABLE db.pl_shift (
                             shift_id integer NOT NULL,
                             starting_shift time without time zone NOT NULL,
                             ending_shift time without time zone NOT NULL,
                             date_updated timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_shift OWNER TO postgres;


CREATE TABLE db.pl_shipment_method (
                                       shipment_method_id integer NOT NULL,
                                       shipping_price numeric DEFAULT 0.00 NOT NULL,
                                       row_guid uuid NOT NULL,
                                       modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                       CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shipping_price > 0.00))
);


ALTER TABLE db.pl_shipment_method OWNER TO postgres;


CREATE SEQUENCE db.pl_shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_shipmethod_shipmethodid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_shipmethod_shipmethodid_seq OWNED BY db.pl_shipment_method.shipment_method_id;



CREATE TABLE db.pl_shopping_cart (
                                     shopping_cart_item_id integer NOT NULL,
                                     shopping_cart_id character varying(50) NOT NULL,
                                     number_of_product integer DEFAULT 1 NOT NULL,
                                     product_id integer NOT NULL,
                                     date_created timestamp without time zone DEFAULT now() NOT NULL,
                                     modified_date timestamp without time zone DEFAULT now() NOT NULL,
                                     CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((number_of_product >= 1))
);


ALTER TABLE db.pl_shopping_cart OWNER TO postgres;


CREATE SEQUENCE db.pl_shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_shoppingcartitem_shoppingcartitemid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_shoppingcartitem_shoppingcartitemid_seq OWNED BY db.pl_shopping_cart.shopping_cart_item_id;



CREATE SEQUENCE db.pl_specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_specialoffer_specialofferid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_specialoffer_specialofferid_seq OWNED BY db.pl_discount.discount_id;



CREATE TABLE db.pl_state_province (
                                      state_province_id integer NOT NULL,
                                      state_province_code character(3) NOT NULL,
                                      country_region_code character varying(3) NOT NULL,
                                      territory_id integer NOT NULL,
                                      row_guid uuid NOT NULL,
                                      modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_state_province OWNER TO postgres;


CREATE SEQUENCE db.pl_stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_stateprovince_stateprovinceid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_stateprovince_stateprovinceid_seq OWNED BY db.pl_state_province.state_province_id;



CREATE TABLE db.pl_store (
                             business_entity_id integer NOT NULL,
                             sales_person_id integer,
                             demographics xml,
                             row_guid uuid NOT NULL,
                             modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE db.pl_store OWNER TO postgres;


CREATE SEQUENCE db.pl_transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_transactionhistory_transactionid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_transactionhistory_transactionid_seq OWNED BY db.pl_history_transaction.transaction_id;



CREATE TABLE db.pl_work_order (
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


ALTER TABLE db.pl_work_order OWNER TO postgres;


CREATE SEQUENCE db.pl_workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db.pl_workorder_workorderid_seq OWNER TO postgres;


ALTER SEQUENCE db.pl_workorder_workorderid_seq OWNED BY db.pl_work_order.work_order_id;



ALTER TABLE ONLY db.pl_address ALTER COLUMN address_id SET DEFAULT nextval('db.pl_address_addressid_seq'::regclass);



ALTER TABLE ONLY db.pl_address_type ALTER COLUMN address_type_id SET DEFAULT nextval('db.pl_addresstype_addresstypeid_seq'::regclass);



ALTER TABLE ONLY db.pl_applicant_for_job ALTER COLUMN applicant_for_job_id SET DEFAULT nextval('db.pl_jobcandidate_jobcandidateid_seq'::regclass);



ALTER TABLE ONLY db.pl_area ALTER COLUMN location_id SET DEFAULT nextval('db.pl_location_locationid_seq'::regclass);



ALTER TABLE ONLY db.pl_business_entity ALTER COLUMN business_entity_id SET DEFAULT nextval('db.pl_businessentity_businessentityid_seq'::regclass);



ALTER TABLE ONLY db.pl_buy_details ALTER COLUMN buy_details_id SET DEFAULT nextval('db.pl_purchaseorderdetail_purchaseorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.pl_contact_type ALTER COLUMN contact_type_id SET DEFAULT nextval('db.pl_contacttype_contacttypeid_seq'::regclass);



ALTER TABLE ONLY db.pl_currency_exchange_rate ALTER COLUMN currency_exchange_rate_id SET DEFAULT nextval('db.pl_currencyrate_currencyrateid_seq'::regclass);



ALTER TABLE ONLY db.pl_customer ALTER COLUMN customer_id SET DEFAULT nextval('db.pl_customer_customerid_seq'::regclass);



ALTER TABLE ONLY db.pl_discount ALTER COLUMN discount_id SET DEFAULT nextval('db.pl_specialoffer_specialofferid_seq'::regclass);



ALTER TABLE ONLY db.pl_email_address ALTER COLUMN email_id SET DEFAULT nextval('db.pl_emailaddress_emailaddressid_seq'::regclass);



ALTER TABLE ONLY db.pl_history_transaction ALTER COLUMN transaction_id SET DEFAULT nextval('db.pl_transactionhistory_transactionid_seq'::regclass);



ALTER TABLE ONLY db.pl_illustration ALTER COLUMN illustration_id SET DEFAULT nextval('db.pl_illustration_illustrationid_seq'::regclass);



ALTER TABLE ONLY db.pl_materials_bills ALTER COLUMN bill_of_materials_id SET DEFAULT nextval('db.pl_billofmaterials_billofmaterialsid_seq'::regclass);



ALTER TABLE ONLY db.pl_payment_card ALTER COLUMN card_id SET DEFAULT nextval('db.pl_creditcard_creditcardid_seq'::regclass);



ALTER TABLE ONLY db.pl_phone_number_type ALTER COLUMN phone_number_type_id SET DEFAULT nextval('db.pl_phonenumbertype_phonenumbertypeid_seq'::regclass);



ALTER TABLE ONLY db.pl_product ALTER COLUMN product_id SET DEFAULT nextval('db.pl_product_productid_seq'::regclass);



ALTER TABLE ONLY db.pl_product_description ALTER COLUMN product_description_id SET DEFAULT nextval('db.pl_productdescription_productdescriptionid_seq'::regclass);



ALTER TABLE ONLY db.pl_product_image ALTER COLUMN product_photo_id SET DEFAULT nextval('db.pl_productphoto_productphotoid_seq'::regclass);



ALTER TABLE ONLY db.pl_product_model ALTER COLUMN product_model_id SET DEFAULT nextval('db.pl_productmodel_productmodelid_seq'::regclass);



ALTER TABLE ONLY db.pl_product_review ALTER COLUMN product_review_id SET DEFAULT nextval('db.pl_productreview_productreviewid_seq'::regclass);



ALTER TABLE ONLY db.pl_product_section ALTER COLUMN product_category_id SET DEFAULT nextval('db.pl_productcategory_productcategoryid_seq'::regclass);



ALTER TABLE ONLY db.pl_product_subcategory ALTER COLUMN product_subcategory_id SET DEFAULT nextval('db.pl_productsubcategory_productsubcategoryid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_order_detail ALTER COLUMN sales_order_detail_id SET DEFAULT nextval('db.pl_salesorderdetail_salesorderdetailid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_reason ALTER COLUMN sales_reason_id SET DEFAULT nextval('db.pl_salesreason_salesreasonid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_tax_rate ALTER COLUMN sales_tax_rate_id SET DEFAULT nextval('db.pl_salestaxrate_salestaxrateid_seq'::regclass);



ALTER TABLE ONLY db.pl_sales_territory ALTER COLUMN territory_id SET DEFAULT nextval('db.pl_salesterritory_territoryid_seq'::regclass);



ALTER TABLE ONLY db.pl_scrap_reason ALTER COLUMN scrap_reason_id SET DEFAULT nextval('db.pl_scrapreason_scrapreasonid_seq'::regclass);



ALTER TABLE ONLY db.pl_shipment_method ALTER COLUMN shipment_method_id SET DEFAULT nextval('db.pl_shipmethod_shipmethodid_seq'::regclass);



ALTER TABLE ONLY db.pl_shopping_cart ALTER COLUMN shopping_cart_item_id SET DEFAULT nextval('db.pl_shoppingcartitem_shoppingcartitemid_seq'::regclass);



ALTER TABLE ONLY db.pl_state_province ALTER COLUMN state_province_id SET DEFAULT nextval('db.pl_stateprovince_stateprovinceid_seq'::regclass);



ALTER TABLE ONLY db.pl_work_order ALTER COLUMN work_order_id SET DEFAULT nextval('db.pl_workorder_workorderid_seq'::regclass);



ALTER TABLE ONLY db.pl_address_type
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (address_type_id);

ALTER TABLE db.pl_address_type CLUSTER ON "PK_AddressType_AddressTypeID";



ALTER TABLE ONLY db.pl_address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (address_id);

ALTER TABLE db.pl_address CLUSTER ON "PK_Address_AddressID";



ALTER TABLE ONLY db.pl_materials_bills
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (bill_of_materials_id);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (business_entity_id, address_id, address_type_id);

ALTER TABLE db.pl_business_entity_address CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (business_entity_id, person_id, type_contact_id);

ALTER TABLE db.pl_business_entity_contact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";



ALTER TABLE ONLY db.pl_business_entity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.pl_business_entity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";



ALTER TABLE ONLY db.pl_contact_type
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contact_type_id);

ALTER TABLE db.pl_contact_type CLUSTER ON "PK_ContactType_ContactTypeID";



ALTER TABLE ONLY db.pl_country_currency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (country_code, currency_code);

ALTER TABLE db.pl_country_currency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";



ALTER TABLE ONLY db.pl_country_region
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (country_code);

ALTER TABLE db.pl_country_region CLUSTER ON "PK_CountryRegion_CountryRegionCode";



ALTER TABLE ONLY db.pl_payment_card
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (card_id);

ALTER TABLE db.pl_payment_card CLUSTER ON "PK_CreditCard_CreditCardID";



ALTER TABLE ONLY db.pl_culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (culture_id);

ALTER TABLE db.pl_culture CLUSTER ON "PK_Culture_CultureID";



ALTER TABLE ONLY db.pl_currency_exchange_rate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currency_exchange_rate_id);

ALTER TABLE db.pl_currency_exchange_rate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";



ALTER TABLE ONLY db.pl_currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currency_code);

ALTER TABLE db.pl_currency CLUSTER ON "PK_Currency_CurrencyCode";



ALTER TABLE ONLY db.pl_customer
    ADD CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customer_id);

ALTER TABLE db.pl_customer CLUSTER ON "PK_Customer_CustomerID";



ALTER TABLE ONLY db.pl_department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (branch_id);

ALTER TABLE db.pl_department CLUSTER ON "PK_Department_DepartmentID";



ALTER TABLE ONLY db.pl_document
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (document_node);

ALTER TABLE db.pl_document CLUSTER ON "PK_Document_DocumentNode";



ALTER TABLE ONLY db.pl_email_address
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (business_entity_id, email_id);

ALTER TABLE db.pl_email_address CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";



ALTER TABLE ONLY db.pl_history_employee_department
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (business_entity_id, joining_date, department_id, shift_id);

ALTER TABLE db.pl_history_employee_department CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";



ALTER TABLE ONLY db.pl_employee_pay_history
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (business_entity_id, rate_change_date);

ALTER TABLE db.pl_employee_pay_history CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";



ALTER TABLE ONLY db.pl_illustration
    ADD CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illustration_id);

ALTER TABLE db.pl_illustration CLUSTER ON "PK_Illustration_IllustrationID";



ALTER TABLE ONLY db.pl_applicant_for_job
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (applicant_for_job_id);

ALTER TABLE db.pl_applicant_for_job CLUSTER ON "PK_JobCandidate_JobCandidateID";



ALTER TABLE ONLY db.pl_area
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (location_id);

ALTER TABLE db.pl_area CLUSTER ON "PK_Location_LocationID";



ALTER TABLE ONLY db.pl_password
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.pl_password CLUSTER ON "PK_Password_BusinessEntityID";



ALTER TABLE ONLY db.pl_payment_card_person
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (business_entity_id, card_id);

ALTER TABLE db.pl_payment_card_person CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";



ALTER TABLE ONLY db.pl_person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.pl_person CLUSTER ON "PK_Person_BusinessEntityID";



ALTER TABLE ONLY db.pl_phone_number_type
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phone_number_type_id);

ALTER TABLE db.pl_phone_number_type CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";



ALTER TABLE ONLY db.pl_product_section
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (product_category_id);

ALTER TABLE db.pl_product_section CLUSTER ON "PK_ProductCategory_ProductCategoryID";



ALTER TABLE ONLY db.pl_product_cost_history
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (product_id, start_date);

ALTER TABLE db.pl_product_cost_history CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";



ALTER TABLE ONLY db.pl_product_description
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (product_description_id);

ALTER TABLE db.pl_product_description CLUSTER ON "PK_ProductDescription_ProductDescriptionID";



ALTER TABLE ONLY db.pl_product_document
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (product_id, document_node);

ALTER TABLE db.pl_product_document CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";



ALTER TABLE ONLY db.pl_product_inventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (product_id, location_id);

ALTER TABLE db.pl_product_inventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";



ALTER TABLE ONLY db.pl_product_model_illustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (product_model_id, illustration_id);

ALTER TABLE db.pl_product_model_illustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";



ALTER TABLE ONLY db.pl_product_model_product_description_culture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (product_model_id, product_description_id, culture_id);

ALTER TABLE db.pl_product_model_product_description_culture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";



ALTER TABLE ONLY db.pl_product_model
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (product_model_id);

ALTER TABLE db.pl_product_model CLUSTER ON "PK_ProductModel_ProductModelID";



ALTER TABLE ONLY db.pl_product_image
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (product_photo_id);

ALTER TABLE db.pl_product_image CLUSTER ON "PK_ProductPhoto_ProductPhotoID";



ALTER TABLE ONLY db.pl_product_review
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (product_review_id);

ALTER TABLE db.pl_product_review CLUSTER ON "PK_ProductReview_ProductReviewID";



ALTER TABLE ONLY db.pl_product_subcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (product_subcategory_id);

ALTER TABLE db.pl_product_subcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";



ALTER TABLE ONLY db.pl_product_dealer
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (product_id, business_entity_id);

ALTER TABLE db.pl_product_dealer CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";



ALTER TABLE ONLY db.pl_product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (product_id);

ALTER TABLE db.pl_product CLUSTER ON "PK_Product_ProductID";



ALTER TABLE ONLY db.pl_sales_order_detail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (sales_order_id, sales_order_detail_id);

ALTER TABLE db.pl_sales_order_detail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";



ALTER TABLE ONLY db.pl_sales_order
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (sales_order_id, sales_reason_id);

ALTER TABLE db.pl_sales_order CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";



ALTER TABLE ONLY db.pl_sales_person
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.pl_sales_person CLUSTER ON "PK_SalesPerson_BusinessEntityID";



ALTER TABLE ONLY db.pl_sales_reason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (sales_reason_id);

ALTER TABLE db.pl_sales_reason CLUSTER ON "PK_SalesReason_SalesReasonID";



ALTER TABLE ONLY db.pl_sales_tax_rate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (sales_tax_rate_id);

ALTER TABLE db.pl_sales_tax_rate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";



ALTER TABLE ONLY db.pl_sales_territory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territory_id);

ALTER TABLE db.pl_sales_territory CLUSTER ON "PK_SalesTerritory_TerritoryID";



ALTER TABLE ONLY db.pl_scrap_reason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrap_reason_id);

ALTER TABLE db.pl_scrap_reason CLUSTER ON "PK_ScrapReason_ScrapReasonID";



ALTER TABLE ONLY db.pl_shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shift_id);

ALTER TABLE db.pl_shift CLUSTER ON "PK_Shift_ShiftID";



ALTER TABLE ONLY db.pl_shipment_method
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (shipment_method_id);

ALTER TABLE db.pl_shipment_method CLUSTER ON "PK_ShipMethod_ShipMethodID";



ALTER TABLE ONLY db.pl_shopping_cart
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shopping_cart_item_id);

ALTER TABLE db.pl_shopping_cart CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";



ALTER TABLE ONLY db.pl_product_discount
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (product_discount_id, product_id);

ALTER TABLE db.pl_product_discount CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";



ALTER TABLE ONLY db.pl_discount
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (discount_id);

ALTER TABLE db.pl_discount CLUSTER ON "PK_SpecialOffer_SpecialOfferID";



ALTER TABLE ONLY db.pl_state_province
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (state_province_id);

ALTER TABLE db.pl_state_province CLUSTER ON "PK_StateProvince_StateProvinceID";



ALTER TABLE ONLY db.pl_store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.pl_store CLUSTER ON "PK_Store_BusinessEntityID";



ALTER TABLE ONLY db.pl_history_transaction
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transaction_id);

ALTER TABLE db.pl_history_transaction CLUSTER ON "PK_TransactionHistory_TransactionID";



ALTER TABLE ONLY db.pl_measure_unit
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unit_measure_code);

ALTER TABLE db.pl_measure_unit CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";



ALTER TABLE ONLY db.pl_buyer
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (business_entity_id);

ALTER TABLE db.pl_buyer CLUSTER ON "PK_Vendor_BusinessEntityID";



ALTER TABLE ONLY db.pl_work_order
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (work_order_id);

ALTER TABLE db.pl_work_order CLUSTER ON "PK_WorkOrder_WorkOrderID";



ALTER TABLE ONLY db.pl_document
    ADD CONSTRAINT document_rowguid_key UNIQUE (row_guid);



ALTER TABLE ONLY db.pl_address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (district_id) REFERENCES db.pl_state_province(state_province_id);



ALTER TABLE ONLY db.pl_materials_bills
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (component_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_materials_bills
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (product_assembly_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_materials_bills
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES db.pl_measure_unit(unit_measure_code);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (address_type_id) REFERENCES db.pl_address_type(address_type_id);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (address_id) REFERENCES db.pl_address(address_id);



ALTER TABLE ONLY db.pl_business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_business_entity(business_entity_id);



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_business_entity(business_entity_id);



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (type_contact_id) REFERENCES db.pl_contact_type(contact_type_id);



ALTER TABLE ONLY db.pl_business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (person_id) REFERENCES db.pl_person(business_entity_id);



ALTER TABLE ONLY db.pl_country_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (country_code) REFERENCES db.pl_country_region(country_code);



ALTER TABLE ONLY db.pl_country_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currency_code) REFERENCES db.pl_currency(currency_code);



ALTER TABLE ONLY db.pl_currency_exchange_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (from_currency_code) REFERENCES db.pl_currency(currency_code);



ALTER TABLE ONLY db.pl_currency_exchange_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (to_currency_code) REFERENCES db.pl_currency(currency_code);



ALTER TABLE ONLY db.pl_customer
    ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (person_id) REFERENCES db.pl_person(business_entity_id);



ALTER TABLE ONLY db.pl_customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (store_id) REFERENCES db.pl_store(business_entity_id);



ALTER TABLE ONLY db.pl_email_address
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_person(business_entity_id);



ALTER TABLE ONLY db.pl_history_employee_department
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (department_id) REFERENCES db.pl_department(branch_id);



ALTER TABLE ONLY db.pl_history_employee_department
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shift_id) REFERENCES db.pl_shift(shift_id);



ALTER TABLE ONLY db.pl_password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_person(business_entity_id);



ALTER TABLE ONLY db.pl_payment_card_person
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (card_id) REFERENCES db.pl_payment_card(card_id);



ALTER TABLE ONLY db.pl_payment_card_person
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_person(business_entity_id);



ALTER TABLE ONLY db.pl_person_phone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_person(business_entity_id);



ALTER TABLE ONLY db.pl_person_phone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phone_number_type_id) REFERENCES db.pl_phone_number_type(phone_number_type_id);



ALTER TABLE ONLY db.pl_person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_business_entity(business_entity_id);



ALTER TABLE ONLY db.pl_product_cost_history
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_product_document
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (document_node) REFERENCES db.pl_document(document_node);



ALTER TABLE ONLY db.pl_product_document
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (location_id) REFERENCES db.pl_area(location_id);



ALTER TABLE ONLY db.pl_product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustration_id) REFERENCES db.pl_illustration(illustration_id);



ALTER TABLE ONLY db.pl_product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES db.pl_product_model(product_model_id);



ALTER TABLE ONLY db.pl_product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (culture_id) REFERENCES db.pl_culture(culture_id);



ALTER TABLE ONLY db.pl_product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (product_description_id) REFERENCES db.pl_product_description(product_description_id);



ALTER TABLE ONLY db.pl_product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (product_model_id) REFERENCES db.pl_product_model(product_model_id);



ALTER TABLE ONLY db.pl_product_subcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (product_category_id) REFERENCES db.pl_product_section(product_category_id);



ALTER TABLE ONLY db.pl_product_dealer
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_product_dealer
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unit_measure_code) REFERENCES db.pl_measure_unit(unit_measure_code);



ALTER TABLE ONLY db.pl_product_dealer
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_buyer(business_entity_id);



ALTER TABLE ONLY db.pl_product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (product_model_id) REFERENCES db.pl_product_model(product_model_id);



ALTER TABLE ONLY db.pl_product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (product_subcategory_id) REFERENCES db.pl_product_subcategory(product_subcategory_id);



ALTER TABLE ONLY db.pl_product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (size_unit_measure_code) REFERENCES db.pl_measure_unit(unit_measure_code);



ALTER TABLE ONLY db.pl_product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weight_unit_measure_code) REFERENCES db.pl_measure_unit(unit_measure_code);



ALTER TABLE ONLY db.pl_buy_details
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (discount_id, product_id) REFERENCES db.pl_product_discount(product_discount_id, product_id);



ALTER TABLE ONLY db.pl_sales_order
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (sales_reason_id) REFERENCES db.pl_sales_reason(sales_reason_id);



ALTER TABLE ONLY db.pl_sales_tax_rate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (state_province_id) REFERENCES db.pl_state_province(state_province_id);



ALTER TABLE ONLY db.pl_sales_territory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.pl_country_region(country_code);



ALTER TABLE ONLY db.pl_shopping_cart
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_product_discount
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_product_discount
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (product_discount_id) REFERENCES db.pl_discount(discount_id);



ALTER TABLE ONLY db.pl_state_province
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (country_region_code) REFERENCES db.pl_country_region(country_code);



ALTER TABLE ONLY db.pl_state_province
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territory_id) REFERENCES db.pl_sales_territory(territory_id);



ALTER TABLE ONLY db.pl_store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_business_entity(business_entity_id);



ALTER TABLE ONLY db.pl_store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (sales_person_id) REFERENCES db.pl_sales_person(business_entity_id);



ALTER TABLE ONLY db.pl_history_transaction
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_buyer
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (business_entity_id) REFERENCES db.pl_business_entity(business_entity_id);



ALTER TABLE ONLY db.pl_work_order
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (product_id) REFERENCES db.pl_product(product_id);



ALTER TABLE ONLY db.pl_work_order
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrap_reason_id) REFERENCES db.pl_scrap_reason(scrap_reason_id);



