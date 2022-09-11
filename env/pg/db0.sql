--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4 (Debian 14.4-1.pgdg110+1)
-- Dumped by pg_dump version 14.4 (Debian 14.4-1.pgdg110+1)

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
    departmentid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.department OWNER TO postgres;

--
-- Name: TABLE department; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.department IS 'Lookup table containing the departments within the Adventure Works Cycles company.';


--
-- Name: COLUMN department.departmentid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.department.departmentid IS 'Primary key for Department records.';


--
-- Name: employee; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee (
    businessentityid integer NOT NULL,
    nationalidnumber character varying(15) NOT NULL,
    loginid character varying(256) NOT NULL,
    jobtitle character varying(50) NOT NULL,
    birthdate date NOT NULL,
    maritalstatus character(1) NOT NULL,
    gender character(1) NOT NULL,
    hiredate date NOT NULL,
    vacationhours smallint DEFAULT 0 NOT NULL,
    sickleavehours smallint DEFAULT 0 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    organizationnode character varying DEFAULT '/'::character varying,
    CONSTRAINT "CK_Employee_BirthDate" CHECK (((birthdate >= '1930-01-01'::date) AND (birthdate <= (now() - '18 years'::interval)))),
    CONSTRAINT "CK_Employee_Gender" CHECK ((upper((gender)::text) = ANY (ARRAY['M'::text, 'F'::text]))),
    CONSTRAINT "CK_Employee_HireDate" CHECK (((hiredate >= '1996-07-01'::date) AND (hiredate <= (now() + '1 day'::interval)))),
    CONSTRAINT "CK_Employee_MaritalStatus" CHECK ((upper((maritalstatus)::text) = ANY (ARRAY['M'::text, 'S'::text]))),
    CONSTRAINT "CK_Employee_SickLeaveHours" CHECK (((sickleavehours >= 0) AND (sickleavehours <= 120))),
    CONSTRAINT "CK_Employee_VacationHours" CHECK (((vacationhours >= '-40'::integer) AND (vacationhours <= 240)))
);


ALTER TABLE human_resources.employee OWNER TO postgres;

--
-- Name: TABLE employee; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.employee IS 'Employee information such as salary, department, and title.';


--
-- Name: COLUMN employee.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.businessentityid IS 'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN employee.nationalidnumber; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.nationalidnumber IS 'Unique national identification number such as a social security number.';


--
-- Name: COLUMN employee.loginid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.loginid IS 'Network login.';


--
-- Name: COLUMN employee.jobtitle; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.jobtitle IS 'Work title such as Buyer or Sales Representative.';


--
-- Name: COLUMN employee.birthdate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.birthdate IS 'Date of birth.';


--
-- Name: COLUMN employee.maritalstatus; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.maritalstatus IS 'M = Married, S = Single';


--
-- Name: COLUMN employee.gender; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.gender IS 'M = Male, F = Female';


--
-- Name: COLUMN employee.hiredate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.hiredate IS 'Employee hired on this date.';


--
-- Name: COLUMN employee.vacationhours; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.vacationhours IS 'Number of available vacation hours.';


--
-- Name: COLUMN employee.sickleavehours; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.sickleavehours IS 'Number of available sick leave hours.';


--
-- Name: COLUMN employee.organizationnode; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee.organizationnode IS 'Where the employee is located in corporate hierarchy.';


--
-- Name: employee_department_history; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_department_history (
    businessentityid integer NOT NULL,
    departmentid smallint NOT NULL,
    shiftid smallint NOT NULL,
    startdate date NOT NULL,
    enddate date,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);


ALTER TABLE human_resources.employee_department_history OWNER TO postgres;

--
-- Name: TABLE employee_department_history; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.employee_department_history IS 'Employee department transfers.';


--
-- Name: COLUMN employee_department_history.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_department_history.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN employee_department_history.departmentid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_department_history.departmentid IS 'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.';


--
-- Name: COLUMN employee_department_history.shiftid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_department_history.shiftid IS 'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.';


--
-- Name: COLUMN employee_department_history.startdate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_department_history.startdate IS 'Date the employee started work in the department.';


--
-- Name: COLUMN employee_department_history.enddate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_department_history.enddate IS 'Date the employee left the department. NULL = Current department.';


--
-- Name: employee_pay_history; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_pay_history (
    businessentityid integer NOT NULL,
    ratechangedate timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    payfrequency smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((payfrequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);


ALTER TABLE human_resources.employee_pay_history OWNER TO postgres;

--
-- Name: TABLE employee_pay_history; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.employee_pay_history IS 'Employee pay history.';


--
-- Name: COLUMN employee_pay_history.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_pay_history.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN employee_pay_history.ratechangedate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_pay_history.ratechangedate IS 'Date the change in pay is effective';


--
-- Name: COLUMN employee_pay_history.rate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_pay_history.rate IS 'Salary hourly rate.';


--
-- Name: COLUMN employee_pay_history.payfrequency; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employee_pay_history.payfrequency IS '1 = Salary received monthly, 2 = Salary received biweekly';


--
-- Name: job_candidate; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.job_candidate (
    jobcandidateid integer NOT NULL,
    businessentityid integer,
    resume xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.job_candidate OWNER TO postgres;

--
-- Name: TABLE job_candidate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.job_candidate IS 'RÃ©sumÃ©s submitted to Human Resources by job applicants.';


--
-- Name: COLUMN job_candidate.jobcandidateid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.job_candidate.jobcandidateid IS 'Primary key for JobCandidate records.';


--
-- Name: COLUMN job_candidate.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.job_candidate.businessentityid IS 'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN job_candidate.resume; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.job_candidate.resume IS 'RÃ©sumÃ© in XML format.';


--
-- Name: shift; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.shift (
    shiftid integer NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.shift OWNER TO postgres;

--
-- Name: TABLE shift; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.shift IS 'Work shift lookup table.';


--
-- Name: COLUMN shift.shiftid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.shift.shiftid IS 'Primary key for Shift records.';


--
-- Name: COLUMN shift.starttime; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.shift.starttime IS 'Shift start time.';


--
-- Name: COLUMN shift.endtime; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.shift.endtime IS 'Shift end time.';


--
-- Name: vjobcandidate; Type: VIEW; Schema: human_resources; Owner: postgres
--

CREATE VIEW human_resources.vjobcandidate AS
 SELECT job_candidate.jobcandidateid,
    job_candidate.businessentityid,
    ((xpath('/n:Resume/n:Name/n:Name.Prefix/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Prefix",
    ((xpath('/n:Resume/n:Name/n:Name.First/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.First",
    ((xpath('/n:Resume/n:Name/n:Name.Middle/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Middle",
    ((xpath('/n:Resume/n:Name/n:Name.Last/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Last",
    ((xpath('/n:Resume/n:Name/n:Name.Suffix/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Suffix",
    ((xpath('/n:Resume/n:Skills/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "Skills",
    ((xpath('n:Address/n:Addr.Type/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Addr.Type",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.CountryRegion/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.CountryRegion",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.State/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.State",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.City/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.City",
    ((xpath('n:Address/n:Addr.PostalCode/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(20) AS "Addr.PostalCode",
    ((xpath('/n:Resume/n:EMail/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "EMail",
    ((xpath('/n:Resume/n:WebSite/text()'::text, job_candidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "WebSite",
    job_candidate.modifieddate
   FROM human_resources.job_candidate;


ALTER TABLE human_resources.vjobcandidate OWNER TO postgres;

--
-- Name: vjobcandidateeducation; Type: VIEW; Schema: human_resources; Owner: postgres
--

CREATE VIEW human_resources.vjobcandidateeducation AS
 SELECT jc.jobcandidateid,
    ((xpath('/root/ns:Education/ns:Edu.Level/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Level",
    (((xpath('/root/ns:Education/ns:Edu.StartDate/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(20))::date AS "Edu.StartDate",
    (((xpath('/root/ns:Education/ns:Edu.EndDate/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(20))::date AS "Edu.EndDate",
    ((xpath('/root/ns:Education/ns:Edu.Degree/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Degree",
    ((xpath('/root/ns:Education/ns:Edu.Major/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Major",
    ((xpath('/root/ns:Education/ns:Edu.Minor/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Minor",
    ((xpath('/root/ns:Education/ns:Edu.GPA/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(5) AS "Edu.GPA",
    ((xpath('/root/ns:Education/ns:Edu.GPAScale/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(5) AS "Edu.GPAScale",
    ((xpath('/root/ns:Education/ns:Edu.School/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.School",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.CountryRegion",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.State/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.State",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.City/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.City"
   FROM ( SELECT unnesting.jobcandidateid,
            ((('<root xmlns:ns="http://adventureworks.com">'::text || ((unnesting.education)::character varying)::text) || '</root>'::text))::xml AS doc
           FROM ( SELECT job_candidate.jobcandidateid,
                    unnest(xpath('/ns:Resume/ns:Education'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])) AS education
                   FROM human_resources.job_candidate) unnesting) jc;


ALTER TABLE human_resources.vjobcandidateeducation OWNER TO postgres;

--
-- Name: vjobcandidateemployment; Type: VIEW; Schema: human_resources; Owner: postgres
--

CREATE VIEW human_resources.vjobcandidateemployment AS
 SELECT job_candidate.jobcandidateid,
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.StartDate/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.StartDate",
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.EndDate/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.EndDate",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.OrgName/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.OrgName",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.JobTitle/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.JobTitle",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Responsibility/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Responsibility",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.FunctionCategory/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.FunctionCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.IndustryCategory/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.IndustryCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.CountryRegion",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.State/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.State",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.City/text()'::text, job_candidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.City"
   FROM human_resources.job_candidate;


ALTER TABLE human_resources.vjobcandidateemployment OWNER TO postgres;

--
-- Name: address; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.address (
    addressid integer NOT NULL,
    addressline1 character varying(60) NOT NULL,
    addressline2 character varying(60),
    city character varying(30) NOT NULL,
    stateprovinceid integer NOT NULL,
    zipcode character varying(15) NOT NULL,
    spatiallocation character varying(44),
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.address OWNER TO postgres;

--
-- Name: TABLE address; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.address IS 'Street address information for customers, employees, and vendors.';


--
-- Name: COLUMN address.addressid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address.addressid IS 'Primary key for Address records.';


--
-- Name: COLUMN address.addressline1; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address.addressline1 IS 'First street address line.';


--
-- Name: COLUMN address.addressline2; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address.addressline2 IS 'Second street address line.';


--
-- Name: COLUMN address.city; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address.city IS 'Name of the city.';


--
-- Name: COLUMN address.stateprovinceid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address.stateprovinceid IS 'Unique identification number for the state or province. Foreign key to StateProvince table.';


--
-- Name: COLUMN address.spatiallocation; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address.spatiallocation IS 'Latitude and longitude of this address.';


--
-- Name: address_type; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.address_type (
    addresstypeid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.address_type OWNER TO postgres;

--
-- Name: TABLE address_type; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.address_type IS 'Types of addresses stored in the Address table.';


--
-- Name: COLUMN address_type.addresstypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.address_type.addresstypeid IS 'Primary key for AddressType records.';


--
-- Name: business_entity; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.business_entity (
    businessentityid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.business_entity OWNER TO postgres;

--
-- Name: TABLE business_entity; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.business_entity IS 'Source of the ID that connects vendors, customers, and employees with address and contact information.';


--
-- Name: COLUMN business_entity.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity.businessentityid IS 'Primary key for all customers, vendors, and employees.';


--
-- Name: business_entity_address; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.business_entity_address (
    businessentityid integer NOT NULL,
    addressid integer NOT NULL,
    addresstypeid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.business_entity_address OWNER TO postgres;

--
-- Name: TABLE business_entity_address; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.business_entity_address IS 'Cross-reference table mapping customers, vendors, and employees to their addresses.';


--
-- Name: COLUMN business_entity_address.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity_address.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN business_entity_address.addressid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity_address.addressid IS 'Primary key. Foreign key to Address.AddressID.';


--
-- Name: COLUMN business_entity_address.addresstypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity_address.addresstypeid IS 'Primary key. Foreign key to AddressType.AddressTypeID.';


--
-- Name: business_entity_contact; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.business_entity_contact (
    businessentityid integer NOT NULL,
    personid integer NOT NULL,
    contacttypeid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.business_entity_contact OWNER TO postgres;

--
-- Name: TABLE business_entity_contact; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.business_entity_contact IS 'Cross-reference table mapping stores, vendors, and employees to people';


--
-- Name: COLUMN business_entity_contact.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity_contact.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN business_entity_contact.personid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity_contact.personid IS 'Primary key. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN business_entity_contact.contacttypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.business_entity_contact.contacttypeid IS 'Primary key.  Foreign key to ContactType.ContactTypeID.';


--
-- Name: contact_type; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.contact_type (
    contacttypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.contact_type OWNER TO postgres;

--
-- Name: TABLE contact_type; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.contact_type IS 'Lookup table containing the types of business entity contacts.';


--
-- Name: COLUMN contact_type.contacttypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.contact_type.contacttypeid IS 'Primary key for ContactType records.';


--
-- Name: country_region; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.country_region (
    countryregioncode character varying(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.country_region OWNER TO postgres;

--
-- Name: TABLE country_region; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.country_region IS 'Lookup table containing the ISO standard codes for countries and regions.';


--
-- Name: COLUMN country_region.countryregioncode; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.country_region.countryregioncode IS 'ISO standard code for countries and regions.';


--
-- Name: email_address; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.email_address (
    businessentityid integer NOT NULL,
    emailaddressid integer NOT NULL,
    emailaddress character varying(50),
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.email_address OWNER TO postgres;

--
-- Name: TABLE email_address; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.email_address IS 'Where to send a person email.';


--
-- Name: COLUMN email_address.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.email_address.businessentityid IS 'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID';


--
-- Name: COLUMN email_address.emailaddressid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.email_address.emailaddressid IS 'Primary key. ID of this email address.';


--
-- Name: COLUMN email_address.emailaddress; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.email_address.emailaddress IS 'E-mail address for the person.';


--
-- Name: password; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.password (
    businessentityid integer NOT NULL,
    passwordhash character varying(128) NOT NULL,
    passwordsalt character varying(10) NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.password OWNER TO postgres;

--
-- Name: TABLE password; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.password IS 'One way hashed authentication information';


--
-- Name: COLUMN password.passwordhash; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.password.passwordhash IS 'Password for the e-mail account.';


--
-- Name: COLUMN password.passwordsalt; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.password.passwordsalt IS 'Random value concatenated with the password string before the password is hashed.';


--
-- Name: person; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.person (
    businessentityid integer NOT NULL,
    persontype character(2) NOT NULL,
    title character varying(8),
    suffix character varying(10),
    emailpromotion integer DEFAULT 0 NOT NULL,
    additionalcontactinfo xml,
    demographics xml,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (((emailpromotion >= 0) AND (emailpromotion <= 2))),
    CONSTRAINT "CK_Person_PersonType" CHECK (((persontype IS NULL) OR (upper((persontype)::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text]))))
);


ALTER TABLE person.person OWNER TO postgres;

--
-- Name: TABLE person; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.person IS 'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.';


--
-- Name: COLUMN person.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.businessentityid IS 'Primary key for Person records.';


--
-- Name: COLUMN person.persontype; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.persontype IS 'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact';


--
-- Name: COLUMN person.title; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.title IS 'A courtesy title. For example, Mr. or Ms.';


--
-- Name: COLUMN person.suffix; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.suffix IS 'Surname suffix. For example, Sr. or Jr.';


--
-- Name: COLUMN person.emailpromotion; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.emailpromotion IS '0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners.';


--
-- Name: COLUMN person.additionalcontactinfo; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.additionalcontactinfo IS 'Additional contact information about the person stored in xml format.';


--
-- Name: COLUMN person.demographics; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person.demographics IS 'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.';


--
-- Name: person_phone; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.person_phone (
    businessentityid integer NOT NULL,
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.person_phone OWNER TO postgres;

--
-- Name: TABLE person_phone; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.person_phone IS 'Telephone number and type of a person.';


--
-- Name: COLUMN person_phone.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person_phone.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN person_phone.phonenumbertypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.person_phone.phonenumbertypeid IS 'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.';


--
-- Name: phone_number_type; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.phone_number_type (
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.phone_number_type OWNER TO postgres;

--
-- Name: TABLE phone_number_type; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.phone_number_type IS 'Type of phone number of a person.';


--
-- Name: COLUMN phone_number_type.phonenumbertypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.phone_number_type.phonenumbertypeid IS 'Primary key for telephone number type records.';


--
-- Name: state_province; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.state_province (
    stateprovinceid integer NOT NULL,
    stateprovincecode character(3) NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    territoryid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.state_province OWNER TO postgres;

--
-- Name: TABLE state_province; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.state_province IS 'State and province lookup table.';


--
-- Name: COLUMN state_province.stateprovinceid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.state_province.stateprovinceid IS 'Primary key for StateProvince records.';


--
-- Name: COLUMN state_province.stateprovincecode; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.state_province.stateprovincecode IS 'ISO standard state or province code.';


--
-- Name: COLUMN state_province.countryregioncode; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.state_province.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN state_province.territoryid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.state_province.territoryid IS 'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: bill_of_materials; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.bill_of_materials (
    billofmaterialsid integer NOT NULL,
    productassemblyid integer,
    componentid integer NOT NULL,
    startdate timestamp without time zone DEFAULT now() NOT NULL,
    enddate timestamp without time zone,
    unitmeasurecode character(3) NOT NULL,
    bomlevel smallint NOT NULL,
    perassemblyqty numeric(8,2) DEFAULT 1.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK ((((productassemblyid IS NULL) AND (bomlevel = 0) AND (perassemblyqty = 1.00)) OR ((productassemblyid IS NOT NULL) AND (bomlevel >= 1)))),
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (((enddate > startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK ((perassemblyqty >= 1.00)),
    CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK ((productassemblyid <> componentid))
);


ALTER TABLE production.bill_of_materials OWNER TO postgres;

--
-- Name: COLUMN bill_of_materials.billofmaterialsid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.billofmaterialsid IS 'Primary key for BillOfMaterials records.';


--
-- Name: COLUMN bill_of_materials.productassemblyid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.productassemblyid IS 'Parent product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN bill_of_materials.componentid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.componentid IS 'Component identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN bill_of_materials.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.startdate IS 'Date the component started being used in the assembly item.';


--
-- Name: COLUMN bill_of_materials.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.enddate IS 'Date the component stopped being used in the assembly item.';


--
-- Name: COLUMN bill_of_materials.unitmeasurecode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.unitmeasurecode IS 'Standard code identifying the unit of measure for the quantity.';


--
-- Name: COLUMN bill_of_materials.bomlevel; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.bomlevel IS 'Indicates the depth the component is from its parent (AssemblyID).';


--
-- Name: COLUMN bill_of_materials.perassemblyqty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.bill_of_materials.perassemblyqty IS 'Quantity of the component needed to create the assembly.';


--
-- Name: culture; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.culture (
    cultureid character(6) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.culture OWNER TO postgres;

--
-- Name: TABLE culture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.culture IS 'Lookup table containing the languages in which some AdventureWorks data is stored.';


--
-- Name: COLUMN culture.cultureid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.culture.cultureid IS 'Primary key for Culture records.';


--
-- Name: document; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.document (
    title character varying(50) NOT NULL,
    owner integer NOT NULL,
    filename character varying(400) NOT NULL,
    fileextension character varying(8),
    revision character(5) NOT NULL,
    changenumber integer DEFAULT 0 NOT NULL,
    status smallint NOT NULL,
    documentsummary text,
    document bytea,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL,
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
-- Name: COLUMN document.filename; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.filename IS 'File name of the document';


--
-- Name: COLUMN document.fileextension; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.fileextension IS 'File extension indicating the document type. For example, .doc or .txt.';


--
-- Name: COLUMN document.revision; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.revision IS 'Revision number of the document.';


--
-- Name: COLUMN document.changenumber; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.changenumber IS 'Engineering change approval number.';


--
-- Name: COLUMN document.status; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.status IS '1 = Pending approval, 2 = Approved, 3 = Obsolete';


--
-- Name: COLUMN document.documentsummary; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.documentsummary IS 'Document abstract.';


--
-- Name: COLUMN document.document; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.document IS 'Complete document.';


--
-- Name: COLUMN document.rowguid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.rowguid IS 'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.';


--
-- Name: COLUMN document.documentnode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.document.documentnode IS 'Primary key for Document records.';


--
-- Name: illustration; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.illustration (
    illustrationid integer NOT NULL,
    diagram xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.illustration OWNER TO postgres;

--
-- Name: TABLE illustration; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.illustration IS 'Bicycle assembly diagrams.';


--
-- Name: COLUMN illustration.illustrationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.illustration.illustrationid IS 'Primary key for Illustration records.';


--
-- Name: COLUMN illustration.diagram; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.illustration.diagram IS 'Illustrations used in manufacturing instructions. Stored as XML.';


--
-- Name: location; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.location (
    locationid integer NOT NULL,
    costrate numeric DEFAULT 0.00 NOT NULL,
    availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((costrate >= 0.00))
);


ALTER TABLE production.location OWNER TO postgres;

--
-- Name: TABLE location; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.location IS 'Product inventory and manufacturing locations.';


--
-- Name: COLUMN location.locationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.location.locationid IS 'Primary key for Location records.';


--
-- Name: COLUMN location.costrate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.location.costrate IS 'Standard hourly cost of the manufacturing location.';


--
-- Name: COLUMN location.availability; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.location.availability IS 'Work capacity (in hours) of the manufacturing location.';


--
-- Name: product; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product (
    productid integer NOT NULL,
    productnumber character varying(25) NOT NULL,
    color character varying(15),
    safetystocklevel smallint NOT NULL,
    reorderpoint smallint NOT NULL,
    standardcost numeric NOT NULL,
    listprice numeric NOT NULL,
    size character varying(5),
    sizeunitmeasurecode character(3),
    weightunitmeasurecode character(3),
    weight numeric(8,2),
    daystomanufacture integer NOT NULL,
    productline character(2),
    class character(2),
    style character(2),
    productsubcategoryid integer,
    productmodelid integer,
    sellstartdate timestamp without time zone NOT NULL,
    sellenddate timestamp without time zone,
    discontinueddate timestamp without time zone,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Product_Class" CHECK (((upper((class)::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR (class IS NULL))),
    CONSTRAINT "CK_Product_DaysToManufacture" CHECK ((daystomanufacture >= 0)),
    CONSTRAINT "CK_Product_ListPrice" CHECK ((listprice >= 0.00)),
    CONSTRAINT "CK_Product_ProductLine" CHECK (((upper((productline)::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR (productline IS NULL))),
    CONSTRAINT "CK_Product_ReorderPoint" CHECK ((reorderpoint > 0)),
    CONSTRAINT "CK_Product_SafetyStockLevel" CHECK ((safetystocklevel > 0)),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (((sellenddate >= sellstartdate) OR (sellenddate IS NULL))),
    CONSTRAINT "CK_Product_StandardCost" CHECK ((standardcost >= 0.00)),
    CONSTRAINT "CK_Product_Style" CHECK (((upper((style)::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR (style IS NULL))),
    CONSTRAINT "CK_Product_Weight" CHECK ((weight > 0.00))
);


ALTER TABLE production.product OWNER TO postgres;

--
-- Name: TABLE product; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product IS 'Products sold or used in the manfacturing of sold products.';


--
-- Name: COLUMN product.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.productid IS 'Primary key for Product records.';


--
-- Name: COLUMN product.productnumber; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.productnumber IS 'Unique product identification number.';


--
-- Name: COLUMN product.color; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.color IS 'Product color.';


--
-- Name: COLUMN product.safetystocklevel; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.safetystocklevel IS 'Minimum inventory quantity.';


--
-- Name: COLUMN product.reorderpoint; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.reorderpoint IS 'Inventory level that triggers a purchase order or work order.';


--
-- Name: COLUMN product.standardcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.standardcost IS 'Standard cost of the product.';


--
-- Name: COLUMN product.listprice; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.listprice IS 'Selling price.';


--
-- Name: COLUMN product.size; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.size IS 'Product size.';


--
-- Name: COLUMN product.sizeunitmeasurecode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.sizeunitmeasurecode IS 'Unit of measure for Size column.';


--
-- Name: COLUMN product.weightunitmeasurecode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.weightunitmeasurecode IS 'Unit of measure for Weight column.';


--
-- Name: COLUMN product.weight; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.weight IS 'Product weight.';


--
-- Name: COLUMN product.daystomanufacture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.daystomanufacture IS 'Number of days required to manufacture the product.';


--
-- Name: COLUMN product.productline; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.productline IS 'R = Road, M = Mountain, T = Touring, S = Standard';


--
-- Name: COLUMN product.class; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.class IS 'H = High, M = Medium, L = Low';


--
-- Name: COLUMN product.style; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.style IS 'W = Womens, M = Mens, U = Universal';


--
-- Name: COLUMN product.productsubcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.productsubcategoryid IS 'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID.';


--
-- Name: COLUMN product.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.productmodelid IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN product.sellstartdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.sellstartdate IS 'Date the product was available for sale.';


--
-- Name: COLUMN product.sellenddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.sellenddate IS 'Date the product was no longer available for sale.';


--
-- Name: COLUMN product.discontinueddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product.discontinueddate IS 'Date the product was discontinued.';


--
-- Name: product_category; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_category (
    productcategoryid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_category OWNER TO postgres;

--
-- Name: TABLE product_category; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_category IS 'High-level product categorization.';


--
-- Name: COLUMN product_category.productcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_category.productcategoryid IS 'Primary key for ProductCategory records.';


--
-- Name: product_cost_history; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_cost_history (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    standardcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standardcost >= 0.00))
);


ALTER TABLE production.product_cost_history OWNER TO postgres;

--
-- Name: TABLE product_cost_history; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_cost_history IS 'Changes in the cost of a product over time.';


--
-- Name: COLUMN product_cost_history.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.productid IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN product_cost_history.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.startdate IS 'Product cost start date.';


--
-- Name: COLUMN product_cost_history.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.enddate IS 'Product cost end date.';


--
-- Name: COLUMN product_cost_history.standardcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_cost_history.standardcost IS 'Standard cost of the product.';


--
-- Name: product_description; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_description (
    productdescriptionid integer NOT NULL,
    description character varying(400) NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_description OWNER TO postgres;

--
-- Name: TABLE product_description; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_description IS 'Product descriptions in several languages.';


--
-- Name: COLUMN product_description.productdescriptionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_description.productdescriptionid IS 'Primary key for ProductDescription records.';


--
-- Name: COLUMN product_description.description; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_description.description IS 'Description of the product.';


--
-- Name: product_document; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_document (
    productid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE production.product_document OWNER TO postgres;

--
-- Name: TABLE product_document; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_document IS 'Cross-reference table mapping products to related product documents.';


--
-- Name: COLUMN product_document.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_document.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_document.documentnode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_document.documentnode IS 'Document identification number. Foreign key to Document.DocumentNode.';


--
-- Name: product_inventory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_inventory (
    productid integer NOT NULL,
    locationid smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE production.product_inventory OWNER TO postgres;

--
-- Name: TABLE product_inventory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_inventory IS 'Product inventory information.';


--
-- Name: COLUMN product_inventory.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_inventory.locationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_inventory.locationid IS 'Inventory location identification number. Foreign key to Location.LocationID.';


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
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    listprice numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((listprice > 0.00))
);


ALTER TABLE production.product_list_price_history OWNER TO postgres;

--
-- Name: TABLE product_list_price_history; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_list_price_history IS 'Changes in the list price of a product over time.';


--
-- Name: COLUMN product_list_price_history.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.productid IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN product_list_price_history.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.startdate IS 'List price start date.';


--
-- Name: COLUMN product_list_price_history.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.enddate IS 'List price end date';


--
-- Name: COLUMN product_list_price_history.listprice; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_list_price_history.listprice IS 'Product list price.';


--
-- Name: product_model; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_model (
    productmodelid integer NOT NULL,
    catalogdescription xml,
    instructions xml,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_model OWNER TO postgres;

--
-- Name: TABLE product_model; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_model IS 'Product model classification.';


--
-- Name: COLUMN product_model.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model.productmodelid IS 'Primary key for ProductModel records.';


--
-- Name: COLUMN product_model.catalogdescription; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model.catalogdescription IS 'Detailed product catalog information in xml format.';


--
-- Name: COLUMN product_model.instructions; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model.instructions IS 'Manufacturing instructions in xml format.';


--
-- Name: product_model_illustration; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_model_illustration (
    productmodelid integer NOT NULL,
    illustrationid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_model_illustration OWNER TO postgres;

--
-- Name: TABLE product_model_illustration; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_model_illustration IS 'Cross-reference table mapping product models and illustrations.';


--
-- Name: COLUMN product_model_illustration.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model_illustration.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN product_model_illustration.illustrationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model_illustration.illustrationid IS 'Primary key. Foreign key to Illustration.IllustrationID.';


--
-- Name: product_model_product_description_culture; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_model_product_description_culture (
    productmodelid integer NOT NULL,
    productdescriptionid integer NOT NULL,
    cultureid character(6) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_model_product_description_culture OWNER TO postgres;

--
-- Name: TABLE product_model_product_description_culture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_model_product_description_culture IS 'Cross-reference table mapping product descriptions and the language the description is written in.';


--
-- Name: COLUMN product_model_product_description_culture.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model_product_description_culture.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN product_model_product_description_culture.productdescriptionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model_product_description_culture.productdescriptionid IS 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';


--
-- Name: COLUMN product_model_product_description_culture.cultureid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_model_product_description_culture.cultureid IS 'Culture identification number. Foreign key to Culture.CultureID.';


--
-- Name: product_photo; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_photo (
    productphotoid integer NOT NULL,
    thumbnailphoto bytea,
    thumbnailphotofilename character varying(50),
    largephoto bytea,
    largephotofilename character varying(50),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_photo OWNER TO postgres;

--
-- Name: TABLE product_photo; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_photo IS 'Product images.';


--
-- Name: COLUMN product_photo.productphotoid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_photo.productphotoid IS 'Primary key for ProductPhoto records.';


--
-- Name: COLUMN product_photo.thumbnailphoto; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_photo.thumbnailphoto IS 'Small image of the product.';


--
-- Name: COLUMN product_photo.thumbnailphotofilename; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_photo.thumbnailphotofilename IS 'Small image file name.';


--
-- Name: COLUMN product_photo.largephoto; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_photo.largephoto IS 'Large image of the product.';


--
-- Name: COLUMN product_photo.largephotofilename; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_photo.largephotofilename IS 'Large image file name.';


--
-- Name: product_product_photo; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_product_photo (
    productid integer NOT NULL,
    productphotoid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_product_photo OWNER TO postgres;

--
-- Name: TABLE product_product_photo; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_product_photo IS 'Cross-reference table mapping products and product photos.';


--
-- Name: COLUMN product_product_photo.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_product_photo.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_product_photo.productphotoid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_product_photo.productphotoid IS 'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';


--
-- Name: product_review; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.product_review (
    productreviewid integer NOT NULL,
    productid integer NOT NULL,
    reviewdate timestamp without time zone DEFAULT now() NOT NULL,
    emailaddress character varying(50) NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE production.product_review OWNER TO postgres;

--
-- Name: TABLE product_review; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_review IS 'Customer reviews of products they have purchased.';


--
-- Name: COLUMN product_review.productreviewid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.productreviewid IS 'Primary key for ProductReview records.';


--
-- Name: COLUMN product_review.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_review.reviewdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.reviewdate IS 'Date review was submitted.';


--
-- Name: COLUMN product_review.emailaddress; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_review.emailaddress IS 'Reviewer''s e-mail address.';


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
    productsubcategoryid integer NOT NULL,
    productcategoryid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.product_subcategory OWNER TO postgres;

--
-- Name: TABLE product_subcategory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.product_subcategory IS 'Product subcategories. See ProductCategory table.';


--
-- Name: COLUMN product_subcategory.productsubcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_subcategory.productsubcategoryid IS 'Primary key for ProductSubcategory records.';


--
-- Name: COLUMN product_subcategory.productcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.product_subcategory.productcategoryid IS 'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';


--
-- Name: scrap_reason; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.scrap_reason (
    scrapreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.scrap_reason OWNER TO postgres;

--
-- Name: TABLE scrap_reason; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.scrap_reason IS 'Manufacturing failure reasons lookup table.';


--
-- Name: COLUMN scrap_reason.scrapreasonid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.scrap_reason.scrapreasonid IS 'Primary key for ScrapReason records.';


--
-- Name: transaction_history; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.transaction_history (
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer DEFAULT 0 NOT NULL,
    transactiondate timestamp without time zone DEFAULT now() NOT NULL,
    transactiontype character(1) NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK ((upper((transactiontype)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE production.transaction_history OWNER TO postgres;

--
-- Name: TABLE transaction_history; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.transaction_history IS 'Record of each purchase order, sales order, or work order transaction year to date.';


--
-- Name: COLUMN transaction_history.transactionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.transactionid IS 'Primary key for TransactionHistory records.';


--
-- Name: COLUMN transaction_history.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transaction_history.referenceorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.referenceorderid IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transaction_history.referenceorderlineid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transaction_history.transactiondate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.transactiondate IS 'Date and time of the transaction.';


--
-- Name: COLUMN transaction_history.transactiontype; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.transactiontype IS 'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';


--
-- Name: COLUMN transaction_history.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.quantity IS 'Product quantity.';


--
-- Name: COLUMN transaction_history.actualcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history.actualcost IS 'Product cost.';


--
-- Name: transaction_history_archive; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.transaction_history_archive (
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer DEFAULT 0 NOT NULL,
    transactiondate timestamp without time zone DEFAULT now() NOT NULL,
    transactiontype character(1) NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK ((upper((transactiontype)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE production.transaction_history_archive OWNER TO postgres;

--
-- Name: TABLE transaction_history_archive; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.transaction_history_archive IS 'Transactions for previous years.';


--
-- Name: COLUMN transaction_history_archive.transactionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.transactionid IS 'Primary key for TransactionHistoryArchive records.';


--
-- Name: COLUMN transaction_history_archive.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transaction_history_archive.referenceorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.referenceorderid IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transaction_history_archive.referenceorderlineid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transaction_history_archive.transactiondate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.transactiondate IS 'Date and time of the transaction.';


--
-- Name: COLUMN transaction_history_archive.transactiontype; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.transactiontype IS 'W = Work Order, S = Sales Order, P = Purchase Order';


--
-- Name: COLUMN transaction_history_archive.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.quantity IS 'Product quantity.';


--
-- Name: COLUMN transaction_history_archive.actualcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transaction_history_archive.actualcost IS 'Product cost.';


--
-- Name: unit_measure; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.unit_measure (
    unitmeasurecode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.unit_measure OWNER TO postgres;

--
-- Name: TABLE unit_measure; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.unit_measure IS 'Unit of measure lookup table.';


--
-- Name: COLUMN unit_measure.unitmeasurecode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.unit_measure.unitmeasurecode IS 'Primary key.';


--
-- Name: work_order; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.work_order (
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    orderqty integer NOT NULL,
    scrappedqty smallint NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    duedate timestamp without time zone NOT NULL,
    scrapreasonid smallint,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrder_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_WorkOrder_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK ((scrappedqty >= 0))
);


ALTER TABLE production.work_order OWNER TO postgres;

--
-- Name: TABLE work_order; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.work_order IS 'Manufacturing work orders.';


--
-- Name: COLUMN work_order.workorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.workorderid IS 'Primary key for WorkOrder records.';


--
-- Name: COLUMN work_order.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN work_order.orderqty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.orderqty IS 'Product quantity to build.';


--
-- Name: COLUMN work_order.scrappedqty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.scrappedqty IS 'Quantity that failed inspection.';


--
-- Name: COLUMN work_order.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.startdate IS 'Work order start date.';


--
-- Name: COLUMN work_order.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.enddate IS 'Work order end date.';


--
-- Name: COLUMN work_order.duedate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.duedate IS 'Work order due date.';


--
-- Name: COLUMN work_order.scrapreasonid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order.scrapreasonid IS 'Reason for inspection failure.';


--
-- Name: work_order_routing; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.work_order_routing (
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    operationsequence smallint NOT NULL,
    locationid smallint NOT NULL,
    scheduledstartdate timestamp without time zone NOT NULL,
    scheduledenddate timestamp without time zone NOT NULL,
    actualstartdate timestamp without time zone,
    actualenddate timestamp without time zone,
    actualresourcehrs numeric(9,4),
    plannedcost numeric NOT NULL,
    actualcost numeric,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK ((actualcost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK (((actualenddate >= actualstartdate) OR (actualenddate IS NULL) OR (actualstartdate IS NULL))),
    CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK ((actualresourcehrs >= 0.0000)),
    CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK ((plannedcost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK ((scheduledenddate >= scheduledstartdate))
);


ALTER TABLE production.work_order_routing OWNER TO postgres;

--
-- Name: TABLE work_order_routing; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.work_order_routing IS 'Work order details.';


--
-- Name: COLUMN work_order_routing.workorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.workorderid IS 'Primary key. Foreign key to WorkOrder.WorkOrderID.';


--
-- Name: COLUMN work_order_routing.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.productid IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN work_order_routing.operationsequence; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.operationsequence IS 'Primary key. Indicates the manufacturing process sequence.';


--
-- Name: COLUMN work_order_routing.locationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.locationid IS 'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';


--
-- Name: COLUMN work_order_routing.scheduledstartdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.scheduledstartdate IS 'Planned manufacturing start date.';


--
-- Name: COLUMN work_order_routing.scheduledenddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.scheduledenddate IS 'Planned manufacturing end date.';


--
-- Name: COLUMN work_order_routing.actualstartdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actualstartdate IS 'Actual start date.';


--
-- Name: COLUMN work_order_routing.actualenddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actualenddate IS 'Actual end date.';


--
-- Name: COLUMN work_order_routing.actualresourcehrs; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actualresourcehrs IS 'Number of manufacturing hours used.';


--
-- Name: COLUMN work_order_routing.plannedcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.plannedcost IS 'Estimated manufacturing cost.';


--
-- Name: COLUMN work_order_routing.actualcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.work_order_routing.actualcost IS 'Actual manufacturing cost.';


--
-- Name: product_vendor; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.product_vendor (
    productid integer NOT NULL,
    businessentityid integer NOT NULL,
    averageleadtime integer NOT NULL,
    standardprice numeric NOT NULL,
    lastreceiptcost numeric,
    lastreceiptdate timestamp without time zone,
    minorderqty integer NOT NULL,
    maxorderqty integer NOT NULL,
    onorderqty integer,
    unitmeasurecode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK ((averageleadtime >= 1)),
    CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK ((lastreceiptcost > 0.00)),
    CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK ((maxorderqty >= 1)),
    CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK ((minorderqty >= 1)),
    CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK ((onorderqty >= 0)),
    CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK ((standardprice > 0.00))
);


ALTER TABLE purchasing.product_vendor OWNER TO postgres;

--
-- Name: COLUMN product_vendor.productid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.productid IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN product_vendor.businessentityid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.businessentityid IS 'Primary key. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN product_vendor.averageleadtime; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.averageleadtime IS 'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.';


--
-- Name: COLUMN product_vendor.standardprice; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.standardprice IS 'The vendor''s usual selling price.';


--
-- Name: COLUMN product_vendor.lastreceiptcost; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.lastreceiptcost IS 'The selling price when last purchased.';


--
-- Name: COLUMN product_vendor.lastreceiptdate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.lastreceiptdate IS 'Date the product was last received by the vendor.';


--
-- Name: COLUMN product_vendor.minorderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.minorderqty IS 'The maximum quantity that should be ordered.';


--
-- Name: COLUMN product_vendor.maxorderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.maxorderqty IS 'The minimum quantity that should be ordered.';


--
-- Name: COLUMN product_vendor.onorderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.onorderqty IS 'The quantity currently on order.';


--
-- Name: COLUMN product_vendor.unitmeasurecode; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.product_vendor.unitmeasurecode IS 'The product''s unit of measure.';


--
-- Name: purchase_order_detail; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order_detail (
    purchaseorderid integer NOT NULL,
    purchaseorderdetailid integer NOT NULL,
    duedate timestamp without time zone NOT NULL,
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    unitprice numeric NOT NULL,
    receivedqty numeric(8,2) NOT NULL,
    rejectedqty numeric(8,2) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK ((receivedqty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK ((rejectedqty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK ((unitprice >= 0.00))
);


ALTER TABLE purchasing.purchase_order_detail OWNER TO postgres;

--
-- Name: COLUMN purchase_order_detail.purchaseorderid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.purchaseorderid IS 'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.';


--
-- Name: COLUMN purchase_order_detail.purchaseorderdetailid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.purchaseorderdetailid IS 'Primary key. One line number per purchased product.';


--
-- Name: COLUMN purchase_order_detail.duedate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.duedate IS 'Date the product is expected to be received.';


--
-- Name: COLUMN purchase_order_detail.orderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.orderqty IS 'Quantity ordered.';


--
-- Name: COLUMN purchase_order_detail.productid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN purchase_order_detail.unitprice; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.unitprice IS 'Vendor''s selling price of a single product.';


--
-- Name: COLUMN purchase_order_detail.receivedqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.receivedqty IS 'Quantity actually received from the vendor.';


--
-- Name: COLUMN purchase_order_detail.rejectedqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_detail.rejectedqty IS 'Quantity rejected during inspection.';


--
-- Name: purchase_order_header; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order_header (
    purchaseorderid integer NOT NULL,
    revisionnumber smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    employeeid integer NOT NULL,
    vendorid integer NOT NULL,
    shipmethodid integer NOT NULL,
    orderdate timestamp without time zone DEFAULT now() NOT NULL,
    shipdate timestamp without time zone,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    taxamt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_PurchaseOrderHeader_Status" CHECK (((status >= 1) AND (status <= 4))),
    CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);


ALTER TABLE purchasing.purchase_order_header OWNER TO postgres;

--
-- Name: COLUMN purchase_order_header.purchaseorderid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.purchaseorderid IS 'Primary key.';


--
-- Name: COLUMN purchase_order_header.revisionnumber; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.revisionnumber IS 'Incremental number to track changes to the purchase order over time.';


--
-- Name: COLUMN purchase_order_header.status; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.status IS 'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';


--
-- Name: COLUMN purchase_order_header.employeeid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.employeeid IS 'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN purchase_order_header.vendorid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.vendorid IS 'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN purchase_order_header.shipmethodid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN purchase_order_header.orderdate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.orderdate IS 'Purchase order creation date.';


--
-- Name: COLUMN purchase_order_header.shipdate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.shipdate IS 'Estimated shipment date from the vendor.';


--
-- Name: COLUMN purchase_order_header.subtotal; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.subtotal IS 'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';


--
-- Name: COLUMN purchase_order_header.taxamt; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.taxamt IS 'Tax amount.';


--
-- Name: COLUMN purchase_order_header.freight; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchase_order_header.freight IS 'Shipping cost.';


--
-- Name: ship_method; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.ship_method (
    shipmethodid integer NOT NULL,
    shipbase numeric DEFAULT 0.00 NOT NULL,
    shiprate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((shipbase > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shiprate > 0.00))
);


ALTER TABLE purchasing.ship_method OWNER TO postgres;

--
-- Name: TABLE ship_method; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.ship_method IS 'Shipping company lookup table.';


--
-- Name: COLUMN ship_method.shipmethodid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.ship_method.shipmethodid IS 'Primary key for ShipMethod records.';


--
-- Name: COLUMN ship_method.shipbase; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.ship_method.shipbase IS 'Minimum shipping charge.';


--
-- Name: COLUMN ship_method.shiprate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.ship_method.shiprate IS 'Shipping charge per pound.';


--
-- Name: vendor; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.vendor (
    businessentityid integer NOT NULL,
    creditrating smallint NOT NULL,
    purchasingwebserviceurl character varying(1024),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((creditrating >= 1) AND (creditrating <= 5)))
);


ALTER TABLE purchasing.vendor OWNER TO postgres;

--
-- Name: TABLE vendor; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.vendor IS 'Companies from whom Adventure Works Cycles purchases parts or other goods.';


--
-- Name: COLUMN vendor.businessentityid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.vendor.businessentityid IS 'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID';


--
-- Name: COLUMN vendor.creditrating; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.vendor.creditrating IS '1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';


--
-- Name: COLUMN vendor.purchasingwebserviceurl; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.vendor.purchasingwebserviceurl IS 'Vendor URL.';


--
-- Name: country_region_currency; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.country_region_currency (
    countryregioncode character varying(3) NOT NULL,
    currencycode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.country_region_currency OWNER TO postgres;

--
-- Name: COLUMN country_region_currency.countryregioncode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.country_region_currency.countryregioncode IS 'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN country_region_currency.currencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.country_region_currency.currencycode IS 'ISO standard currency code. Foreign key to Currency.CurrencyCode.';


--
-- Name: credit_card; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.credit_card (
    creditcardid integer NOT NULL,
    cardtype character varying(50) NOT NULL,
    cardnumber character varying(25) NOT NULL,
    expmonth smallint NOT NULL,
    expyear smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.credit_card OWNER TO postgres;

--
-- Name: COLUMN credit_card.creditcardid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.creditcardid IS 'Primary key for CreditCard records.';


--
-- Name: COLUMN credit_card.cardtype; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.cardtype IS 'Credit card name.';


--
-- Name: COLUMN credit_card.cardnumber; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.cardnumber IS 'Credit card number.';


--
-- Name: COLUMN credit_card.expmonth; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.expmonth IS 'Credit card expiration month.';


--
-- Name: COLUMN credit_card.expyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.credit_card.expyear IS 'Credit card expiration year.';


--
-- Name: currency; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.currency (
    currencycode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currency OWNER TO postgres;

--
-- Name: TABLE currency; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.currency IS 'Lookup table containing standard ISO currencies.';


--
-- Name: COLUMN currency.currencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency.currencycode IS 'The ISO code for the Currency.';


--
-- Name: currency_rate; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.currency_rate (
    currencyrateid integer NOT NULL,
    currencyratedate timestamp without time zone NOT NULL,
    fromcurrencycode character(3) NOT NULL,
    tocurrencycode character(3) NOT NULL,
    averagerate numeric NOT NULL,
    endofdayrate numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currency_rate OWNER TO postgres;

--
-- Name: TABLE currency_rate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.currency_rate IS '
';


--
-- Name: COLUMN currency_rate.currencyrateid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.currencyrateid IS 'Primary key for CurrencyRate records.';


--
-- Name: COLUMN currency_rate.currencyratedate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.currencyratedate IS 'Date and time the exchange rate was obtained.';


--
-- Name: COLUMN currency_rate.fromcurrencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.fromcurrencycode IS 'Exchange rate was converted from this currency code.';


--
-- Name: COLUMN currency_rate.tocurrencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.tocurrencycode IS 'Exchange rate was converted to this currency code.';


--
-- Name: COLUMN currency_rate.averagerate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.averagerate IS 'Average exchange rate for the day.';


--
-- Name: COLUMN currency_rate.endofdayrate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currency_rate.endofdayrate IS 'Final exchange rate for the day.';


--
-- Name: customer; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.customer (
    customerid integer NOT NULL,
    personid integer,
    storeid integer,
    territoryid integer,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.customer OWNER TO postgres;

--
-- Name: TABLE customer; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.customer IS 'Current customer information. Also see the Person and Store tables.';


--
-- Name: COLUMN customer.customerid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.customerid IS 'Primary key.';


--
-- Name: COLUMN customer.personid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.personid IS 'Foreign key to Person.BusinessEntityID';


--
-- Name: COLUMN customer.storeid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.storeid IS 'Foreign key to Store.BusinessEntityID';


--
-- Name: COLUMN customer.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.customer.territoryid IS 'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: person_credit_card; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.person_credit_card (
    businessentityid integer NOT NULL,
    creditcardid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.person_credit_card OWNER TO postgres;

--
-- Name: COLUMN person_credit_card.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.person_credit_card.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN person_credit_card.creditcardid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.person_credit_card.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: sales_order_detail; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_order_detail (
    salesorderid integer NOT NULL,
    salesorderdetailid integer NOT NULL,
    carriertrackingnumber character varying(25),
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    specialofferid integer NOT NULL,
    unitprice numeric NOT NULL,
    unitpricediscount numeric DEFAULT 0.0 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unitprice >= 0.00)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unitpricediscount >= 0.00))
);


ALTER TABLE sales.sales_order_detail OWNER TO postgres;

--
-- Name: COLUMN sales_order_detail.salesorderid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';


--
-- Name: COLUMN sales_order_detail.salesorderdetailid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.salesorderdetailid IS 'Primary key. One incremental unique number per product sold.';


--
-- Name: COLUMN sales_order_detail.carriertrackingnumber; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.carriertrackingnumber IS 'Shipment tracking number supplied by the shipper.';


--
-- Name: COLUMN sales_order_detail.orderqty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.orderqty IS 'Quantity ordered per product.';


--
-- Name: COLUMN sales_order_detail.productid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.productid IS 'Product sold to customer. Foreign key to Product.ProductID.';


--
-- Name: COLUMN sales_order_detail.specialofferid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.specialofferid IS 'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.';


--
-- Name: COLUMN sales_order_detail.unitprice; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.unitprice IS 'Selling price of a single product.';


--
-- Name: COLUMN sales_order_detail.unitpricediscount; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_detail.unitpricediscount IS 'Discount amount.';


--
-- Name: sales_order_header; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_order_header (
    salesorderid integer NOT NULL,
    revisionnumber smallint DEFAULT 0 NOT NULL,
    orderdate timestamp without time zone DEFAULT now() NOT NULL,
    duedate timestamp without time zone NOT NULL,
    shipdate timestamp without time zone,
    status smallint DEFAULT 1 NOT NULL,
    customerid integer NOT NULL,
    salespersonid integer,
    territoryid integer,
    billtoaddressid integer NOT NULL,
    shiptoaddressid integer NOT NULL,
    shipmethodid integer NOT NULL,
    creditcardid integer,
    creditcardapprovalcode character varying(15),
    currencyrateid integer,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    taxamt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    totaldue numeric,
    comment character varying(128),
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ((duedate >= orderdate)),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (((status >= 0) AND (status <= 8))),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);


ALTER TABLE sales.sales_order_header OWNER TO postgres;

--
-- Name: COLUMN sales_order_header.salesorderid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.salesorderid IS 'Primary key.';


--
-- Name: COLUMN sales_order_header.revisionnumber; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.revisionnumber IS 'Incremental number to track changes to the sales order over time.';


--
-- Name: COLUMN sales_order_header.orderdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.orderdate IS 'Dates the sales order was created.';


--
-- Name: COLUMN sales_order_header.duedate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.duedate IS 'Date the order is due to the customer.';


--
-- Name: COLUMN sales_order_header.shipdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.shipdate IS 'Date the order was shipped to the customer.';


--
-- Name: COLUMN sales_order_header.status; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.status IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';


--
-- Name: COLUMN sales_order_header.customerid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.customerid IS 'Customer identification number. Foreign key to Customer.BusinessEntityID.';


--
-- Name: COLUMN sales_order_header.salespersonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.salespersonid IS 'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN sales_order_header.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.territoryid IS 'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN sales_order_header.billtoaddressid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.billtoaddressid IS 'Customer billing address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN sales_order_header.shiptoaddressid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.shiptoaddressid IS 'Customer shipping address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN sales_order_header.shipmethodid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN sales_order_header.creditcardid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: COLUMN sales_order_header.creditcardapprovalcode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.creditcardapprovalcode IS 'Approval code provided by the credit card company.';


--
-- Name: COLUMN sales_order_header.currencyrateid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.currencyrateid IS 'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';


--
-- Name: COLUMN sales_order_header.subtotal; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.subtotal IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';


--
-- Name: COLUMN sales_order_header.taxamt; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.taxamt IS 'Tax amount.';


--
-- Name: COLUMN sales_order_header.freight; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.freight IS 'Shipping cost.';


--
-- Name: COLUMN sales_order_header.totaldue; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.totaldue IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';


--
-- Name: COLUMN sales_order_header.comment; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header.comment IS 'Sales representative comments.';


--
-- Name: sales_order_header_sales_reason; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_order_header_sales_reason (
    salesorderid integer NOT NULL,
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.sales_order_header_sales_reason OWNER TO postgres;

--
-- Name: COLUMN sales_order_header_sales_reason.salesorderid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header_sales_reason.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';


--
-- Name: COLUMN sales_order_header_sales_reason.salesreasonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_order_header_sales_reason.salesreasonid IS 'Primary key. Foreign key to SalesReason.SalesReasonID.';


--
-- Name: sales_person; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_person (
    businessentityid integer NOT NULL,
    territoryid integer,
    salesquota numeric,
    bonus numeric DEFAULT 0.00 NOT NULL,
    commissionpct numeric DEFAULT 0.00 NOT NULL,
    salesytd numeric DEFAULT 0.00 NOT NULL,
    saleslastyear numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commissionpct >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK ((saleslastyear >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK ((salesquota > 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((salesytd >= 0.00))
);


ALTER TABLE sales.sales_person OWNER TO postgres;

--
-- Name: COLUMN sales_person.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.businessentityid IS 'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';


--
-- Name: COLUMN sales_person.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.territoryid IS 'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN sales_person.salesquota; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.salesquota IS 'Projected yearly sales.';


--
-- Name: COLUMN sales_person.bonus; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.bonus IS 'Bonus due if quota is met.';


--
-- Name: COLUMN sales_person.commissionpct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.commissionpct IS 'Commision percent received per sale.';


--
-- Name: COLUMN sales_person.salesytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.salesytd IS 'Sales total year to date.';


--
-- Name: COLUMN sales_person.saleslastyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person.saleslastyear IS 'Sales total of previous year.';


--
-- Name: sales_person_quota_history; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_person_quota_history (
    businessentityid integer NOT NULL,
    quotadate timestamp without time zone NOT NULL,
    salesquota numeric NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((salesquota > 0.00))
);


ALTER TABLE sales.sales_person_quota_history OWNER TO postgres;

--
-- Name: COLUMN sales_person_quota_history.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person_quota_history.businessentityid IS 'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN sales_person_quota_history.quotadate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person_quota_history.quotadate IS 'Sales quota date.';


--
-- Name: COLUMN sales_person_quota_history.salesquota; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_person_quota_history.salesquota IS 'Sales quota amount.';


--
-- Name: sales_reason; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_reason (
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.sales_reason OWNER TO postgres;

--
-- Name: COLUMN sales_reason.salesreasonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_reason.salesreasonid IS 'Primary key for SalesReason records.';


--
-- Name: sales_tax_rate; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_tax_rate (
    salestaxrateid integer NOT NULL,
    stateprovinceid integer NOT NULL,
    taxtype smallint NOT NULL,
    taxrate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((taxtype >= 1) AND (taxtype <= 3)))
);


ALTER TABLE sales.sales_tax_rate OWNER TO postgres;

--
-- Name: COLUMN sales_tax_rate.salestaxrateid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.salestaxrateid IS 'Primary key for SalesTaxRate records.';


--
-- Name: COLUMN sales_tax_rate.stateprovinceid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.stateprovinceid IS 'State, province, or country/region the sales tax applies to.';


--
-- Name: COLUMN sales_tax_rate.taxtype; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.taxtype IS '1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.';


--
-- Name: COLUMN sales_tax_rate.taxrate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_tax_rate.taxrate IS 'Tax rate amount.';


--
-- Name: sales_territory; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_territory (
    territoryid integer NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    "group" character varying(50) NOT NULL,
    salesytd numeric DEFAULT 0.00 NOT NULL,
    saleslastyear numeric DEFAULT 0.00 NOT NULL,
    costytd numeric DEFAULT 0.00 NOT NULL,
    costlastyear numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK ((costlastyear >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK ((costytd >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK ((saleslastyear >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK ((salesytd >= 0.00))
);


ALTER TABLE sales.sales_territory OWNER TO postgres;

--
-- Name: COLUMN sales_territory.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.territoryid IS 'Primary key for SalesTerritory records.';


--
-- Name: COLUMN sales_territory.countryregioncode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN sales_territory."group"; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory."group" IS 'Geographic area to which the sales territory belong.';


--
-- Name: COLUMN sales_territory.salesytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.salesytd IS 'Sales in the territory year to date.';


--
-- Name: COLUMN sales_territory.saleslastyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.saleslastyear IS 'Sales in the territory the previous year.';


--
-- Name: COLUMN sales_territory.costytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.costytd IS 'Business costs in the territory year to date.';


--
-- Name: COLUMN sales_territory.costlastyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory.costlastyear IS 'Business costs in the territory the previous year.';


--
-- Name: sales_territory_history; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_territory_history (
    businessentityid integer NOT NULL,
    territoryid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);


ALTER TABLE sales.sales_territory_history OWNER TO postgres;

--
-- Name: COLUMN sales_territory_history.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.businessentityid IS 'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN sales_territory_history.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.territoryid IS 'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN sales_territory_history.startdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.startdate IS 'Primary key. Date the sales representive started work in the territory.';


--
-- Name: COLUMN sales_territory_history.enddate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.sales_territory_history.enddate IS 'Date the sales representative left work in the territory.';


--
-- Name: shopping_cart_item; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.shopping_cart_item (
    shoppingcartitemid integer NOT NULL,
    shoppingcartid character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    productid integer NOT NULL,
    datecreated timestamp without time zone DEFAULT now() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);


ALTER TABLE sales.shopping_cart_item OWNER TO postgres;

--
-- Name: COLUMN shopping_cart_item.shoppingcartitemid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.shoppingcartitemid IS 'Primary key for ShoppingCartItem records.';


--
-- Name: COLUMN shopping_cart_item.shoppingcartid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.shoppingcartid IS 'Shopping cart identification number.';


--
-- Name: COLUMN shopping_cart_item.quantity; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.quantity IS 'Product quantity ordered.';


--
-- Name: COLUMN shopping_cart_item.productid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.productid IS 'Product ordered. Foreign key to Product.ProductID.';


--
-- Name: COLUMN shopping_cart_item.datecreated; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shopping_cart_item.datecreated IS 'Date the time the record was created.';


--
-- Name: special_offer; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.special_offer (
    specialofferid integer NOT NULL,
    description character varying(255) NOT NULL,
    discountpct numeric DEFAULT 0.00 NOT NULL,
    type character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone NOT NULL,
    minqty integer DEFAULT 0 NOT NULL,
    maxqty integer,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK ((discountpct >= 0.00)),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK ((enddate >= startdate)),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK ((maxqty >= 0)),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK ((minqty >= 0))
);


ALTER TABLE sales.special_offer OWNER TO postgres;

--
-- Name: COLUMN special_offer.specialofferid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.specialofferid IS 'Primary key for SpecialOffer records.';


--
-- Name: COLUMN special_offer.description; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.description IS 'Discount description.';


--
-- Name: COLUMN special_offer.discountpct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.discountpct IS 'Discount precentage.';


--
-- Name: COLUMN special_offer.type; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.type IS 'Discount type category.';


--
-- Name: COLUMN special_offer.category; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.category IS 'Group the discount applies to such as Reseller or Customer.';


--
-- Name: COLUMN special_offer.startdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.startdate IS 'Discount start date.';


--
-- Name: COLUMN special_offer.enddate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.enddate IS 'Discount end date.';


--
-- Name: COLUMN special_offer.minqty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.minqty IS 'Minimum discount percent allowed.';


--
-- Name: COLUMN special_offer.maxqty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer.maxqty IS 'Maximum discount percent allowed.';


--
-- Name: special_offer_product; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.special_offer_product (
    specialofferid integer NOT NULL,
    productid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.special_offer_product OWNER TO postgres;

--
-- Name: COLUMN special_offer_product.specialofferid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer_product.specialofferid IS 'Primary key for SpecialOfferProduct records.';


--
-- Name: COLUMN special_offer_product.productid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.special_offer_product.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: store; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.store (
    businessentityid integer NOT NULL,
    salespersonid integer,
    demographics xml,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.store OWNER TO postgres;

--
-- Name: COLUMN store.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.store.businessentityid IS 'Primary key. Foreign key to Customer.BusinessEntityID.';


--
-- Name: COLUMN store.salespersonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.store.salespersonid IS 'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN store.demographics; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.store.demographics IS 'Demographic informationg about the store such as the number of employees, annual sales and store type.';


--
-- Name: vpersondemographics; Type: VIEW; Schema: sales; Owner: postgres
--

CREATE VIEW sales.vpersondemographics AS
 SELECT person.businessentityid,
    (((xpath('n:TotalPurchaseYTD/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::money AS totalpurchaseytd,
    (((xpath('n:DateFirstPurchase/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS datefirstpurchase,
    (((xpath('n:BirthDate/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS birthdate,
    ((xpath('n:MaritalStatus/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS maritalstatus,
    ((xpath('n:YearlyIncome/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS yearlyincome,
    ((xpath('n:Gender/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS gender,
    (((xpath('n:TotalChildren/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS totalchildren,
    (((xpath('n:NumberChildrenAtHome/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numberchildrenathome,
    ((xpath('n:Education/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS education,
    ((xpath('n:Occupation/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS occupation,
    (((xpath('n:HomeOwnerFlag/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::boolean AS homeownerflag,
    (((xpath('n:NumberCarsOwned/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numbercarsowned
   FROM person.person
  WHERE (person.demographics IS NOT NULL);


ALTER TABLE sales.vpersondemographics OWNER TO postgres;

--
-- Data for Name: department; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.department (departmentid, modifieddate) FROM stdin;
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee (businessentityid, nationalidnumber, loginid, jobtitle, birthdate, maritalstatus, gender, hiredate, vacationhours, sickleavehours, rowguid, modifieddate, organizationnode) FROM stdin;
\.


--
-- Data for Name: employee_department_history; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_department_history (businessentityid, departmentid, shiftid, startdate, enddate, modifieddate) FROM stdin;
\.


--
-- Data for Name: employee_pay_history; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_pay_history (businessentityid, ratechangedate, rate, payfrequency, modifieddate) FROM stdin;
\.


--
-- Data for Name: job_candidate; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.job_candidate (jobcandidateid, businessentityid, resume, modifieddate) FROM stdin;
\.


--
-- Data for Name: shift; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.shift (shiftid, starttime, endtime, modifieddate) FROM stdin;
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.address (addressid, addressline1, addressline2, city, stateprovinceid, zipcode, spatiallocation, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: address_type; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.address_type (addresstypeid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: business_entity; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.business_entity (businessentityid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: business_entity_address; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.business_entity_address (businessentityid, addressid, addresstypeid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: business_entity_contact; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.business_entity_contact (businessentityid, personid, contacttypeid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: contact_type; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.contact_type (contacttypeid, modifieddate) FROM stdin;
\.


--
-- Data for Name: country_region; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.country_region (countryregioncode, modifieddate) FROM stdin;
\.


--
-- Data for Name: email_address; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.email_address (businessentityid, emailaddressid, emailaddress, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: password; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.password (businessentityid, passwordhash, passwordsalt, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.person (businessentityid, persontype, title, suffix, emailpromotion, additionalcontactinfo, demographics, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: person_phone; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.person_phone (businessentityid, phonenumbertypeid, modifieddate) FROM stdin;
\.


--
-- Data for Name: phone_number_type; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.phone_number_type (phonenumbertypeid, modifieddate) FROM stdin;
\.


--
-- Data for Name: state_province; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.state_province (stateprovinceid, stateprovincecode, countryregioncode, territoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: bill_of_materials; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.bill_of_materials (billofmaterialsid, productassemblyid, componentid, startdate, enddate, unitmeasurecode, bomlevel, perassemblyqty, modifieddate) FROM stdin;
\.


--
-- Data for Name: culture; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.culture (cultureid, modifieddate) FROM stdin;
\.


--
-- Data for Name: document; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.document (title, owner, filename, fileextension, revision, changenumber, status, documentsummary, document, rowguid, modifieddate, documentnode) FROM stdin;
\.


--
-- Data for Name: illustration; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.illustration (illustrationid, diagram, modifieddate) FROM stdin;
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.location (locationid, costrate, availability, modifieddate) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product (productid, productnumber, color, safetystocklevel, reorderpoint, standardcost, listprice, size, sizeunitmeasurecode, weightunitmeasurecode, weight, daystomanufacture, productline, class, style, productsubcategoryid, productmodelid, sellstartdate, sellenddate, discontinueddate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_category (productcategoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_cost_history; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_cost_history (productid, startdate, enddate, standardcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_description; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_description (productdescriptionid, description, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_document; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_document (productid, modifieddate, documentnode) FROM stdin;
\.


--
-- Data for Name: product_inventory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_inventory (productid, locationid, shelf, bin, quantity, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_list_price_history; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_list_price_history (productid, startdate, enddate, listprice, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_model; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_model (productmodelid, catalogdescription, instructions, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_model_illustration; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_model_illustration (productmodelid, illustrationid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_model_product_description_culture; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_model_product_description_culture (productmodelid, productdescriptionid, cultureid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_photo; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_photo (productphotoid, thumbnailphoto, thumbnailphotofilename, largephoto, largephotofilename, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_product_photo; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_product_photo (productid, productphotoid, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_review; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_review (productreviewid, productid, reviewdate, emailaddress, rating, comments, modifieddate) FROM stdin;
1	709	2013-09-18 00:00:00	john@fourthcoffee.com	5	I can't believe I'm singing the praises of a pair of socks, but I just came back from a grueling\n3-day ride and these socks really helped make the trip a blast. They're lightweight yet really cushioned my feet all day. \nThe reinforced toe is nearly bullet-proof and I didn't experience any problems with rubbing or blisters like I have with\nother brands. I know it sounds silly, but it's always the little stuff (like comfortable feet) that makes or breaks a long trip.\nI won't go on another trip without them!	2013-09-18 00:00:00
2	937	2013-11-13 00:00:00	david@graphicdesigninstitute.com	4	A little on the heavy side, but overall the entry/exit is easy in all conditions. I've used these pedals for \nmore than 3 years and I've never had a problem. Cleanup is easy. Mud and sand don't get trapped. I would like \nthem even better if there was a weight reduction. Maybe in the next design. Still, I would recommend them to a friend.	2013-11-13 00:00:00
3	937	2013-11-15 00:00:00	jill@margiestravel.com	2	Maybe it's just because I'm new to mountain biking, but I had a terrible time getting use\nto these pedals. In my first outing, I wiped out trying to release my foot. Any suggestions on\nways I can adjust the pedals, or is it just a learning curve thing?	2013-11-15 00:00:00
4	798	2013-11-15 00:00:00	laura@treyresearch.net	5	The Road-550-W from Adventure Works Cycles is everything it's advertised to be. Finally, a quality bike that\nis actually built for a woman and provides control and comfort in one neat package. The top tube is shorter, the suspension is weight-tuned and there's a much shorter reach to the brake\nlevers. All this adds up to a great mountain bike that is sure to accommodate any woman's anatomy. In addition to getting the size right, the saddle is incredibly comfortable. \nAttention to detail is apparent in every aspect from the frame finish to the careful design of each component. Each component is a solid performer without any fluff. \nThe designers clearly did their homework and thought about size, weight, and funtionality throughout. And at less than 19 pounds, the bike is manageable for even the most petite cyclist.\n\nWe had 5 riders take the bike out for a spin and really put it to the test. The results were consistent and very positive. Our testers loved the manuverability \nand control they had with the redesigned frame on the 550-W. A definite improvement over the 2012 design. Four out of five testers listed quick handling\nand responsivness were the key elements they noticed. Technical climbing and on the flats, the bike just cruises through the rough. Tight corners and obstacles were handled effortlessly. The fifth tester was more impressed with the smooth ride. The heavy-duty shocks absorbed even the worst bumps and provided a soft ride on all but the \nnastiest trails and biggest drops. The shifting was rated superb and typical of what we've come to expect from Adventure Works Cycles. On descents, the bike handled flawlessly and tracked very well. The bike is well balanced front-to-rear and frame flex was minimal. In particular, the testers\nnoted that the brake system had a unique combination of power and modulation.  While some brake setups can be overly touchy, these brakes had a good\namount of power, but also a good feel that allows you to apply as little or as much braking power as is needed. Second is their short break-in period. We found that they tend to break-in well before\nthe end of the first ride; while others take two to three rides (or more) to come to full power. \n\nOn the negative side, the pedals were not quite up to our tester's standards. \nJust for fun, we experimented with routine maintenance tasks. Overall we found most operations to be straight forward and easy to complete. The only exception was replacing the front wheel. The maintenance manual that comes\nwith the bike say to install the front wheel with the axle quick release or bolt, then compress the fork a few times before fastening and tightening the two quick-release mechanisms on the bottom of the dropouts. This is to seat the axle in the dropouts, and if you do not\ndo this, the axle will become seated after you tightened the two bottom quick releases, which will then become loose. It's better to test the tightness carefully or you may notice that the two bottom quick releases have come loose enough to fall completely open. And that's something you don't want to experience\nwhile out on the road! \n\nThe Road-550-W frame is available in a variety of sizes and colors and has the same durable, high-quality aluminum that AWC is known for. At a MSRP of just under $1125.00, it's comparable in price to its closest competitors and\nwe think that after a test drive you'l find the quality and performance above and beyond . You'll have a grin on your face and be itching to get out on the road for more. While designed for serious road racing, the Road-550-W would be an excellent choice for just about any terrain and \nany level of experience. It's a huge step in the right direction for female cyclists and well worth your consideration and hard-earned money.	2013-11-15 00:00:00
\.


--
-- Data for Name: product_subcategory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.product_subcategory (productsubcategoryid, productcategoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: scrap_reason; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.scrap_reason (scrapreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: transaction_history; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.transaction_history (transactionid, productid, referenceorderid, referenceorderlineid, transactiondate, transactiontype, quantity, actualcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: transaction_history_archive; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.transaction_history_archive (transactionid, productid, referenceorderid, referenceorderlineid, transactiondate, transactiontype, quantity, actualcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: unit_measure; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.unit_measure (unitmeasurecode, modifieddate) FROM stdin;
\.


--
-- Data for Name: work_order; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.work_order (workorderid, productid, orderqty, scrappedqty, startdate, enddate, duedate, scrapreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: work_order_routing; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.work_order_routing (workorderid, productid, operationsequence, locationid, scheduledstartdate, scheduledenddate, actualstartdate, actualenddate, actualresourcehrs, plannedcost, actualcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: product_vendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.product_vendor (productid, businessentityid, averageleadtime, standardprice, lastreceiptcost, lastreceiptdate, minorderqty, maxorderqty, onorderqty, unitmeasurecode, modifieddate) FROM stdin;
\.


--
-- Data for Name: purchase_order_detail; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order_detail (purchaseorderid, purchaseorderdetailid, duedate, orderqty, productid, unitprice, receivedqty, rejectedqty, modifieddate) FROM stdin;
\.


--
-- Data for Name: purchase_order_header; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order_header (purchaseorderid, revisionnumber, status, employeeid, vendorid, shipmethodid, orderdate, shipdate, subtotal, taxamt, freight, modifieddate) FROM stdin;
\.


--
-- Data for Name: ship_method; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.ship_method (shipmethodid, shipbase, shiprate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: vendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.vendor (businessentityid, creditrating, purchasingwebserviceurl, modifieddate) FROM stdin;
\.


--
-- Data for Name: country_region_currency; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.country_region_currency (countryregioncode, currencycode, modifieddate) FROM stdin;
\.


--
-- Data for Name: credit_card; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.credit_card (creditcardid, cardtype, cardnumber, expmonth, expyear, modifieddate) FROM stdin;
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.currency (currencycode, modifieddate) FROM stdin;
\.


--
-- Data for Name: currency_rate; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.currency_rate (currencyrateid, currencyratedate, fromcurrencycode, tocurrencycode, averagerate, endofdayrate, modifieddate) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customer (customerid, personid, storeid, territoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: person_credit_card; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.person_credit_card (businessentityid, creditcardid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_order_detail; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_order_detail (salesorderid, salesorderdetailid, carriertrackingnumber, orderqty, productid, specialofferid, unitprice, unitpricediscount, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_order_header; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_order_header (salesorderid, revisionnumber, orderdate, duedate, shipdate, status, customerid, salespersonid, territoryid, billtoaddressid, shiptoaddressid, shipmethodid, creditcardid, creditcardapprovalcode, currencyrateid, subtotal, taxamt, freight, totaldue, comment, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_order_header_sales_reason; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_order_header_sales_reason (salesorderid, salesreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_person; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_person (businessentityid, territoryid, salesquota, bonus, commissionpct, salesytd, saleslastyear, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_person_quota_history; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_person_quota_history (businessentityid, quotadate, salesquota, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_reason; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_reason (salesreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_tax_rate; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_tax_rate (salestaxrateid, stateprovinceid, taxtype, taxrate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_territory; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_territory (territoryid, countryregioncode, "group", salesytd, saleslastyear, costytd, costlastyear, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: sales_territory_history; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_territory_history (businessentityid, territoryid, startdate, enddate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: shopping_cart_item; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.shopping_cart_item (shoppingcartitemid, shoppingcartid, quantity, productid, datecreated, modifieddate) FROM stdin;
\.


--
-- Data for Name: special_offer; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.special_offer (specialofferid, description, discountpct, type, category, startdate, enddate, minqty, maxqty, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: special_offer_product; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.special_offer_product (specialofferid, productid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.store (businessentityid, salespersonid, demographics, rowguid, modifieddate) FROM stdin;
\.


--
-- Name: department PK_Department_DepartmentID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.department
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (departmentid);

ALTER TABLE human_resources.department CLUSTER ON "PK_Department_DepartmentID";


--
-- Name: employee_department_history PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (businessentityid, startdate, departmentid, shiftid);

ALTER TABLE human_resources.employee_department_history CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";


--
-- Name: employee_pay_history PK_EmployeePayHistory_BusinessEntityID_RateChangeDate; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_pay_history
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (businessentityid, ratechangedate);

ALTER TABLE human_resources.employee_pay_history CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";


--
-- Name: employee PK_Employee_BusinessEntityID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee
    ADD CONSTRAINT "PK_Employee_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE human_resources.employee CLUSTER ON "PK_Employee_BusinessEntityID";


--
-- Name: job_candidate PK_JobCandidate_JobCandidateID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_candidate
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (jobcandidateid);

ALTER TABLE human_resources.job_candidate CLUSTER ON "PK_JobCandidate_JobCandidateID";


--
-- Name: shift PK_Shift_ShiftID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shiftid);

ALTER TABLE human_resources.shift CLUSTER ON "PK_Shift_ShiftID";


--
-- Name: address_type PK_AddressType_AddressTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address_type
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (addresstypeid);

ALTER TABLE person.address_type CLUSTER ON "PK_AddressType_AddressTypeID";


--
-- Name: address PK_Address_AddressID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (addressid);

ALTER TABLE person.address CLUSTER ON "PK_Address_AddressID";


--
-- Name: business_entity_address PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (businessentityid, addressid, addresstypeid);

ALTER TABLE person.business_entity_address CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";


--
-- Name: business_entity_contact PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (businessentityid, personid, contacttypeid);

ALTER TABLE person.business_entity_contact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";


--
-- Name: business_entity PK_BusinessEntity_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.business_entity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";


--
-- Name: contact_type PK_ContactType_ContactTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.contact_type
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contacttypeid);

ALTER TABLE person.contact_type CLUSTER ON "PK_ContactType_ContactTypeID";


--
-- Name: country_region PK_CountryRegion_CountryRegionCode; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.country_region
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (countryregioncode);

ALTER TABLE person.country_region CLUSTER ON "PK_CountryRegion_CountryRegionCode";


--
-- Name: email_address PK_EmailAddress_BusinessEntityID_EmailAddressID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.email_address
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (businessentityid, emailaddressid);

ALTER TABLE person.email_address CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";


--
-- Name: password PK_Password_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.password
    ADD CONSTRAINT "PK_Password_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.password CLUSTER ON "PK_Password_BusinessEntityID";


--
-- Name: person PK_Person_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person
    ADD CONSTRAINT "PK_Person_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.person CLUSTER ON "PK_Person_BusinessEntityID";


--
-- Name: phone_number_type PK_PhoneNumberType_PhoneNumberTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.phone_number_type
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phonenumbertypeid);

ALTER TABLE person.phone_number_type CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";


--
-- Name: state_province PK_StateProvince_StateProvinceID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (stateprovinceid);

ALTER TABLE person.state_province CLUSTER ON "PK_StateProvince_StateProvinceID";


--
-- Name: bill_of_materials PK_BillOfMaterials_BillOfMaterialsID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "PK_BillOfMaterials_BillOfMaterialsID" PRIMARY KEY (billofmaterialsid);


--
-- Name: culture PK_Culture_CultureID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.culture
    ADD CONSTRAINT "PK_Culture_CultureID" PRIMARY KEY (cultureid);

ALTER TABLE production.culture CLUSTER ON "PK_Culture_CultureID";


--
-- Name: document PK_Document_DocumentNode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT "PK_Document_DocumentNode" PRIMARY KEY (documentnode);

ALTER TABLE production.document CLUSTER ON "PK_Document_DocumentNode";


--
-- Name: illustration PK_Illustration_IllustrationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.illustration
    ADD CONSTRAINT "PK_Illustration_IllustrationID" PRIMARY KEY (illustrationid);

ALTER TABLE production.illustration CLUSTER ON "PK_Illustration_IllustrationID";


--
-- Name: location PK_Location_LocationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.location
    ADD CONSTRAINT "PK_Location_LocationID" PRIMARY KEY (locationid);

ALTER TABLE production.location CLUSTER ON "PK_Location_LocationID";


--
-- Name: product_category PK_ProductCategory_ProductCategoryID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_category
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (productcategoryid);

ALTER TABLE production.product_category CLUSTER ON "PK_ProductCategory_ProductCategoryID";


--
-- Name: product_cost_history PK_ProductCostHistory_ProductID_StartDate; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_cost_history
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate);

ALTER TABLE production.product_cost_history CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";


--
-- Name: product_description PK_ProductDescription_ProductDescriptionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_description
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (productdescriptionid);

ALTER TABLE production.product_description CLUSTER ON "PK_ProductDescription_ProductDescriptionID";


--
-- Name: product_document PK_ProductDocument_ProductID_DocumentNode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_document
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (productid, documentnode);

ALTER TABLE production.product_document CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";


--
-- Name: product_inventory PK_ProductInventory_ProductID_LocationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_inventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (productid, locationid);

ALTER TABLE production.product_inventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";


--
-- Name: product_list_price_history PK_ProductListPriceHistory_ProductID_StartDate; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_list_price_history
    ADD CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate);

ALTER TABLE production.product_list_price_history CLUSTER ON "PK_ProductListPriceHistory_ProductID_StartDate";


--
-- Name: product_model_illustration PK_ProductModelIllustration_ProductModelID_IllustrationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_illustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (productmodelid, illustrationid);

ALTER TABLE production.product_model_illustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";


--
-- Name: product_model_product_description_culture PK_ProductModelProductDescriptionCulture_ProductModelID_Product; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (productmodelid, productdescriptionid, cultureid);

ALTER TABLE production.product_model_product_description_culture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";


--
-- Name: product_model PK_ProductModel_ProductModelID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (productmodelid);

ALTER TABLE production.product_model CLUSTER ON "PK_ProductModel_ProductModelID";


--
-- Name: product_photo PK_ProductPhoto_ProductPhotoID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_photo
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (productphotoid);

ALTER TABLE production.product_photo CLUSTER ON "PK_ProductPhoto_ProductPhotoID";


--
-- Name: product_product_photo PK_ProductProductPhoto_ProductID_ProductPhotoID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_product_photo
    ADD CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY (productid, productphotoid);


--
-- Name: product_review PK_ProductReview_ProductReviewID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_review
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (productreviewid);

ALTER TABLE production.product_review CLUSTER ON "PK_ProductReview_ProductReviewID";


--
-- Name: product_subcategory PK_ProductSubcategory_ProductSubcategoryID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_subcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (productsubcategoryid);

ALTER TABLE production.product_subcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";


--
-- Name: product PK_Product_ProductID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (productid);

ALTER TABLE production.product CLUSTER ON "PK_Product_ProductID";


--
-- Name: scrap_reason PK_ScrapReason_ScrapReasonID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.scrap_reason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrapreasonid);

ALTER TABLE production.scrap_reason CLUSTER ON "PK_ScrapReason_ScrapReasonID";


--
-- Name: transaction_history_archive PK_TransactionHistoryArchive_TransactionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history_archive
    ADD CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transactionid);

ALTER TABLE production.transaction_history_archive CLUSTER ON "PK_TransactionHistoryArchive_TransactionID";


--
-- Name: transaction_history PK_TransactionHistory_TransactionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transactionid);

ALTER TABLE production.transaction_history CLUSTER ON "PK_TransactionHistory_TransactionID";


--
-- Name: unit_measure PK_UnitMeasure_UnitMeasureCode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.unit_measure
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unitmeasurecode);

ALTER TABLE production.unit_measure CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";


--
-- Name: work_order_routing PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order_routing
    ADD CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY (workorderid, productid, operationsequence);

ALTER TABLE production.work_order_routing CLUSTER ON "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence";


--
-- Name: work_order PK_WorkOrder_WorkOrderID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (workorderid);

ALTER TABLE production.work_order CLUSTER ON "PK_WorkOrder_WorkOrderID";


--
-- Name: document document_rowguid_key; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT document_rowguid_key UNIQUE (rowguid);


--
-- Name: product_vendor PK_ProductVendor_ProductID_BusinessEntityID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (productid, businessentityid);

ALTER TABLE purchasing.product_vendor CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";


--
-- Name: purchase_order_detail PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (purchaseorderid, purchaseorderdetailid);

ALTER TABLE purchasing.purchase_order_detail CLUSTER ON "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";


--
-- Name: purchase_order_header PK_PurchaseOrderHeader_PurchaseOrderID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (purchaseorderid);

ALTER TABLE purchasing.purchase_order_header CLUSTER ON "PK_PurchaseOrderHeader_PurchaseOrderID";


--
-- Name: ship_method PK_ShipMethod_ShipMethodID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.ship_method
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (shipmethodid);

ALTER TABLE purchasing.ship_method CLUSTER ON "PK_ShipMethod_ShipMethodID";


--
-- Name: vendor PK_Vendor_BusinessEntityID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE purchasing.vendor CLUSTER ON "PK_Vendor_BusinessEntityID";


--
-- Name: country_region_currency PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.country_region_currency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (countryregioncode, currencycode);

ALTER TABLE sales.country_region_currency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";


--
-- Name: credit_card PK_CreditCard_CreditCardID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.credit_card
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (creditcardid);

ALTER TABLE sales.credit_card CLUSTER ON "PK_CreditCard_CreditCardID";


--
-- Name: currency_rate PK_CurrencyRate_CurrencyRateID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currencyrateid);

ALTER TABLE sales.currency_rate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";


--
-- Name: currency PK_Currency_CurrencyCode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency
    ADD CONSTRAINT "PK_Currency_CurrencyCode" PRIMARY KEY (currencycode);

ALTER TABLE sales.currency CLUSTER ON "PK_Currency_CurrencyCode";


--
-- Name: customer PK_Customer_CustomerID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "PK_Customer_CustomerID" PRIMARY KEY (customerid);

ALTER TABLE sales.customer CLUSTER ON "PK_Customer_CustomerID";


--
-- Name: person_credit_card PK_PersonCreditCard_BusinessEntityID_CreditCardID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.person_credit_card
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (businessentityid, creditcardid);

ALTER TABLE sales.person_credit_card CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";


--
-- Name: sales_order_detail PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (salesorderid, salesorderdetailid);

ALTER TABLE sales.sales_order_detail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";


--
-- Name: sales_order_header_sales_reason PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header_sales_reason
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (salesorderid, salesreasonid);

ALTER TABLE sales.sales_order_header_sales_reason CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";


--
-- Name: sales_order_header PK_SalesOrderHeader_SalesOrderID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (salesorderid);

ALTER TABLE sales.sales_order_header CLUSTER ON "PK_SalesOrderHeader_SalesOrderID";


--
-- Name: sales_person_quota_history PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person_quota_history
    ADD CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (businessentityid, quotadate);

ALTER TABLE sales.sales_person_quota_history CLUSTER ON "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";


--
-- Name: sales_person PK_SalesPerson_BusinessEntityID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE sales.sales_person CLUSTER ON "PK_SalesPerson_BusinessEntityID";


--
-- Name: sales_reason PK_SalesReason_SalesReasonID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_reason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (salesreasonid);

ALTER TABLE sales.sales_reason CLUSTER ON "PK_SalesReason_SalesReasonID";


--
-- Name: sales_tax_rate PK_SalesTaxRate_SalesTaxRateID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_tax_rate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (salestaxrateid);

ALTER TABLE sales.sales_tax_rate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";


--
-- Name: sales_territory_history PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory_history
    ADD CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (businessentityid, startdate, territoryid);

ALTER TABLE sales.sales_territory_history CLUSTER ON "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";


--
-- Name: sales_territory PK_SalesTerritory_TerritoryID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territoryid);

ALTER TABLE sales.sales_territory CLUSTER ON "PK_SalesTerritory_TerritoryID";


--
-- Name: shopping_cart_item PK_ShoppingCartItem_ShoppingCartItemID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shopping_cart_item
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shoppingcartitemid);

ALTER TABLE sales.shopping_cart_item CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";


--
-- Name: special_offer_product PK_SpecialOfferProduct_SpecialOfferID_ProductID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer_product
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (specialofferid, productid);

ALTER TABLE sales.special_offer_product CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";


--
-- Name: special_offer PK_SpecialOffer_SpecialOfferID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (specialofferid);

ALTER TABLE sales.special_offer CLUSTER ON "PK_SpecialOffer_SpecialOfferID";


--
-- Name: store PK_Store_BusinessEntityID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE sales.store CLUSTER ON "PK_Store_BusinessEntityID";


--
-- Name: employee_department_history FK_EmployeeDepartmentHistory_Department_DepartmentID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (departmentid) REFERENCES human_resources.department(departmentid);


--
-- Name: employee_department_history FK_EmployeeDepartmentHistory_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: employee_department_history FK_EmployeeDepartmentHistory_Shift_ShiftID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_department_history
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shiftid) REFERENCES human_resources.shift(shiftid);


--
-- Name: employee_pay_history FK_EmployeePayHistory_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_pay_history
    ADD CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: employee FK_Employee_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee
    ADD CONSTRAINT "FK_Employee_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: job_candidate FK_JobCandidate_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_candidate
    ADD CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: address FK_Address_StateProvince_StateProvinceID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid) REFERENCES person.state_province(stateprovinceid);


--
-- Name: business_entity_address FK_BusinessEntityAddress_AddressType_AddressTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (addresstypeid) REFERENCES person.address_type(addresstypeid);


--
-- Name: business_entity_address FK_BusinessEntityAddress_Address_AddressID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (addressid) REFERENCES person.address(addressid);


--
-- Name: business_entity_address FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_address
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.business_entity(businessentityid);


--
-- Name: business_entity_contact FK_BusinessEntityContact_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.business_entity(businessentityid);


--
-- Name: business_entity_contact FK_BusinessEntityContact_ContactType_ContactTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (contacttypeid) REFERENCES person.contact_type(contacttypeid);


--
-- Name: business_entity_contact FK_BusinessEntityContact_Person_PersonID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.business_entity_contact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (personid) REFERENCES person.person(businessentityid);


--
-- Name: email_address FK_EmailAddress_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.email_address
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: password FK_Password_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: person_phone FK_PersonPhone_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person_phone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: person_phone FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person_phone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phonenumbertypeid) REFERENCES person.phone_number_type(phonenumbertypeid);


--
-- Name: person FK_Person_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.business_entity(businessentityid);


--
-- Name: state_province FK_StateProvince_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.country_region(countryregioncode);


--
-- Name: state_province FK_StateProvince_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.state_province
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.sales_territory(territoryid);


--
-- Name: bill_of_materials FK_BillOfMaterials_Product_ComponentID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (componentid) REFERENCES production.product(productid);


--
-- Name: bill_of_materials FK_BillOfMaterials_Product_ProductAssemblyID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (productassemblyid) REFERENCES production.product(productid);


--
-- Name: bill_of_materials FK_BillOfMaterials_UnitMeasure_UnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.bill_of_materials
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode) REFERENCES production.unit_measure(unitmeasurecode);


--
-- Name: document FK_Document_Employee_Owner; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT "FK_Document_Employee_Owner" FOREIGN KEY (owner) REFERENCES human_resources.employee(businessentityid);


--
-- Name: product_cost_history FK_ProductCostHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_cost_history
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: product_document FK_ProductDocument_Document_DocumentNode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_document
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (documentnode) REFERENCES production.document(documentnode);


--
-- Name: product_document FK_ProductDocument_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_document
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: product_inventory FK_ProductInventory_Location_LocationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (locationid) REFERENCES production.location(locationid);


--
-- Name: product_inventory FK_ProductInventory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_inventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: product_list_price_history FK_ProductListPriceHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_list_price_history
    ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: product_model_illustration FK_ProductModelIllustration_Illustration_IllustrationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustrationid) REFERENCES production.illustration(illustrationid);


--
-- Name: product_model_illustration FK_ProductModelIllustration_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_illustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.product_model(productmodelid);


--
-- Name: product_model_product_description_culture FK_ProductModelProductDescriptionCulture_Culture_CultureID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (cultureid) REFERENCES production.culture(cultureid);


--
-- Name: product_model_product_description_culture FK_ProductModelProductDescriptionCulture_ProductDescription_Pro; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (productdescriptionid) REFERENCES production.product_description(productdescriptionid);


--
-- Name: product_model_product_description_culture FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_model_product_description_culture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (productmodelid) REFERENCES production.product_model(productmodelid);


--
-- Name: product_product_photo FK_ProductProductPhoto_ProductPhoto_ProductPhotoID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_product_photo
    ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY (productphotoid) REFERENCES production.product_photo(productphotoid);


--
-- Name: product_product_photo FK_ProductProductPhoto_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_product_photo
    ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: product_subcategory FK_ProductSubcategory_ProductCategory_ProductCategoryID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product_subcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (productcategoryid) REFERENCES production.product_category(productcategoryid);


--
-- Name: product FK_Product_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.product_model(productmodelid);


--
-- Name: product FK_Product_ProductSubcategory_ProductSubcategoryID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (productsubcategoryid) REFERENCES production.product_subcategory(productsubcategoryid);


--
-- Name: product FK_Product_UnitMeasure_SizeUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (sizeunitmeasurecode) REFERENCES production.unit_measure(unitmeasurecode);


--
-- Name: product FK_Product_UnitMeasure_WeightUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weightunitmeasurecode) REFERENCES production.unit_measure(unitmeasurecode);


--
-- Name: transaction_history FK_TransactionHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transaction_history
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: work_order_routing FK_WorkOrderRouting_Location_LocationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (locationid) REFERENCES production.location(locationid);


--
-- Name: work_order_routing FK_WorkOrderRouting_WorkOrder_WorkOrderID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order_routing
    ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (workorderid) REFERENCES production.work_order(workorderid);


--
-- Name: work_order FK_WorkOrder_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: work_order FK_WorkOrder_ScrapReason_ScrapReasonID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.work_order
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrapreasonid) REFERENCES production.scrap_reason(scrapreasonid);


--
-- Name: product_vendor FK_ProductVendor_Product_ProductID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: product_vendor FK_ProductVendor_UnitMeasure_UnitMeasureCode; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode) REFERENCES production.unit_measure(unitmeasurecode);


--
-- Name: product_vendor FK_ProductVendor_Vendor_BusinessEntityID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.product_vendor
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES purchasing.vendor(businessentityid);


--
-- Name: purchase_order_detail FK_PurchaseOrderDetail_Product_ProductID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: purchase_order_detail FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (purchaseorderid) REFERENCES purchasing.purchase_order_header(purchaseorderid);


--
-- Name: purchase_order_header FK_PurchaseOrderHeader_Employee_EmployeeID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID" FOREIGN KEY (employeeid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: purchase_order_header FK_PurchaseOrderHeader_ShipMethod_ShipMethodID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid) REFERENCES purchasing.ship_method(shipmethodid);


--
-- Name: purchase_order_header FK_PurchaseOrderHeader_Vendor_VendorID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (vendorid) REFERENCES purchasing.vendor(businessentityid);


--
-- Name: vendor FK_Vendor_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.business_entity(businessentityid);


--
-- Name: country_region_currency FK_CountryRegionCurrency_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.country_region(countryregioncode);


--
-- Name: country_region_currency FK_CountryRegionCurrency_Currency_CurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.country_region_currency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currencycode) REFERENCES sales.currency(currencycode);


--
-- Name: currency_rate FK_CurrencyRate_Currency_FromCurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (fromcurrencycode) REFERENCES sales.currency(currencycode);


--
-- Name: currency_rate FK_CurrencyRate_Currency_ToCurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currency_rate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_ToCurrencyCode" FOREIGN KEY (tocurrencycode) REFERENCES sales.currency(currencycode);


--
-- Name: customer FK_Customer_Person_PersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Person_PersonID" FOREIGN KEY (personid) REFERENCES person.person(businessentityid);


--
-- Name: customer FK_Customer_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.sales_territory(territoryid);


--
-- Name: customer FK_Customer_Store_StoreID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (storeid) REFERENCES sales.store(businessentityid);


--
-- Name: person_credit_card FK_PersonCreditCard_CreditCard_CreditCardID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (creditcardid) REFERENCES sales.credit_card(creditcardid);


--
-- Name: person_credit_card FK_PersonCreditCard_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.person_credit_card
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: sales_order_detail FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid) REFERENCES sales.sales_order_header(salesorderid) ON DELETE CASCADE;


--
-- Name: sales_order_detail FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_detail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (specialofferid, productid) REFERENCES sales.special_offer_product(specialofferid, productid);


--
-- Name: sales_order_header_sales_reason FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header_sales_reason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid) REFERENCES sales.sales_order_header(salesorderid) ON DELETE CASCADE;


--
-- Name: sales_order_header_sales_reason FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header_sales_reason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (salesreasonid) REFERENCES sales.sales_reason(salesreasonid);


--
-- Name: sales_order_header FK_SalesOrderHeader_Address_BillToAddressID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (billtoaddressid) REFERENCES person.address(addressid);


--
-- Name: sales_order_header FK_SalesOrderHeader_Address_ShipToAddressID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (shiptoaddressid) REFERENCES person.address(addressid);


--
-- Name: sales_order_header FK_SalesOrderHeader_CreditCard_CreditCardID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (creditcardid) REFERENCES sales.credit_card(creditcardid);


--
-- Name: sales_order_header FK_SalesOrderHeader_CurrencyRate_CurrencyRateID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY (currencyrateid) REFERENCES sales.currency_rate(currencyrateid);


--
-- Name: sales_order_header FK_SalesOrderHeader_Customer_CustomerID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY (customerid) REFERENCES sales.customer(customerid);


--
-- Name: sales_order_header FK_SalesOrderHeader_SalesPerson_SalesPersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid) REFERENCES sales.sales_person(businessentityid);


--
-- Name: sales_order_header FK_SalesOrderHeader_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.sales_territory(territoryid);


--
-- Name: sales_order_header FK_SalesOrderHeader_ShipMethod_ShipMethodID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_order_header
    ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid) REFERENCES purchasing.ship_method(shipmethodid);


--
-- Name: sales_person_quota_history FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person_quota_history
    ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES sales.sales_person(businessentityid);


--
-- Name: sales_person FK_SalesPerson_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person
    ADD CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: sales_person FK_SalesPerson_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_person
    ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.sales_territory(territoryid);


--
-- Name: sales_tax_rate FK_SalesTaxRate_StateProvince_StateProvinceID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_tax_rate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid) REFERENCES person.state_province(stateprovinceid);


--
-- Name: sales_territory_history FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES sales.sales_person(businessentityid);


--
-- Name: sales_territory_history FK_SalesTerritoryHistory_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory_history
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.sales_territory(territoryid);


--
-- Name: sales_territory FK_SalesTerritory_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_territory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.country_region(countryregioncode);


--
-- Name: shopping_cart_item FK_ShoppingCartItem_Product_ProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shopping_cart_item
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: special_offer_product FK_SpecialOfferProduct_Product_ProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer_product
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: special_offer_product FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.special_offer_product
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (specialofferid) REFERENCES sales.special_offer(specialofferid);


--
-- Name: store FK_Store_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.business_entity(businessentityid);


--
-- Name: store FK_Store_SalesPerson_SalesPersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid) REFERENCES sales.sales_person(businessentityid);


--
-- PostgreSQL database dump complete
--

