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
-- Name: department_departmentid_seq; Type: SEQUENCE; Schema: human_resources; Owner: postgres
--

CREATE SEQUENCE human_resources.department_departmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE human_resources.department_departmentid_seq OWNER TO postgres;

--
-- Name: department_departmentid_seq; Type: SEQUENCE OWNED BY; Schema: human_resources; Owner: postgres
--

ALTER SEQUENCE human_resources.department_departmentid_seq OWNED BY human_resources.department.departmentid;


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
-- Name: employeedepartmenthistory; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employeedepartmenthistory (
    businessentityid integer NOT NULL,
    departmentid smallint NOT NULL,
    shiftid smallint NOT NULL,
    startdate date NOT NULL,
    enddate date,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);


ALTER TABLE human_resources.employeedepartmenthistory OWNER TO postgres;

--
-- Name: TABLE employeedepartmenthistory; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.employeedepartmenthistory IS 'Employee department transfers.';


--
-- Name: COLUMN employeedepartmenthistory.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeedepartmenthistory.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN employeedepartmenthistory.departmentid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeedepartmenthistory.departmentid IS 'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.';


--
-- Name: COLUMN employeedepartmenthistory.shiftid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeedepartmenthistory.shiftid IS 'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.';


--
-- Name: COLUMN employeedepartmenthistory.startdate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeedepartmenthistory.startdate IS 'Date the employee started work in the department.';


--
-- Name: COLUMN employeedepartmenthistory.enddate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeedepartmenthistory.enddate IS 'Date the employee left the department. NULL = Current department.';


--
-- Name: employeepayhistory; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employeepayhistory (
    businessentityid integer NOT NULL,
    ratechangedate timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    payfrequency smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((payfrequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);


ALTER TABLE human_resources.employeepayhistory OWNER TO postgres;

--
-- Name: TABLE employeepayhistory; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.employeepayhistory IS 'Employee pay history.';


--
-- Name: COLUMN employeepayhistory.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeepayhistory.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN employeepayhistory.ratechangedate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeepayhistory.ratechangedate IS 'Date the change in pay is effective';


--
-- Name: COLUMN employeepayhistory.rate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeepayhistory.rate IS 'Salary hourly rate.';


--
-- Name: COLUMN employeepayhistory.payfrequency; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.employeepayhistory.payfrequency IS '1 = Salary received monthly, 2 = Salary received biweekly';


--
-- Name: jobcandidate; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.jobcandidate (
    jobcandidateid integer NOT NULL,
    businessentityid integer,
    resume xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE human_resources.jobcandidate OWNER TO postgres;

--
-- Name: TABLE jobcandidate; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON TABLE human_resources.jobcandidate IS 'RÃ©sumÃ©s submitted to Human Resources by job applicants.';


--
-- Name: COLUMN jobcandidate.jobcandidateid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.jobcandidate.jobcandidateid IS 'Primary key for JobCandidate records.';


--
-- Name: COLUMN jobcandidate.businessentityid; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.jobcandidate.businessentityid IS 'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN jobcandidate.resume; Type: COMMENT; Schema: human_resources; Owner: postgres
--

COMMENT ON COLUMN human_resources.jobcandidate.resume IS 'RÃ©sumÃ© in XML format.';


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

ALTER SEQUENCE human_resources.jobcandidate_jobcandidateid_seq OWNED BY human_resources.jobcandidate.jobcandidateid;


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
-- Name: shift_shiftid_seq; Type: SEQUENCE; Schema: human_resources; Owner: postgres
--

CREATE SEQUENCE human_resources.shift_shiftid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE human_resources.shift_shiftid_seq OWNER TO postgres;

--
-- Name: shift_shiftid_seq; Type: SEQUENCE OWNED BY; Schema: human_resources; Owner: postgres
--

ALTER SEQUENCE human_resources.shift_shiftid_seq OWNED BY human_resources.shift.shiftid;


--
-- Name: vjobcandidate; Type: VIEW; Schema: human_resources; Owner: postgres
--

CREATE VIEW human_resources.vjobcandidate AS
 SELECT jobcandidate.jobcandidateid,
    jobcandidate.businessentityid,
    ((xpath('/n:Resume/n:Name/n:Name.Prefix/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Prefix",
    ((xpath('/n:Resume/n:Name/n:Name.First/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.First",
    ((xpath('/n:Resume/n:Name/n:Name.Middle/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Middle",
    ((xpath('/n:Resume/n:Name/n:Name.Last/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Last",
    ((xpath('/n:Resume/n:Name/n:Name.Suffix/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Suffix",
    ((xpath('/n:Resume/n:Skills/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "Skills",
    ((xpath('n:Address/n:Addr.Type/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Addr.Type",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.CountryRegion/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.CountryRegion",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.State/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.State",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.City/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.City",
    ((xpath('n:Address/n:Addr.PostalCode/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(20) AS "Addr.PostalCode",
    ((xpath('/n:Resume/n:EMail/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "EMail",
    ((xpath('/n:Resume/n:WebSite/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "WebSite",
    jobcandidate.modifieddate
   FROM human_resources.jobcandidate;


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
           FROM ( SELECT jobcandidate.jobcandidateid,
                    unnest(xpath('/ns:Resume/ns:Education'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])) AS education
                   FROM human_resources.jobcandidate) unnesting) jc;


ALTER TABLE human_resources.vjobcandidateeducation OWNER TO postgres;

--
-- Name: vjobcandidateemployment; Type: VIEW; Schema: human_resources; Owner: postgres
--

CREATE VIEW human_resources.vjobcandidateemployment AS
 SELECT jobcandidate.jobcandidateid,
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.StartDate/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.StartDate",
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.EndDate/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.EndDate",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.OrgName/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.OrgName",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.JobTitle/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.JobTitle",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Responsibility/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Responsibility",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.FunctionCategory/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.FunctionCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.IndustryCategory/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.IndustryCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.CountryRegion",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.State/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.State",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.City/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.City"
   FROM human_resources.jobcandidate;


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

ALTER SEQUENCE person.address_addressid_seq OWNED BY person.address.addressid;


--
-- Name: addresstype; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.addresstype (
    addresstypeid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.addresstype OWNER TO postgres;

--
-- Name: TABLE addresstype; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.addresstype IS 'Types of addresses stored in the Address table.';


--
-- Name: COLUMN addresstype.addresstypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.addresstype.addresstypeid IS 'Primary key for AddressType records.';


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

ALTER SEQUENCE person.addresstype_addresstypeid_seq OWNED BY person.addresstype.addresstypeid;


--
-- Name: businessentity; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.businessentity (
    businessentityid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.businessentity OWNER TO postgres;

--
-- Name: TABLE businessentity; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.businessentity IS 'Source of the ID that connects vendors, customers, and employees with address and contact information.';


--
-- Name: COLUMN businessentity.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentity.businessentityid IS 'Primary key for all customers, vendors, and employees.';


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

ALTER SEQUENCE person.businessentity_businessentityid_seq OWNED BY person.businessentity.businessentityid;


--
-- Name: businessentityaddress; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.businessentityaddress (
    businessentityid integer NOT NULL,
    addressid integer NOT NULL,
    addresstypeid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.businessentityaddress OWNER TO postgres;

--
-- Name: TABLE businessentityaddress; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.businessentityaddress IS 'Cross-reference table mapping customers, vendors, and employees to their addresses.';


--
-- Name: COLUMN businessentityaddress.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentityaddress.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN businessentityaddress.addressid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentityaddress.addressid IS 'Primary key. Foreign key to Address.AddressID.';


--
-- Name: COLUMN businessentityaddress.addresstypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentityaddress.addresstypeid IS 'Primary key. Foreign key to AddressType.AddressTypeID.';


--
-- Name: businessentitycontact; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.businessentitycontact (
    businessentityid integer NOT NULL,
    personid integer NOT NULL,
    contacttypeid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.businessentitycontact OWNER TO postgres;

--
-- Name: TABLE businessentitycontact; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.businessentitycontact IS 'Cross-reference table mapping stores, vendors, and employees to people';


--
-- Name: COLUMN businessentitycontact.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentitycontact.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN businessentitycontact.personid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentitycontact.personid IS 'Primary key. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN businessentitycontact.contacttypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.businessentitycontact.contacttypeid IS 'Primary key.  Foreign key to ContactType.ContactTypeID.';


--
-- Name: contacttype; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.contacttype (
    contacttypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.contacttype OWNER TO postgres;

--
-- Name: TABLE contacttype; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.contacttype IS 'Lookup table containing the types of business entity contacts.';


--
-- Name: COLUMN contacttype.contacttypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.contacttype.contacttypeid IS 'Primary key for ContactType records.';


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

ALTER SEQUENCE person.contacttype_contacttypeid_seq OWNED BY person.contacttype.contacttypeid;


--
-- Name: countryregion; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.countryregion (
    countryregioncode character varying(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.countryregion OWNER TO postgres;

--
-- Name: TABLE countryregion; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.countryregion IS 'Lookup table containing the ISO standard codes for countries and regions.';


--
-- Name: COLUMN countryregion.countryregioncode; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.countryregion.countryregioncode IS 'ISO standard code for countries and regions.';


--
-- Name: emailaddress; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.emailaddress (
    businessentityid integer NOT NULL,
    emailaddressid integer NOT NULL,
    emailaddress character varying(50),
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.emailaddress OWNER TO postgres;

--
-- Name: TABLE emailaddress; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.emailaddress IS 'Where to send a person email.';


--
-- Name: COLUMN emailaddress.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.emailaddress.businessentityid IS 'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID';


--
-- Name: COLUMN emailaddress.emailaddressid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.emailaddress.emailaddressid IS 'Primary key. ID of this email address.';


--
-- Name: COLUMN emailaddress.emailaddress; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.emailaddress.emailaddress IS 'E-mail address for the person.';


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

ALTER SEQUENCE person.emailaddress_emailaddressid_seq OWNED BY person.emailaddress.emailaddressid;


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
-- Name: personphone; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.personphone (
    businessentityid integer NOT NULL,
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.personphone OWNER TO postgres;

--
-- Name: TABLE personphone; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.personphone IS 'Telephone number and type of a person.';


--
-- Name: COLUMN personphone.businessentityid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.personphone.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN personphone.phonenumbertypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.personphone.phonenumbertypeid IS 'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.';


--
-- Name: phonenumbertype; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.phonenumbertype (
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.phonenumbertype OWNER TO postgres;

--
-- Name: TABLE phonenumbertype; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.phonenumbertype IS 'Type of phone number of a person.';


--
-- Name: COLUMN phonenumbertype.phonenumbertypeid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.phonenumbertype.phonenumbertypeid IS 'Primary key for telephone number type records.';


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

ALTER SEQUENCE person.phonenumbertype_phonenumbertypeid_seq OWNED BY person.phonenumbertype.phonenumbertypeid;


--
-- Name: stateprovince; Type: TABLE; Schema: person; Owner: postgres
--

CREATE TABLE person.stateprovince (
    stateprovinceid integer NOT NULL,
    stateprovincecode character(3) NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    territoryid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.stateprovince OWNER TO postgres;

--
-- Name: TABLE stateprovince; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON TABLE person.stateprovince IS 'State and province lookup table.';


--
-- Name: COLUMN stateprovince.stateprovinceid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.stateprovince.stateprovinceid IS 'Primary key for StateProvince records.';


--
-- Name: COLUMN stateprovince.stateprovincecode; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.stateprovince.stateprovincecode IS 'ISO standard state or province code.';


--
-- Name: COLUMN stateprovince.countryregioncode; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.stateprovince.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN stateprovince.territoryid; Type: COMMENT; Schema: person; Owner: postgres
--

COMMENT ON COLUMN person.stateprovince.territoryid IS 'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.';


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

ALTER SEQUENCE person.stateprovince_stateprovinceid_seq OWNED BY person.stateprovince.stateprovinceid;


--
-- Name: billofmaterials; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.billofmaterials (
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


ALTER TABLE production.billofmaterials OWNER TO postgres;

--
-- Name: TABLE billofmaterials; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.billofmaterials IS 'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.';


--
-- Name: COLUMN billofmaterials.billofmaterialsid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.billofmaterialsid IS 'Primary key for BillOfMaterials records.';


--
-- Name: COLUMN billofmaterials.productassemblyid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.productassemblyid IS 'Parent product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN billofmaterials.componentid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.componentid IS 'Component identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN billofmaterials.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.startdate IS 'Date the component started being used in the assembly item.';


--
-- Name: COLUMN billofmaterials.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.enddate IS 'Date the component stopped being used in the assembly item.';


--
-- Name: COLUMN billofmaterials.unitmeasurecode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.unitmeasurecode IS 'Standard code identifying the unit of measure for the quantity.';


--
-- Name: COLUMN billofmaterials.bomlevel; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.bomlevel IS 'Indicates the depth the component is from its parent (AssemblyID).';


--
-- Name: COLUMN billofmaterials.perassemblyqty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.billofmaterials.perassemblyqty IS 'Quantity of the component needed to create the assembly.';


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

ALTER SEQUENCE production.billofmaterials_billofmaterialsid_seq OWNED BY production.billofmaterials.billofmaterialsid;


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

ALTER SEQUENCE production.illustration_illustrationid_seq OWNED BY production.illustration.illustrationid;


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

ALTER SEQUENCE production.location_locationid_seq OWNED BY production.location.locationid;


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

ALTER SEQUENCE production.product_productid_seq OWNED BY production.product.productid;


--
-- Name: productcategory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productcategory (
    productcategoryid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productcategory OWNER TO postgres;

--
-- Name: TABLE productcategory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productcategory IS 'High-level product categorization.';


--
-- Name: COLUMN productcategory.productcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productcategory.productcategoryid IS 'Primary key for ProductCategory records.';


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

ALTER SEQUENCE production.productcategory_productcategoryid_seq OWNED BY production.productcategory.productcategoryid;


--
-- Name: productcosthistory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productcosthistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    standardcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standardcost >= 0.00))
);


ALTER TABLE production.productcosthistory OWNER TO postgres;

--
-- Name: TABLE productcosthistory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productcosthistory IS 'Changes in the cost of a product over time.';


--
-- Name: COLUMN productcosthistory.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productcosthistory.productid IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN productcosthistory.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productcosthistory.startdate IS 'Product cost start date.';


--
-- Name: COLUMN productcosthistory.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productcosthistory.enddate IS 'Product cost end date.';


--
-- Name: COLUMN productcosthistory.standardcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productcosthistory.standardcost IS 'Standard cost of the product.';


--
-- Name: productdescription; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productdescription (
    productdescriptionid integer NOT NULL,
    description character varying(400) NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productdescription OWNER TO postgres;

--
-- Name: TABLE productdescription; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productdescription IS 'Product descriptions in several languages.';


--
-- Name: COLUMN productdescription.productdescriptionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productdescription.productdescriptionid IS 'Primary key for ProductDescription records.';


--
-- Name: COLUMN productdescription.description; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productdescription.description IS 'Description of the product.';


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

ALTER SEQUENCE production.productdescription_productdescriptionid_seq OWNED BY production.productdescription.productdescriptionid;


--
-- Name: productdocument; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productdocument (
    productid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE production.productdocument OWNER TO postgres;

--
-- Name: TABLE productdocument; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productdocument IS 'Cross-reference table mapping products to related product documents.';


--
-- Name: COLUMN productdocument.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productdocument.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productdocument.documentnode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productdocument.documentnode IS 'Document identification number. Foreign key to Document.DocumentNode.';


--
-- Name: productinventory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productinventory (
    productid integer NOT NULL,
    locationid smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE production.productinventory OWNER TO postgres;

--
-- Name: TABLE productinventory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productinventory IS 'Product inventory information.';


--
-- Name: COLUMN productinventory.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productinventory.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productinventory.locationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productinventory.locationid IS 'Inventory location identification number. Foreign key to Location.LocationID.';


--
-- Name: COLUMN productinventory.shelf; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productinventory.shelf IS 'Storage compartment within an inventory location.';


--
-- Name: COLUMN productinventory.bin; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productinventory.bin IS 'Storage container on a shelf in an inventory location.';


--
-- Name: COLUMN productinventory.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productinventory.quantity IS 'Quantity of products in the inventory location.';


--
-- Name: productlistpricehistory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productlistpricehistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    listprice numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((listprice > 0.00))
);


ALTER TABLE production.productlistpricehistory OWNER TO postgres;

--
-- Name: TABLE productlistpricehistory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productlistpricehistory IS 'Changes in the list price of a product over time.';


--
-- Name: COLUMN productlistpricehistory.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productlistpricehistory.productid IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN productlistpricehistory.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productlistpricehistory.startdate IS 'List price start date.';


--
-- Name: COLUMN productlistpricehistory.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productlistpricehistory.enddate IS 'List price end date';


--
-- Name: COLUMN productlistpricehistory.listprice; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productlistpricehistory.listprice IS 'Product list price.';


--
-- Name: productmodel; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productmodel (
    productmodelid integer NOT NULL,
    catalogdescription xml,
    instructions xml,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productmodel OWNER TO postgres;

--
-- Name: TABLE productmodel; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productmodel IS 'Product model classification.';


--
-- Name: COLUMN productmodel.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodel.productmodelid IS 'Primary key for ProductModel records.';


--
-- Name: COLUMN productmodel.catalogdescription; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodel.catalogdescription IS 'Detailed product catalog information in xml format.';


--
-- Name: COLUMN productmodel.instructions; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodel.instructions IS 'Manufacturing instructions in xml format.';


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

ALTER SEQUENCE production.productmodel_productmodelid_seq OWNED BY production.productmodel.productmodelid;


--
-- Name: productmodelillustration; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productmodelillustration (
    productmodelid integer NOT NULL,
    illustrationid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productmodelillustration OWNER TO postgres;

--
-- Name: TABLE productmodelillustration; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productmodelillustration IS 'Cross-reference table mapping product models and illustrations.';


--
-- Name: COLUMN productmodelillustration.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodelillustration.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN productmodelillustration.illustrationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodelillustration.illustrationid IS 'Primary key. Foreign key to Illustration.IllustrationID.';


--
-- Name: productmodelproductdescriptionculture; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productmodelproductdescriptionculture (
    productmodelid integer NOT NULL,
    productdescriptionid integer NOT NULL,
    cultureid character(6) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productmodelproductdescriptionculture OWNER TO postgres;

--
-- Name: TABLE productmodelproductdescriptionculture; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productmodelproductdescriptionculture IS 'Cross-reference table mapping product descriptions and the language the description is written in.';


--
-- Name: COLUMN productmodelproductdescriptionculture.productmodelid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodelproductdescriptionculture.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN productmodelproductdescriptionculture.productdescriptionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodelproductdescriptionculture.productdescriptionid IS 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';


--
-- Name: COLUMN productmodelproductdescriptionculture.cultureid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productmodelproductdescriptionculture.cultureid IS 'Culture identification number. Foreign key to Culture.CultureID.';


--
-- Name: productphoto; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productphoto (
    productphotoid integer NOT NULL,
    thumbnailphoto bytea,
    thumbnailphotofilename character varying(50),
    largephoto bytea,
    largephotofilename character varying(50),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productphoto OWNER TO postgres;

--
-- Name: TABLE productphoto; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productphoto IS 'Product images.';


--
-- Name: COLUMN productphoto.productphotoid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productphoto.productphotoid IS 'Primary key for ProductPhoto records.';


--
-- Name: COLUMN productphoto.thumbnailphoto; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productphoto.thumbnailphoto IS 'Small image of the product.';


--
-- Name: COLUMN productphoto.thumbnailphotofilename; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productphoto.thumbnailphotofilename IS 'Small image file name.';


--
-- Name: COLUMN productphoto.largephoto; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productphoto.largephoto IS 'Large image of the product.';


--
-- Name: COLUMN productphoto.largephotofilename; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productphoto.largephotofilename IS 'Large image file name.';


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

ALTER SEQUENCE production.productphoto_productphotoid_seq OWNED BY production.productphoto.productphotoid;


--
-- Name: productproductphoto; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productproductphoto (
    productid integer NOT NULL,
    productphotoid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productproductphoto OWNER TO postgres;

--
-- Name: TABLE productproductphoto; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productproductphoto IS 'Cross-reference table mapping products and product photos.';


--
-- Name: COLUMN productproductphoto.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productproductphoto.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productproductphoto.productphotoid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productproductphoto.productphotoid IS 'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';


--
-- Name: productreview; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productreview (
    productreviewid integer NOT NULL,
    productid integer NOT NULL,
    reviewdate timestamp without time zone DEFAULT now() NOT NULL,
    emailaddress character varying(50) NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE production.productreview OWNER TO postgres;

--
-- Name: TABLE productreview; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productreview IS 'Customer reviews of products they have purchased.';


--
-- Name: COLUMN productreview.productreviewid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productreview.productreviewid IS 'Primary key for ProductReview records.';


--
-- Name: COLUMN productreview.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productreview.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productreview.reviewdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productreview.reviewdate IS 'Date review was submitted.';


--
-- Name: COLUMN productreview.emailaddress; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productreview.emailaddress IS 'Reviewer''s e-mail address.';


--
-- Name: COLUMN productreview.rating; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productreview.rating IS 'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.';


--
-- Name: COLUMN productreview.comments; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productreview.comments IS 'Reviewer''s comments';


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

ALTER SEQUENCE production.productreview_productreviewid_seq OWNED BY production.productreview.productreviewid;


--
-- Name: productsubcategory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.productsubcategory (
    productsubcategoryid integer NOT NULL,
    productcategoryid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productsubcategory OWNER TO postgres;

--
-- Name: TABLE productsubcategory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.productsubcategory IS 'Product subcategories. See ProductCategory table.';


--
-- Name: COLUMN productsubcategory.productsubcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productsubcategory.productsubcategoryid IS 'Primary key for ProductSubcategory records.';


--
-- Name: COLUMN productsubcategory.productcategoryid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.productsubcategory.productcategoryid IS 'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';


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

ALTER SEQUENCE production.productsubcategory_productsubcategoryid_seq OWNED BY production.productsubcategory.productsubcategoryid;


--
-- Name: scrapreason; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.scrapreason (
    scrapreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.scrapreason OWNER TO postgres;

--
-- Name: TABLE scrapreason; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.scrapreason IS 'Manufacturing failure reasons lookup table.';


--
-- Name: COLUMN scrapreason.scrapreasonid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.scrapreason.scrapreasonid IS 'Primary key for ScrapReason records.';


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

ALTER SEQUENCE production.scrapreason_scrapreasonid_seq OWNED BY production.scrapreason.scrapreasonid;


--
-- Name: transactionhistory; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.transactionhistory (
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


ALTER TABLE production.transactionhistory OWNER TO postgres;

--
-- Name: TABLE transactionhistory; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.transactionhistory IS 'Record of each purchase order, sales order, or work order transaction year to date.';


--
-- Name: COLUMN transactionhistory.transactionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.transactionid IS 'Primary key for TransactionHistory records.';


--
-- Name: COLUMN transactionhistory.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transactionhistory.referenceorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.referenceorderid IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transactionhistory.referenceorderlineid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transactionhistory.transactiondate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.transactiondate IS 'Date and time of the transaction.';


--
-- Name: COLUMN transactionhistory.transactiontype; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.transactiontype IS 'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';


--
-- Name: COLUMN transactionhistory.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.quantity IS 'Product quantity.';


--
-- Name: COLUMN transactionhistory.actualcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistory.actualcost IS 'Product cost.';


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

ALTER SEQUENCE production.transactionhistory_transactionid_seq OWNED BY production.transactionhistory.transactionid;


--
-- Name: transactionhistoryarchive; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.transactionhistoryarchive (
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


ALTER TABLE production.transactionhistoryarchive OWNER TO postgres;

--
-- Name: TABLE transactionhistoryarchive; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.transactionhistoryarchive IS 'Transactions for previous years.';


--
-- Name: COLUMN transactionhistoryarchive.transactionid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.transactionid IS 'Primary key for TransactionHistoryArchive records.';


--
-- Name: COLUMN transactionhistoryarchive.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transactionhistoryarchive.referenceorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.referenceorderid IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transactionhistoryarchive.referenceorderlineid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transactionhistoryarchive.transactiondate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.transactiondate IS 'Date and time of the transaction.';


--
-- Name: COLUMN transactionhistoryarchive.transactiontype; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.transactiontype IS 'W = Work Order, S = Sales Order, P = Purchase Order';


--
-- Name: COLUMN transactionhistoryarchive.quantity; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.quantity IS 'Product quantity.';


--
-- Name: COLUMN transactionhistoryarchive.actualcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.transactionhistoryarchive.actualcost IS 'Product cost.';


--
-- Name: unitmeasure; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.unitmeasure (
    unitmeasurecode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.unitmeasure OWNER TO postgres;

--
-- Name: TABLE unitmeasure; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.unitmeasure IS 'Unit of measure lookup table.';


--
-- Name: COLUMN unitmeasure.unitmeasurecode; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.unitmeasure.unitmeasurecode IS 'Primary key.';


--
-- Name: workorder; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.workorder (
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


ALTER TABLE production.workorder OWNER TO postgres;

--
-- Name: TABLE workorder; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.workorder IS 'Manufacturing work orders.';


--
-- Name: COLUMN workorder.workorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.workorderid IS 'Primary key for WorkOrder records.';


--
-- Name: COLUMN workorder.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN workorder.orderqty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.orderqty IS 'Product quantity to build.';


--
-- Name: COLUMN workorder.scrappedqty; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.scrappedqty IS 'Quantity that failed inspection.';


--
-- Name: COLUMN workorder.startdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.startdate IS 'Work order start date.';


--
-- Name: COLUMN workorder.enddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.enddate IS 'Work order end date.';


--
-- Name: COLUMN workorder.duedate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.duedate IS 'Work order due date.';


--
-- Name: COLUMN workorder.scrapreasonid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorder.scrapreasonid IS 'Reason for inspection failure.';


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

ALTER SEQUENCE production.workorder_workorderid_seq OWNED BY production.workorder.workorderid;


--
-- Name: workorderrouting; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.workorderrouting (
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


ALTER TABLE production.workorderrouting OWNER TO postgres;

--
-- Name: TABLE workorderrouting; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON TABLE production.workorderrouting IS 'Work order details.';


--
-- Name: COLUMN workorderrouting.workorderid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.workorderid IS 'Primary key. Foreign key to WorkOrder.WorkOrderID.';


--
-- Name: COLUMN workorderrouting.productid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.productid IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN workorderrouting.operationsequence; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.operationsequence IS 'Primary key. Indicates the manufacturing process sequence.';


--
-- Name: COLUMN workorderrouting.locationid; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.locationid IS 'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';


--
-- Name: COLUMN workorderrouting.scheduledstartdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.scheduledstartdate IS 'Planned manufacturing start date.';


--
-- Name: COLUMN workorderrouting.scheduledenddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.scheduledenddate IS 'Planned manufacturing end date.';


--
-- Name: COLUMN workorderrouting.actualstartdate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.actualstartdate IS 'Actual start date.';


--
-- Name: COLUMN workorderrouting.actualenddate; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.actualenddate IS 'Actual end date.';


--
-- Name: COLUMN workorderrouting.actualresourcehrs; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.actualresourcehrs IS 'Number of manufacturing hours used.';


--
-- Name: COLUMN workorderrouting.plannedcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.plannedcost IS 'Estimated manufacturing cost.';


--
-- Name: COLUMN workorderrouting.actualcost; Type: COMMENT; Schema: production; Owner: postgres
--

COMMENT ON COLUMN production.workorderrouting.actualcost IS 'Actual manufacturing cost.';


--
-- Name: productvendor; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.productvendor (
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


ALTER TABLE purchasing.productvendor OWNER TO postgres;

--
-- Name: TABLE productvendor; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.productvendor IS 'Cross-reference table mapping vendors with the products they supply.';


--
-- Name: COLUMN productvendor.productid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.productid IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productvendor.businessentityid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.businessentityid IS 'Primary key. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN productvendor.averageleadtime; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.averageleadtime IS 'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.';


--
-- Name: COLUMN productvendor.standardprice; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.standardprice IS 'The vendor''s usual selling price.';


--
-- Name: COLUMN productvendor.lastreceiptcost; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.lastreceiptcost IS 'The selling price when last purchased.';


--
-- Name: COLUMN productvendor.lastreceiptdate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.lastreceiptdate IS 'Date the product was last received by the vendor.';


--
-- Name: COLUMN productvendor.minorderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.minorderqty IS 'The maximum quantity that should be ordered.';


--
-- Name: COLUMN productvendor.maxorderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.maxorderqty IS 'The minimum quantity that should be ordered.';


--
-- Name: COLUMN productvendor.onorderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.onorderqty IS 'The quantity currently on order.';


--
-- Name: COLUMN productvendor.unitmeasurecode; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.productvendor.unitmeasurecode IS 'The product''s unit of measure.';


--
-- Name: purchaseorderdetail; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchaseorderdetail (
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


ALTER TABLE purchasing.purchaseorderdetail OWNER TO postgres;

--
-- Name: TABLE purchaseorderdetail; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.purchaseorderdetail IS 'Individual products associated with a specific purchase order. See PurchaseOrderHeader.';


--
-- Name: COLUMN purchaseorderdetail.purchaseorderid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.purchaseorderid IS 'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.';


--
-- Name: COLUMN purchaseorderdetail.purchaseorderdetailid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.purchaseorderdetailid IS 'Primary key. One line number per purchased product.';


--
-- Name: COLUMN purchaseorderdetail.duedate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.duedate IS 'Date the product is expected to be received.';


--
-- Name: COLUMN purchaseorderdetail.orderqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.orderqty IS 'Quantity ordered.';


--
-- Name: COLUMN purchaseorderdetail.productid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN purchaseorderdetail.unitprice; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.unitprice IS 'Vendor''s selling price of a single product.';


--
-- Name: COLUMN purchaseorderdetail.receivedqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.receivedqty IS 'Quantity actually received from the vendor.';


--
-- Name: COLUMN purchaseorderdetail.rejectedqty; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.rejectedqty IS 'Quantity rejected during inspection.';


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

ALTER SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq OWNED BY purchasing.purchaseorderdetail.purchaseorderdetailid;


--
-- Name: purchaseorderheader; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchaseorderheader (
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


ALTER TABLE purchasing.purchaseorderheader OWNER TO postgres;

--
-- Name: TABLE purchaseorderheader; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.purchaseorderheader IS 'General purchase order information. See PurchaseOrderDetail.';


--
-- Name: COLUMN purchaseorderheader.purchaseorderid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.purchaseorderid IS 'Primary key.';


--
-- Name: COLUMN purchaseorderheader.revisionnumber; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.revisionnumber IS 'Incremental number to track changes to the purchase order over time.';


--
-- Name: COLUMN purchaseorderheader.status; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.status IS 'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';


--
-- Name: COLUMN purchaseorderheader.employeeid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.employeeid IS 'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN purchaseorderheader.vendorid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.vendorid IS 'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN purchaseorderheader.shipmethodid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN purchaseorderheader.orderdate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.orderdate IS 'Purchase order creation date.';


--
-- Name: COLUMN purchaseorderheader.shipdate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.shipdate IS 'Estimated shipment date from the vendor.';


--
-- Name: COLUMN purchaseorderheader.subtotal; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.subtotal IS 'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';


--
-- Name: COLUMN purchaseorderheader.taxamt; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.taxamt IS 'Tax amount.';


--
-- Name: COLUMN purchaseorderheader.freight; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.purchaseorderheader.freight IS 'Shipping cost.';


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

ALTER SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq OWNED BY purchasing.purchaseorderheader.purchaseorderid;


--
-- Name: shipmethod; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.shipmethod (
    shipmethodid integer NOT NULL,
    shipbase numeric DEFAULT 0.00 NOT NULL,
    shiprate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((shipbase > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shiprate > 0.00))
);


ALTER TABLE purchasing.shipmethod OWNER TO postgres;

--
-- Name: TABLE shipmethod; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON TABLE purchasing.shipmethod IS 'Shipping company lookup table.';


--
-- Name: COLUMN shipmethod.shipmethodid; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.shipmethod.shipmethodid IS 'Primary key for ShipMethod records.';


--
-- Name: COLUMN shipmethod.shipbase; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.shipmethod.shipbase IS 'Minimum shipping charge.';


--
-- Name: COLUMN shipmethod.shiprate; Type: COMMENT; Schema: purchasing; Owner: postgres
--

COMMENT ON COLUMN purchasing.shipmethod.shiprate IS 'Shipping charge per pound.';


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

ALTER SEQUENCE purchasing.shipmethod_shipmethodid_seq OWNED BY purchasing.shipmethod.shipmethodid;


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
-- Name: countryregioncurrency; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.countryregioncurrency (
    countryregioncode character varying(3) NOT NULL,
    currencycode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.countryregioncurrency OWNER TO postgres;

--
-- Name: TABLE countryregioncurrency; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.countryregioncurrency IS 'Cross-reference table mapping ISO currency codes to a country or region.';


--
-- Name: COLUMN countryregioncurrency.countryregioncode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.countryregioncurrency.countryregioncode IS 'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN countryregioncurrency.currencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.countryregioncurrency.currencycode IS 'ISO standard currency code. Foreign key to Currency.CurrencyCode.';


--
-- Name: creditcard; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.creditcard (
    creditcardid integer NOT NULL,
    cardtype character varying(50) NOT NULL,
    cardnumber character varying(25) NOT NULL,
    expmonth smallint NOT NULL,
    expyear smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.creditcard OWNER TO postgres;

--
-- Name: TABLE creditcard; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.creditcard IS 'Customer credit card information.';


--
-- Name: COLUMN creditcard.creditcardid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.creditcard.creditcardid IS 'Primary key for CreditCard records.';


--
-- Name: COLUMN creditcard.cardtype; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.creditcard.cardtype IS 'Credit card name.';


--
-- Name: COLUMN creditcard.cardnumber; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.creditcard.cardnumber IS 'Credit card number.';


--
-- Name: COLUMN creditcard.expmonth; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.creditcard.expmonth IS 'Credit card expiration month.';


--
-- Name: COLUMN creditcard.expyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.creditcard.expyear IS 'Credit card expiration year.';


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

ALTER SEQUENCE sales.creditcard_creditcardid_seq OWNED BY sales.creditcard.creditcardid;


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
-- Name: currencyrate; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.currencyrate (
    currencyrateid integer NOT NULL,
    currencyratedate timestamp without time zone NOT NULL,
    fromcurrencycode character(3) NOT NULL,
    tocurrencycode character(3) NOT NULL,
    averagerate numeric NOT NULL,
    endofdayrate numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currencyrate OWNER TO postgres;

--
-- Name: TABLE currencyrate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.currencyrate IS 'Currency exchange rates.';


--
-- Name: COLUMN currencyrate.currencyrateid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currencyrate.currencyrateid IS 'Primary key for CurrencyRate records.';


--
-- Name: COLUMN currencyrate.currencyratedate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currencyrate.currencyratedate IS 'Date and time the exchange rate was obtained.';


--
-- Name: COLUMN currencyrate.fromcurrencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currencyrate.fromcurrencycode IS 'Exchange rate was converted from this currency code.';


--
-- Name: COLUMN currencyrate.tocurrencycode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currencyrate.tocurrencycode IS 'Exchange rate was converted to this currency code.';


--
-- Name: COLUMN currencyrate.averagerate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currencyrate.averagerate IS 'Average exchange rate for the day.';


--
-- Name: COLUMN currencyrate.endofdayrate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.currencyrate.endofdayrate IS 'Final exchange rate for the day.';


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

ALTER SEQUENCE sales.currencyrate_currencyrateid_seq OWNED BY sales.currencyrate.currencyrateid;


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

ALTER SEQUENCE sales.customer_customerid_seq OWNED BY sales.customer.customerid;


--
-- Name: personcreditcard; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.personcreditcard (
    businessentityid integer NOT NULL,
    creditcardid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.personcreditcard OWNER TO postgres;

--
-- Name: TABLE personcreditcard; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.personcreditcard IS 'Cross-reference table mapping people to their credit card information in the CreditCard table.';


--
-- Name: COLUMN personcreditcard.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.personcreditcard.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN personcreditcard.creditcardid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.personcreditcard.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: salesorderdetail; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesorderdetail (
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


ALTER TABLE sales.salesorderdetail OWNER TO postgres;

--
-- Name: TABLE salesorderdetail; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesorderdetail IS 'Individual products associated with a specific sales order. See SalesOrderHeader.';


--
-- Name: COLUMN salesorderdetail.salesorderid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';


--
-- Name: COLUMN salesorderdetail.salesorderdetailid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.salesorderdetailid IS 'Primary key. One incremental unique number per product sold.';


--
-- Name: COLUMN salesorderdetail.carriertrackingnumber; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.carriertrackingnumber IS 'Shipment tracking number supplied by the shipper.';


--
-- Name: COLUMN salesorderdetail.orderqty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.orderqty IS 'Quantity ordered per product.';


--
-- Name: COLUMN salesorderdetail.productid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.productid IS 'Product sold to customer. Foreign key to Product.ProductID.';


--
-- Name: COLUMN salesorderdetail.specialofferid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.specialofferid IS 'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.';


--
-- Name: COLUMN salesorderdetail.unitprice; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.unitprice IS 'Selling price of a single product.';


--
-- Name: COLUMN salesorderdetail.unitpricediscount; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderdetail.unitpricediscount IS 'Discount amount.';


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

ALTER SEQUENCE sales.salesorderdetail_salesorderdetailid_seq OWNED BY sales.salesorderdetail.salesorderdetailid;


--
-- Name: salesorderheader; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesorderheader (
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


ALTER TABLE sales.salesorderheader OWNER TO postgres;

--
-- Name: TABLE salesorderheader; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesorderheader IS 'General sales order information.';


--
-- Name: COLUMN salesorderheader.salesorderid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.salesorderid IS 'Primary key.';


--
-- Name: COLUMN salesorderheader.revisionnumber; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.revisionnumber IS 'Incremental number to track changes to the sales order over time.';


--
-- Name: COLUMN salesorderheader.orderdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.orderdate IS 'Dates the sales order was created.';


--
-- Name: COLUMN salesorderheader.duedate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.duedate IS 'Date the order is due to the customer.';


--
-- Name: COLUMN salesorderheader.shipdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.shipdate IS 'Date the order was shipped to the customer.';


--
-- Name: COLUMN salesorderheader.status; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.status IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';


--
-- Name: COLUMN salesorderheader.customerid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.customerid IS 'Customer identification number. Foreign key to Customer.BusinessEntityID.';


--
-- Name: COLUMN salesorderheader.salespersonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.salespersonid IS 'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN salesorderheader.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.territoryid IS 'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN salesorderheader.billtoaddressid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.billtoaddressid IS 'Customer billing address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN salesorderheader.shiptoaddressid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.shiptoaddressid IS 'Customer shipping address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN salesorderheader.shipmethodid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN salesorderheader.creditcardid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: COLUMN salesorderheader.creditcardapprovalcode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.creditcardapprovalcode IS 'Approval code provided by the credit card company.';


--
-- Name: COLUMN salesorderheader.currencyrateid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.currencyrateid IS 'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';


--
-- Name: COLUMN salesorderheader.subtotal; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.subtotal IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';


--
-- Name: COLUMN salesorderheader.taxamt; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.taxamt IS 'Tax amount.';


--
-- Name: COLUMN salesorderheader.freight; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.freight IS 'Shipping cost.';


--
-- Name: COLUMN salesorderheader.totaldue; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.totaldue IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';


--
-- Name: COLUMN salesorderheader.comment; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheader.comment IS 'Sales representative comments.';


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

ALTER SEQUENCE sales.salesorderheader_salesorderid_seq OWNED BY sales.salesorderheader.salesorderid;


--
-- Name: salesorderheadersalesreason; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesorderheadersalesreason (
    salesorderid integer NOT NULL,
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.salesorderheadersalesreason OWNER TO postgres;

--
-- Name: TABLE salesorderheadersalesreason; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesorderheadersalesreason IS 'Cross-reference table mapping sales orders to sales reason codes.';


--
-- Name: COLUMN salesorderheadersalesreason.salesorderid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheadersalesreason.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';


--
-- Name: COLUMN salesorderheadersalesreason.salesreasonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesorderheadersalesreason.salesreasonid IS 'Primary key. Foreign key to SalesReason.SalesReasonID.';


--
-- Name: salesperson; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesperson (
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


ALTER TABLE sales.salesperson OWNER TO postgres;

--
-- Name: TABLE salesperson; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesperson IS 'Sales representative current information.';


--
-- Name: COLUMN salesperson.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.businessentityid IS 'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';


--
-- Name: COLUMN salesperson.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.territoryid IS 'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN salesperson.salesquota; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.salesquota IS 'Projected yearly sales.';


--
-- Name: COLUMN salesperson.bonus; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.bonus IS 'Bonus due if quota is met.';


--
-- Name: COLUMN salesperson.commissionpct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.commissionpct IS 'Commision percent received per sale.';


--
-- Name: COLUMN salesperson.salesytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.salesytd IS 'Sales total year to date.';


--
-- Name: COLUMN salesperson.saleslastyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesperson.saleslastyear IS 'Sales total of previous year.';


--
-- Name: salespersonquotahistory; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salespersonquotahistory (
    businessentityid integer NOT NULL,
    quotadate timestamp without time zone NOT NULL,
    salesquota numeric NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((salesquota > 0.00))
);


ALTER TABLE sales.salespersonquotahistory OWNER TO postgres;

--
-- Name: TABLE salespersonquotahistory; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salespersonquotahistory IS 'Sales performance tracking.';


--
-- Name: COLUMN salespersonquotahistory.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salespersonquotahistory.businessentityid IS 'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN salespersonquotahistory.quotadate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salespersonquotahistory.quotadate IS 'Sales quota date.';


--
-- Name: COLUMN salespersonquotahistory.salesquota; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salespersonquotahistory.salesquota IS 'Sales quota amount.';


--
-- Name: salesreason; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesreason (
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.salesreason OWNER TO postgres;

--
-- Name: TABLE salesreason; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesreason IS 'Lookup table of customer purchase reasons.';


--
-- Name: COLUMN salesreason.salesreasonid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesreason.salesreasonid IS 'Primary key for SalesReason records.';


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

ALTER SEQUENCE sales.salesreason_salesreasonid_seq OWNED BY sales.salesreason.salesreasonid;


--
-- Name: salestaxrate; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salestaxrate (
    salestaxrateid integer NOT NULL,
    stateprovinceid integer NOT NULL,
    taxtype smallint NOT NULL,
    taxrate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((taxtype >= 1) AND (taxtype <= 3)))
);


ALTER TABLE sales.salestaxrate OWNER TO postgres;

--
-- Name: TABLE salestaxrate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salestaxrate IS 'Tax rate lookup table.';


--
-- Name: COLUMN salestaxrate.salestaxrateid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salestaxrate.salestaxrateid IS 'Primary key for SalesTaxRate records.';


--
-- Name: COLUMN salestaxrate.stateprovinceid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salestaxrate.stateprovinceid IS 'State, province, or country/region the sales tax applies to.';


--
-- Name: COLUMN salestaxrate.taxtype; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salestaxrate.taxtype IS '1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.';


--
-- Name: COLUMN salestaxrate.taxrate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salestaxrate.taxrate IS 'Tax rate amount.';


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

ALTER SEQUENCE sales.salestaxrate_salestaxrateid_seq OWNED BY sales.salestaxrate.salestaxrateid;


--
-- Name: salesterritory; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesterritory (
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


ALTER TABLE sales.salesterritory OWNER TO postgres;

--
-- Name: TABLE salesterritory; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesterritory IS 'Sales territory lookup table.';


--
-- Name: COLUMN salesterritory.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory.territoryid IS 'Primary key for SalesTerritory records.';


--
-- Name: COLUMN salesterritory.countryregioncode; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN salesterritory."group"; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory."group" IS 'Geographic area to which the sales territory belong.';


--
-- Name: COLUMN salesterritory.salesytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory.salesytd IS 'Sales in the territory year to date.';


--
-- Name: COLUMN salesterritory.saleslastyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory.saleslastyear IS 'Sales in the territory the previous year.';


--
-- Name: COLUMN salesterritory.costytd; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory.costytd IS 'Business costs in the territory year to date.';


--
-- Name: COLUMN salesterritory.costlastyear; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritory.costlastyear IS 'Business costs in the territory the previous year.';


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

ALTER SEQUENCE sales.salesterritory_territoryid_seq OWNED BY sales.salesterritory.territoryid;


--
-- Name: salesterritoryhistory; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.salesterritoryhistory (
    businessentityid integer NOT NULL,
    territoryid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);


ALTER TABLE sales.salesterritoryhistory OWNER TO postgres;

--
-- Name: TABLE salesterritoryhistory; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.salesterritoryhistory IS 'Sales representative transfers to other sales territories.';


--
-- Name: COLUMN salesterritoryhistory.businessentityid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritoryhistory.businessentityid IS 'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN salesterritoryhistory.territoryid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritoryhistory.territoryid IS 'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN salesterritoryhistory.startdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritoryhistory.startdate IS 'Primary key. Date the sales representive started work in the territory.';


--
-- Name: COLUMN salesterritoryhistory.enddate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.salesterritoryhistory.enddate IS 'Date the sales representative left work in the territory.';


--
-- Name: shoppingcartitem; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.shoppingcartitem (
    shoppingcartitemid integer NOT NULL,
    shoppingcartid character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    productid integer NOT NULL,
    datecreated timestamp without time zone DEFAULT now() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);


ALTER TABLE sales.shoppingcartitem OWNER TO postgres;

--
-- Name: TABLE shoppingcartitem; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.shoppingcartitem IS 'Contains online customer orders until the order is submitted or cancelled.';


--
-- Name: COLUMN shoppingcartitem.shoppingcartitemid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shoppingcartitem.shoppingcartitemid IS 'Primary key for ShoppingCartItem records.';


--
-- Name: COLUMN shoppingcartitem.shoppingcartid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shoppingcartitem.shoppingcartid IS 'Shopping cart identification number.';


--
-- Name: COLUMN shoppingcartitem.quantity; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shoppingcartitem.quantity IS 'Product quantity ordered.';


--
-- Name: COLUMN shoppingcartitem.productid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shoppingcartitem.productid IS 'Product ordered. Foreign key to Product.ProductID.';


--
-- Name: COLUMN shoppingcartitem.datecreated; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.shoppingcartitem.datecreated IS 'Date the time the record was created.';


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

ALTER SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq OWNED BY sales.shoppingcartitem.shoppingcartitemid;


--
-- Name: specialoffer; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.specialoffer (
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


ALTER TABLE sales.specialoffer OWNER TO postgres;

--
-- Name: TABLE specialoffer; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.specialoffer IS 'Sale discounts lookup table.';


--
-- Name: COLUMN specialoffer.specialofferid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.specialofferid IS 'Primary key for SpecialOffer records.';


--
-- Name: COLUMN specialoffer.description; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.description IS 'Discount description.';


--
-- Name: COLUMN specialoffer.discountpct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.discountpct IS 'Discount precentage.';


--
-- Name: COLUMN specialoffer.type; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.type IS 'Discount type category.';


--
-- Name: COLUMN specialoffer.category; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.category IS 'Group the discount applies to such as Reseller or Customer.';


--
-- Name: COLUMN specialoffer.startdate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.startdate IS 'Discount start date.';


--
-- Name: COLUMN specialoffer.enddate; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.enddate IS 'Discount end date.';


--
-- Name: COLUMN specialoffer.minqty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.minqty IS 'Minimum discount percent allowed.';


--
-- Name: COLUMN specialoffer.maxqty; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialoffer.maxqty IS 'Maximum discount percent allowed.';


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

ALTER SEQUENCE sales.specialoffer_specialofferid_seq OWNED BY sales.specialoffer.specialofferid;


--
-- Name: specialofferproduct; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.specialofferproduct (
    specialofferid integer NOT NULL,
    productid integer NOT NULL,
    rowguid uuid NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.specialofferproduct OWNER TO postgres;

--
-- Name: TABLE specialofferproduct; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.specialofferproduct IS 'Cross-reference table mapping products to special offer discounts.';


--
-- Name: COLUMN specialofferproduct.specialofferid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialofferproduct.specialofferid IS 'Primary key for SpecialOfferProduct records.';


--
-- Name: COLUMN specialofferproduct.productid; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON COLUMN sales.specialofferproduct.productid IS 'Product identification number. Foreign key to Product.ProductID.';


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
-- Name: TABLE store; Type: COMMENT; Schema: sales; Owner: postgres
--

COMMENT ON TABLE sales.store IS 'Customers (resellers) of Adventure Works products.';


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
-- Name: department departmentid; Type: DEFAULT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.department ALTER COLUMN departmentid SET DEFAULT nextval('human_resources.department_departmentid_seq'::regclass);


--
-- Name: jobcandidate jobcandidateid; Type: DEFAULT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.jobcandidate ALTER COLUMN jobcandidateid SET DEFAULT nextval('human_resources.jobcandidate_jobcandidateid_seq'::regclass);


--
-- Name: shift shiftid; Type: DEFAULT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.shift ALTER COLUMN shiftid SET DEFAULT nextval('human_resources.shift_shiftid_seq'::regclass);


--
-- Name: address addressid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address ALTER COLUMN addressid SET DEFAULT nextval('person.address_addressid_seq'::regclass);


--
-- Name: addresstype addresstypeid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.addresstype ALTER COLUMN addresstypeid SET DEFAULT nextval('person.addresstype_addresstypeid_seq'::regclass);


--
-- Name: businessentity businessentityid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentity ALTER COLUMN businessentityid SET DEFAULT nextval('person.businessentity_businessentityid_seq'::regclass);


--
-- Name: contacttype contacttypeid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.contacttype ALTER COLUMN contacttypeid SET DEFAULT nextval('person.contacttype_contacttypeid_seq'::regclass);


--
-- Name: emailaddress emailaddressid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.emailaddress ALTER COLUMN emailaddressid SET DEFAULT nextval('person.emailaddress_emailaddressid_seq'::regclass);


--
-- Name: phonenumbertype phonenumbertypeid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.phonenumbertype ALTER COLUMN phonenumbertypeid SET DEFAULT nextval('person.phonenumbertype_phonenumbertypeid_seq'::regclass);


--
-- Name: stateprovince stateprovinceid; Type: DEFAULT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.stateprovince ALTER COLUMN stateprovinceid SET DEFAULT nextval('person.stateprovince_stateprovinceid_seq'::regclass);


--
-- Name: billofmaterials billofmaterialsid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.billofmaterials ALTER COLUMN billofmaterialsid SET DEFAULT nextval('production.billofmaterials_billofmaterialsid_seq'::regclass);


--
-- Name: illustration illustrationid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.illustration ALTER COLUMN illustrationid SET DEFAULT nextval('production.illustration_illustrationid_seq'::regclass);


--
-- Name: location locationid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.location ALTER COLUMN locationid SET DEFAULT nextval('production.location_locationid_seq'::regclass);


--
-- Name: product productid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product ALTER COLUMN productid SET DEFAULT nextval('production.product_productid_seq'::regclass);


--
-- Name: productcategory productcategoryid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productcategory ALTER COLUMN productcategoryid SET DEFAULT nextval('production.productcategory_productcategoryid_seq'::regclass);


--
-- Name: productdescription productdescriptionid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productdescription ALTER COLUMN productdescriptionid SET DEFAULT nextval('production.productdescription_productdescriptionid_seq'::regclass);


--
-- Name: productmodel productmodelid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodel ALTER COLUMN productmodelid SET DEFAULT nextval('production.productmodel_productmodelid_seq'::regclass);


--
-- Name: productphoto productphotoid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productphoto ALTER COLUMN productphotoid SET DEFAULT nextval('production.productphoto_productphotoid_seq'::regclass);


--
-- Name: productreview productreviewid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productreview ALTER COLUMN productreviewid SET DEFAULT nextval('production.productreview_productreviewid_seq'::regclass);


--
-- Name: productsubcategory productsubcategoryid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productsubcategory ALTER COLUMN productsubcategoryid SET DEFAULT nextval('production.productsubcategory_productsubcategoryid_seq'::regclass);


--
-- Name: scrapreason scrapreasonid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.scrapreason ALTER COLUMN scrapreasonid SET DEFAULT nextval('production.scrapreason_scrapreasonid_seq'::regclass);


--
-- Name: transactionhistory transactionid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transactionhistory ALTER COLUMN transactionid SET DEFAULT nextval('production.transactionhistory_transactionid_seq'::regclass);


--
-- Name: workorder workorderid; Type: DEFAULT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorder ALTER COLUMN workorderid SET DEFAULT nextval('production.workorder_workorderid_seq'::regclass);


--
-- Name: purchaseorderdetail purchaseorderdetailid; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderdetail ALTER COLUMN purchaseorderdetailid SET DEFAULT nextval('purchasing.purchaseorderdetail_purchaseorderdetailid_seq'::regclass);


--
-- Name: purchaseorderheader purchaseorderid; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderheader ALTER COLUMN purchaseorderid SET DEFAULT nextval('purchasing.purchaseorderheader_purchaseorderid_seq'::regclass);


--
-- Name: shipmethod shipmethodid; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.shipmethod ALTER COLUMN shipmethodid SET DEFAULT nextval('purchasing.shipmethod_shipmethodid_seq'::regclass);


--
-- Name: creditcard creditcardid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.creditcard ALTER COLUMN creditcardid SET DEFAULT nextval('sales.creditcard_creditcardid_seq'::regclass);


--
-- Name: currencyrate currencyrateid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currencyrate ALTER COLUMN currencyrateid SET DEFAULT nextval('sales.currencyrate_currencyrateid_seq'::regclass);


--
-- Name: customer customerid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer ALTER COLUMN customerid SET DEFAULT nextval('sales.customer_customerid_seq'::regclass);


--
-- Name: salesorderdetail salesorderdetailid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderdetail ALTER COLUMN salesorderdetailid SET DEFAULT nextval('sales.salesorderdetail_salesorderdetailid_seq'::regclass);


--
-- Name: salesorderheader salesorderid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader ALTER COLUMN salesorderid SET DEFAULT nextval('sales.salesorderheader_salesorderid_seq'::regclass);


--
-- Name: salesreason salesreasonid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesreason ALTER COLUMN salesreasonid SET DEFAULT nextval('sales.salesreason_salesreasonid_seq'::regclass);


--
-- Name: salestaxrate salestaxrateid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salestaxrate ALTER COLUMN salestaxrateid SET DEFAULT nextval('sales.salestaxrate_salestaxrateid_seq'::regclass);


--
-- Name: salesterritory territoryid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesterritory ALTER COLUMN territoryid SET DEFAULT nextval('sales.salesterritory_territoryid_seq'::regclass);


--
-- Name: shoppingcartitem shoppingcartitemid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shoppingcartitem ALTER COLUMN shoppingcartitemid SET DEFAULT nextval('sales.shoppingcartitem_shoppingcartitemid_seq'::regclass);


--
-- Name: specialoffer specialofferid; Type: DEFAULT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.specialoffer ALTER COLUMN specialofferid SET DEFAULT nextval('sales.specialoffer_specialofferid_seq'::regclass);


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
-- Data for Name: employeedepartmenthistory; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employeedepartmenthistory (businessentityid, departmentid, shiftid, startdate, enddate, modifieddate) FROM stdin;
\.


--
-- Data for Name: employeepayhistory; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employeepayhistory (businessentityid, ratechangedate, rate, payfrequency, modifieddate) FROM stdin;
\.


--
-- Data for Name: jobcandidate; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.jobcandidate (jobcandidateid, businessentityid, resume, modifieddate) FROM stdin;
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
-- Data for Name: addresstype; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.addresstype (addresstypeid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: businessentity; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.businessentity (businessentityid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: businessentityaddress; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.businessentityaddress (businessentityid, addressid, addresstypeid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: businessentitycontact; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.businessentitycontact (businessentityid, personid, contacttypeid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: contacttype; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.contacttype (contacttypeid, modifieddate) FROM stdin;
\.


--
-- Data for Name: countryregion; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.countryregion (countryregioncode, modifieddate) FROM stdin;
\.


--
-- Data for Name: emailaddress; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.emailaddress (businessentityid, emailaddressid, emailaddress, rowguid, modifieddate) FROM stdin;
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
-- Data for Name: personphone; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.personphone (businessentityid, phonenumbertypeid, modifieddate) FROM stdin;
\.


--
-- Data for Name: phonenumbertype; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.phonenumbertype (phonenumbertypeid, modifieddate) FROM stdin;
\.


--
-- Data for Name: stateprovince; Type: TABLE DATA; Schema: person; Owner: postgres
--

COPY person.stateprovince (stateprovinceid, stateprovincecode, countryregioncode, territoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: billofmaterials; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.billofmaterials (billofmaterialsid, productassemblyid, componentid, startdate, enddate, unitmeasurecode, bomlevel, perassemblyqty, modifieddate) FROM stdin;
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
-- Data for Name: productcategory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productcategory (productcategoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productcosthistory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productcosthistory (productid, startdate, enddate, standardcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: productdescription; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productdescription (productdescriptionid, description, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productdocument; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productdocument (productid, modifieddate, documentnode) FROM stdin;
\.


--
-- Data for Name: productinventory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productinventory (productid, locationid, shelf, bin, quantity, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productlistpricehistory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productlistpricehistory (productid, startdate, enddate, listprice, modifieddate) FROM stdin;
\.


--
-- Data for Name: productmodel; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productmodel (productmodelid, catalogdescription, instructions, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productmodelillustration; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productmodelillustration (productmodelid, illustrationid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productmodelproductdescriptionculture; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productmodelproductdescriptionculture (productmodelid, productdescriptionid, cultureid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productphoto; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productphoto (productphotoid, thumbnailphoto, thumbnailphotofilename, largephoto, largephotofilename, modifieddate) FROM stdin;
\.


--
-- Data for Name: productproductphoto; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productproductphoto (productid, productphotoid, modifieddate) FROM stdin;
\.


--
-- Data for Name: productreview; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productreview (productreviewid, productid, reviewdate, emailaddress, rating, comments, modifieddate) FROM stdin;
1	709	2013-09-18 00:00:00	john@fourthcoffee.com	5	I can't believe I'm singing the praises of a pair of socks, but I just came back from a grueling\n3-day ride and these socks really helped make the trip a blast. They're lightweight yet really cushioned my feet all day. \nThe reinforced toe is nearly bullet-proof and I didn't experience any problems with rubbing or blisters like I have with\nother brands. I know it sounds silly, but it's always the little stuff (like comfortable feet) that makes or breaks a long trip.\nI won't go on another trip without them!	2013-09-18 00:00:00
2	937	2013-11-13 00:00:00	david@graphicdesigninstitute.com	4	A little on the heavy side, but overall the entry/exit is easy in all conditions. I've used these pedals for \nmore than 3 years and I've never had a problem. Cleanup is easy. Mud and sand don't get trapped. I would like \nthem even better if there was a weight reduction. Maybe in the next design. Still, I would recommend them to a friend.	2013-11-13 00:00:00
3	937	2013-11-15 00:00:00	jill@margiestravel.com	2	Maybe it's just because I'm new to mountain biking, but I had a terrible time getting use\nto these pedals. In my first outing, I wiped out trying to release my foot. Any suggestions on\nways I can adjust the pedals, or is it just a learning curve thing?	2013-11-15 00:00:00
4	798	2013-11-15 00:00:00	laura@treyresearch.net	5	The Road-550-W from Adventure Works Cycles is everything it's advertised to be. Finally, a quality bike that\nis actually built for a woman and provides control and comfort in one neat package. The top tube is shorter, the suspension is weight-tuned and there's a much shorter reach to the brake\nlevers. All this adds up to a great mountain bike that is sure to accommodate any woman's anatomy. In addition to getting the size right, the saddle is incredibly comfortable. \nAttention to detail is apparent in every aspect from the frame finish to the careful design of each component. Each component is a solid performer without any fluff. \nThe designers clearly did their homework and thought about size, weight, and funtionality throughout. And at less than 19 pounds, the bike is manageable for even the most petite cyclist.\n\nWe had 5 riders take the bike out for a spin and really put it to the test. The results were consistent and very positive. Our testers loved the manuverability \nand control they had with the redesigned frame on the 550-W. A definite improvement over the 2012 design. Four out of five testers listed quick handling\nand responsivness were the key elements they noticed. Technical climbing and on the flats, the bike just cruises through the rough. Tight corners and obstacles were handled effortlessly. The fifth tester was more impressed with the smooth ride. The heavy-duty shocks absorbed even the worst bumps and provided a soft ride on all but the \nnastiest trails and biggest drops. The shifting was rated superb and typical of what we've come to expect from Adventure Works Cycles. On descents, the bike handled flawlessly and tracked very well. The bike is well balanced front-to-rear and frame flex was minimal. In particular, the testers\nnoted that the brake system had a unique combination of power and modulation.  While some brake setups can be overly touchy, these brakes had a good\namount of power, but also a good feel that allows you to apply as little or as much braking power as is needed. Second is their short break-in period. We found that they tend to break-in well before\nthe end of the first ride; while others take two to three rides (or more) to come to full power. \n\nOn the negative side, the pedals were not quite up to our tester's standards. \nJust for fun, we experimented with routine maintenance tasks. Overall we found most operations to be straight forward and easy to complete. The only exception was replacing the front wheel. The maintenance manual that comes\nwith the bike say to install the front wheel with the axle quick release or bolt, then compress the fork a few times before fastening and tightening the two quick-release mechanisms on the bottom of the dropouts. This is to seat the axle in the dropouts, and if you do not\ndo this, the axle will become seated after you tightened the two bottom quick releases, which will then become loose. It's better to test the tightness carefully or you may notice that the two bottom quick releases have come loose enough to fall completely open. And that's something you don't want to experience\nwhile out on the road! \n\nThe Road-550-W frame is available in a variety of sizes and colors and has the same durable, high-quality aluminum that AWC is known for. At a MSRP of just under $1125.00, it's comparable in price to its closest competitors and\nwe think that after a test drive you'l find the quality and performance above and beyond . You'll have a grin on your face and be itching to get out on the road for more. While designed for serious road racing, the Road-550-W would be an excellent choice for just about any terrain and \nany level of experience. It's a huge step in the right direction for female cyclists and well worth your consideration and hard-earned money.	2013-11-15 00:00:00
\.


--
-- Data for Name: productsubcategory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.productsubcategory (productsubcategoryid, productcategoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: scrapreason; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.scrapreason (scrapreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: transactionhistory; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.transactionhistory (transactionid, productid, referenceorderid, referenceorderlineid, transactiondate, transactiontype, quantity, actualcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: transactionhistoryarchive; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.transactionhistoryarchive (transactionid, productid, referenceorderid, referenceorderlineid, transactiondate, transactiontype, quantity, actualcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: unitmeasure; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.unitmeasure (unitmeasurecode, modifieddate) FROM stdin;
\.


--
-- Data for Name: workorder; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.workorder (workorderid, productid, orderqty, scrappedqty, startdate, enddate, duedate, scrapreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: workorderrouting; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.workorderrouting (workorderid, productid, operationsequence, locationid, scheduledstartdate, scheduledenddate, actualstartdate, actualenddate, actualresourcehrs, plannedcost, actualcost, modifieddate) FROM stdin;
\.


--
-- Data for Name: productvendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.productvendor (productid, businessentityid, averageleadtime, standardprice, lastreceiptcost, lastreceiptdate, minorderqty, maxorderqty, onorderqty, unitmeasurecode, modifieddate) FROM stdin;
\.


--
-- Data for Name: purchaseorderdetail; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchaseorderdetail (purchaseorderid, purchaseorderdetailid, duedate, orderqty, productid, unitprice, receivedqty, rejectedqty, modifieddate) FROM stdin;
\.


--
-- Data for Name: purchaseorderheader; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchaseorderheader (purchaseorderid, revisionnumber, status, employeeid, vendorid, shipmethodid, orderdate, shipdate, subtotal, taxamt, freight, modifieddate) FROM stdin;
\.


--
-- Data for Name: shipmethod; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.shipmethod (shipmethodid, shipbase, shiprate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: vendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.vendor (businessentityid, creditrating, purchasingwebserviceurl, modifieddate) FROM stdin;
\.


--
-- Data for Name: countryregioncurrency; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.countryregioncurrency (countryregioncode, currencycode, modifieddate) FROM stdin;
\.


--
-- Data for Name: creditcard; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.creditcard (creditcardid, cardtype, cardnumber, expmonth, expyear, modifieddate) FROM stdin;
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.currency (currencycode, modifieddate) FROM stdin;
\.


--
-- Data for Name: currencyrate; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.currencyrate (currencyrateid, currencyratedate, fromcurrencycode, tocurrencycode, averagerate, endofdayrate, modifieddate) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customer (customerid, personid, storeid, territoryid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: personcreditcard; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.personcreditcard (businessentityid, creditcardid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesorderdetail; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesorderdetail (salesorderid, salesorderdetailid, carriertrackingnumber, orderqty, productid, specialofferid, unitprice, unitpricediscount, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesorderheader; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesorderheader (salesorderid, revisionnumber, orderdate, duedate, shipdate, status, customerid, salespersonid, territoryid, billtoaddressid, shiptoaddressid, shipmethodid, creditcardid, creditcardapprovalcode, currencyrateid, subtotal, taxamt, freight, totaldue, comment, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesorderheadersalesreason; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesorderheadersalesreason (salesorderid, salesreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesperson; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesperson (businessentityid, territoryid, salesquota, bonus, commissionpct, salesytd, saleslastyear, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salespersonquotahistory; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salespersonquotahistory (businessentityid, quotadate, salesquota, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesreason; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesreason (salesreasonid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salestaxrate; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salestaxrate (salestaxrateid, stateprovinceid, taxtype, taxrate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesterritory; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesterritory (territoryid, countryregioncode, "group", salesytd, saleslastyear, costytd, costlastyear, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: salesterritoryhistory; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.salesterritoryhistory (businessentityid, territoryid, startdate, enddate, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: shoppingcartitem; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.shoppingcartitem (shoppingcartitemid, shoppingcartid, quantity, productid, datecreated, modifieddate) FROM stdin;
\.


--
-- Data for Name: specialoffer; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.specialoffer (specialofferid, description, discountpct, type, category, startdate, enddate, minqty, maxqty, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: specialofferproduct; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.specialofferproduct (specialofferid, productid, rowguid, modifieddate) FROM stdin;
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.store (businessentityid, salespersonid, demographics, rowguid, modifieddate) FROM stdin;
\.


--
-- Name: department_departmentid_seq; Type: SEQUENCE SET; Schema: human_resources; Owner: postgres
--

SELECT pg_catalog.setval('human_resources.department_departmentid_seq', 1, false);


--
-- Name: jobcandidate_jobcandidateid_seq; Type: SEQUENCE SET; Schema: human_resources; Owner: postgres
--

SELECT pg_catalog.setval('human_resources.jobcandidate_jobcandidateid_seq', 1, false);


--
-- Name: shift_shiftid_seq; Type: SEQUENCE SET; Schema: human_resources; Owner: postgres
--

SELECT pg_catalog.setval('human_resources.shift_shiftid_seq', 1, false);


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
    ADD CONSTRAINT "PK_Department_DepartmentID" PRIMARY KEY (departmentid);

ALTER TABLE human_resources.department CLUSTER ON "PK_Department_DepartmentID";


--
-- Name: employeedepartmenthistory PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employeedepartmenthistory
    ADD CONSTRAINT "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm" PRIMARY KEY (businessentityid, startdate, departmentid, shiftid);

ALTER TABLE human_resources.employeedepartmenthistory CLUSTER ON "PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_Departm";


--
-- Name: employeepayhistory PK_EmployeePayHistory_BusinessEntityID_RateChangeDate; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employeepayhistory
    ADD CONSTRAINT "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate" PRIMARY KEY (businessentityid, ratechangedate);

ALTER TABLE human_resources.employeepayhistory CLUSTER ON "PK_EmployeePayHistory_BusinessEntityID_RateChangeDate";


--
-- Name: employee PK_Employee_BusinessEntityID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee
    ADD CONSTRAINT "PK_Employee_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE human_resources.employee CLUSTER ON "PK_Employee_BusinessEntityID";


--
-- Name: jobcandidate PK_JobCandidate_JobCandidateID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.jobcandidate
    ADD CONSTRAINT "PK_JobCandidate_JobCandidateID" PRIMARY KEY (jobcandidateid);

ALTER TABLE human_resources.jobcandidate CLUSTER ON "PK_JobCandidate_JobCandidateID";


--
-- Name: shift PK_Shift_ShiftID; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.shift
    ADD CONSTRAINT "PK_Shift_ShiftID" PRIMARY KEY (shiftid);

ALTER TABLE human_resources.shift CLUSTER ON "PK_Shift_ShiftID";


--
-- Name: addresstype PK_AddressType_AddressTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.addresstype
    ADD CONSTRAINT "PK_AddressType_AddressTypeID" PRIMARY KEY (addresstypeid);

ALTER TABLE person.addresstype CLUSTER ON "PK_AddressType_AddressTypeID";


--
-- Name: address PK_Address_AddressID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address
    ADD CONSTRAINT "PK_Address_AddressID" PRIMARY KEY (addressid);

ALTER TABLE person.address CLUSTER ON "PK_Address_AddressID";


--
-- Name: businessentityaddress PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType" PRIMARY KEY (businessentityid, addressid, addresstypeid);

ALTER TABLE person.businessentityaddress CLUSTER ON "PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressType";


--
-- Name: businessentitycontact PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI" PRIMARY KEY (businessentityid, personid, contacttypeid);

ALTER TABLE person.businessentitycontact CLUSTER ON "PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeI";


--
-- Name: businessentity PK_BusinessEntity_BusinessEntityID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentity
    ADD CONSTRAINT "PK_BusinessEntity_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE person.businessentity CLUSTER ON "PK_BusinessEntity_BusinessEntityID";


--
-- Name: contacttype PK_ContactType_ContactTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.contacttype
    ADD CONSTRAINT "PK_ContactType_ContactTypeID" PRIMARY KEY (contacttypeid);

ALTER TABLE person.contacttype CLUSTER ON "PK_ContactType_ContactTypeID";


--
-- Name: countryregion PK_CountryRegion_CountryRegionCode; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.countryregion
    ADD CONSTRAINT "PK_CountryRegion_CountryRegionCode" PRIMARY KEY (countryregioncode);

ALTER TABLE person.countryregion CLUSTER ON "PK_CountryRegion_CountryRegionCode";


--
-- Name: emailaddress PK_EmailAddress_BusinessEntityID_EmailAddressID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.emailaddress
    ADD CONSTRAINT "PK_EmailAddress_BusinessEntityID_EmailAddressID" PRIMARY KEY (businessentityid, emailaddressid);

ALTER TABLE person.emailaddress CLUSTER ON "PK_EmailAddress_BusinessEntityID_EmailAddressID";


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
-- Name: phonenumbertype PK_PhoneNumberType_PhoneNumberTypeID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.phonenumbertype
    ADD CONSTRAINT "PK_PhoneNumberType_PhoneNumberTypeID" PRIMARY KEY (phonenumbertypeid);

ALTER TABLE person.phonenumbertype CLUSTER ON "PK_PhoneNumberType_PhoneNumberTypeID";


--
-- Name: stateprovince PK_StateProvince_StateProvinceID; Type: CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.stateprovince
    ADD CONSTRAINT "PK_StateProvince_StateProvinceID" PRIMARY KEY (stateprovinceid);

ALTER TABLE person.stateprovince CLUSTER ON "PK_StateProvince_StateProvinceID";


--
-- Name: billofmaterials PK_BillOfMaterials_BillOfMaterialsID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.billofmaterials
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
-- Name: productcategory PK_ProductCategory_ProductCategoryID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productcategory
    ADD CONSTRAINT "PK_ProductCategory_ProductCategoryID" PRIMARY KEY (productcategoryid);

ALTER TABLE production.productcategory CLUSTER ON "PK_ProductCategory_ProductCategoryID";


--
-- Name: productcosthistory PK_ProductCostHistory_ProductID_StartDate; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productcosthistory
    ADD CONSTRAINT "PK_ProductCostHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate);

ALTER TABLE production.productcosthistory CLUSTER ON "PK_ProductCostHistory_ProductID_StartDate";


--
-- Name: productdescription PK_ProductDescription_ProductDescriptionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productdescription
    ADD CONSTRAINT "PK_ProductDescription_ProductDescriptionID" PRIMARY KEY (productdescriptionid);

ALTER TABLE production.productdescription CLUSTER ON "PK_ProductDescription_ProductDescriptionID";


--
-- Name: productdocument PK_ProductDocument_ProductID_DocumentNode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productdocument
    ADD CONSTRAINT "PK_ProductDocument_ProductID_DocumentNode" PRIMARY KEY (productid, documentnode);

ALTER TABLE production.productdocument CLUSTER ON "PK_ProductDocument_ProductID_DocumentNode";


--
-- Name: productinventory PK_ProductInventory_ProductID_LocationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productinventory
    ADD CONSTRAINT "PK_ProductInventory_ProductID_LocationID" PRIMARY KEY (productid, locationid);

ALTER TABLE production.productinventory CLUSTER ON "PK_ProductInventory_ProductID_LocationID";


--
-- Name: productlistpricehistory PK_ProductListPriceHistory_ProductID_StartDate; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productlistpricehistory
    ADD CONSTRAINT "PK_ProductListPriceHistory_ProductID_StartDate" PRIMARY KEY (productid, startdate);

ALTER TABLE production.productlistpricehistory CLUSTER ON "PK_ProductListPriceHistory_ProductID_StartDate";


--
-- Name: productmodelillustration PK_ProductModelIllustration_ProductModelID_IllustrationID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelillustration
    ADD CONSTRAINT "PK_ProductModelIllustration_ProductModelID_IllustrationID" PRIMARY KEY (productmodelid, illustrationid);

ALTER TABLE production.productmodelillustration CLUSTER ON "PK_ProductModelIllustration_ProductModelID_IllustrationID";


--
-- Name: productmodelproductdescriptionculture PK_ProductModelProductDescriptionCulture_ProductModelID_Product; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "PK_ProductModelProductDescriptionCulture_ProductModelID_Product" PRIMARY KEY (productmodelid, productdescriptionid, cultureid);

ALTER TABLE production.productmodelproductdescriptionculture CLUSTER ON "PK_ProductModelProductDescriptionCulture_ProductModelID_Product";


--
-- Name: productmodel PK_ProductModel_ProductModelID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodel
    ADD CONSTRAINT "PK_ProductModel_ProductModelID" PRIMARY KEY (productmodelid);

ALTER TABLE production.productmodel CLUSTER ON "PK_ProductModel_ProductModelID";


--
-- Name: productphoto PK_ProductPhoto_ProductPhotoID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productphoto
    ADD CONSTRAINT "PK_ProductPhoto_ProductPhotoID" PRIMARY KEY (productphotoid);

ALTER TABLE production.productphoto CLUSTER ON "PK_ProductPhoto_ProductPhotoID";


--
-- Name: productproductphoto PK_ProductProductPhoto_ProductID_ProductPhotoID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productproductphoto
    ADD CONSTRAINT "PK_ProductProductPhoto_ProductID_ProductPhotoID" PRIMARY KEY (productid, productphotoid);


--
-- Name: productreview PK_ProductReview_ProductReviewID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productreview
    ADD CONSTRAINT "PK_ProductReview_ProductReviewID" PRIMARY KEY (productreviewid);

ALTER TABLE production.productreview CLUSTER ON "PK_ProductReview_ProductReviewID";


--
-- Name: productsubcategory PK_ProductSubcategory_ProductSubcategoryID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productsubcategory
    ADD CONSTRAINT "PK_ProductSubcategory_ProductSubcategoryID" PRIMARY KEY (productsubcategoryid);

ALTER TABLE production.productsubcategory CLUSTER ON "PK_ProductSubcategory_ProductSubcategoryID";


--
-- Name: product PK_Product_ProductID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "PK_Product_ProductID" PRIMARY KEY (productid);

ALTER TABLE production.product CLUSTER ON "PK_Product_ProductID";


--
-- Name: scrapreason PK_ScrapReason_ScrapReasonID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.scrapreason
    ADD CONSTRAINT "PK_ScrapReason_ScrapReasonID" PRIMARY KEY (scrapreasonid);

ALTER TABLE production.scrapreason CLUSTER ON "PK_ScrapReason_ScrapReasonID";


--
-- Name: transactionhistoryarchive PK_TransactionHistoryArchive_TransactionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transactionhistoryarchive
    ADD CONSTRAINT "PK_TransactionHistoryArchive_TransactionID" PRIMARY KEY (transactionid);

ALTER TABLE production.transactionhistoryarchive CLUSTER ON "PK_TransactionHistoryArchive_TransactionID";


--
-- Name: transactionhistory PK_TransactionHistory_TransactionID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transactionhistory
    ADD CONSTRAINT "PK_TransactionHistory_TransactionID" PRIMARY KEY (transactionid);

ALTER TABLE production.transactionhistory CLUSTER ON "PK_TransactionHistory_TransactionID";


--
-- Name: unitmeasure PK_UnitMeasure_UnitMeasureCode; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.unitmeasure
    ADD CONSTRAINT "PK_UnitMeasure_UnitMeasureCode" PRIMARY KEY (unitmeasurecode);

ALTER TABLE production.unitmeasure CLUSTER ON "PK_UnitMeasure_UnitMeasureCode";


--
-- Name: workorderrouting PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorderrouting
    ADD CONSTRAINT "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence" PRIMARY KEY (workorderid, productid, operationsequence);

ALTER TABLE production.workorderrouting CLUSTER ON "PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence";


--
-- Name: workorder PK_WorkOrder_WorkOrderID; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorder
    ADD CONSTRAINT "PK_WorkOrder_WorkOrderID" PRIMARY KEY (workorderid);

ALTER TABLE production.workorder CLUSTER ON "PK_WorkOrder_WorkOrderID";


--
-- Name: document document_rowguid_key; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT document_rowguid_key UNIQUE (rowguid);


--
-- Name: productvendor PK_ProductVendor_ProductID_BusinessEntityID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "PK_ProductVendor_ProductID_BusinessEntityID" PRIMARY KEY (productid, businessentityid);

ALTER TABLE purchasing.productvendor CLUSTER ON "PK_ProductVendor_ProductID_BusinessEntityID";


--
-- Name: purchaseorderdetail PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderdetail
    ADD CONSTRAINT "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID" PRIMARY KEY (purchaseorderid, purchaseorderdetailid);

ALTER TABLE purchasing.purchaseorderdetail CLUSTER ON "PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID";


--
-- Name: purchaseorderheader PK_PurchaseOrderHeader_PurchaseOrderID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "PK_PurchaseOrderHeader_PurchaseOrderID" PRIMARY KEY (purchaseorderid);

ALTER TABLE purchasing.purchaseorderheader CLUSTER ON "PK_PurchaseOrderHeader_PurchaseOrderID";


--
-- Name: shipmethod PK_ShipMethod_ShipMethodID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.shipmethod
    ADD CONSTRAINT "PK_ShipMethod_ShipMethodID" PRIMARY KEY (shipmethodid);

ALTER TABLE purchasing.shipmethod CLUSTER ON "PK_ShipMethod_ShipMethodID";


--
-- Name: vendor PK_Vendor_BusinessEntityID; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "PK_Vendor_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE purchasing.vendor CLUSTER ON "PK_Vendor_BusinessEntityID";


--
-- Name: countryregioncurrency PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.countryregioncurrency
    ADD CONSTRAINT "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode" PRIMARY KEY (countryregioncode, currencycode);

ALTER TABLE sales.countryregioncurrency CLUSTER ON "PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode";


--
-- Name: creditcard PK_CreditCard_CreditCardID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.creditcard
    ADD CONSTRAINT "PK_CreditCard_CreditCardID" PRIMARY KEY (creditcardid);

ALTER TABLE sales.creditcard CLUSTER ON "PK_CreditCard_CreditCardID";


--
-- Name: currencyrate PK_CurrencyRate_CurrencyRateID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currencyrate
    ADD CONSTRAINT "PK_CurrencyRate_CurrencyRateID" PRIMARY KEY (currencyrateid);

ALTER TABLE sales.currencyrate CLUSTER ON "PK_CurrencyRate_CurrencyRateID";


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
-- Name: personcreditcard PK_PersonCreditCard_BusinessEntityID_CreditCardID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.personcreditcard
    ADD CONSTRAINT "PK_PersonCreditCard_BusinessEntityID_CreditCardID" PRIMARY KEY (businessentityid, creditcardid);

ALTER TABLE sales.personcreditcard CLUSTER ON "PK_PersonCreditCard_BusinessEntityID_CreditCardID";


--
-- Name: salesorderdetail PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderdetail
    ADD CONSTRAINT "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID" PRIMARY KEY (salesorderid, salesorderdetailid);

ALTER TABLE sales.salesorderdetail CLUSTER ON "PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID";


--
-- Name: salesorderheadersalesreason PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheadersalesreason
    ADD CONSTRAINT "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID" PRIMARY KEY (salesorderid, salesreasonid);

ALTER TABLE sales.salesorderheadersalesreason CLUSTER ON "PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID";


--
-- Name: salesorderheader PK_SalesOrderHeader_SalesOrderID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "PK_SalesOrderHeader_SalesOrderID" PRIMARY KEY (salesorderid);

ALTER TABLE sales.salesorderheader CLUSTER ON "PK_SalesOrderHeader_SalesOrderID";


--
-- Name: salespersonquotahistory PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salespersonquotahistory
    ADD CONSTRAINT "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate" PRIMARY KEY (businessentityid, quotadate);

ALTER TABLE sales.salespersonquotahistory CLUSTER ON "PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate";


--
-- Name: salesperson PK_SalesPerson_BusinessEntityID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesperson
    ADD CONSTRAINT "PK_SalesPerson_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE sales.salesperson CLUSTER ON "PK_SalesPerson_BusinessEntityID";


--
-- Name: salesreason PK_SalesReason_SalesReasonID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesreason
    ADD CONSTRAINT "PK_SalesReason_SalesReasonID" PRIMARY KEY (salesreasonid);

ALTER TABLE sales.salesreason CLUSTER ON "PK_SalesReason_SalesReasonID";


--
-- Name: salestaxrate PK_SalesTaxRate_SalesTaxRateID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salestaxrate
    ADD CONSTRAINT "PK_SalesTaxRate_SalesTaxRateID" PRIMARY KEY (salestaxrateid);

ALTER TABLE sales.salestaxrate CLUSTER ON "PK_SalesTaxRate_SalesTaxRateID";


--
-- Name: salesterritoryhistory PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesterritoryhistory
    ADD CONSTRAINT "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID" PRIMARY KEY (businessentityid, startdate, territoryid);

ALTER TABLE sales.salesterritoryhistory CLUSTER ON "PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID";


--
-- Name: salesterritory PK_SalesTerritory_TerritoryID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesterritory
    ADD CONSTRAINT "PK_SalesTerritory_TerritoryID" PRIMARY KEY (territoryid);

ALTER TABLE sales.salesterritory CLUSTER ON "PK_SalesTerritory_TerritoryID";


--
-- Name: shoppingcartitem PK_ShoppingCartItem_ShoppingCartItemID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shoppingcartitem
    ADD CONSTRAINT "PK_ShoppingCartItem_ShoppingCartItemID" PRIMARY KEY (shoppingcartitemid);

ALTER TABLE sales.shoppingcartitem CLUSTER ON "PK_ShoppingCartItem_ShoppingCartItemID";


--
-- Name: specialofferproduct PK_SpecialOfferProduct_SpecialOfferID_ProductID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.specialofferproduct
    ADD CONSTRAINT "PK_SpecialOfferProduct_SpecialOfferID_ProductID" PRIMARY KEY (specialofferid, productid);

ALTER TABLE sales.specialofferproduct CLUSTER ON "PK_SpecialOfferProduct_SpecialOfferID_ProductID";


--
-- Name: specialoffer PK_SpecialOffer_SpecialOfferID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.specialoffer
    ADD CONSTRAINT "PK_SpecialOffer_SpecialOfferID" PRIMARY KEY (specialofferid);

ALTER TABLE sales.specialoffer CLUSTER ON "PK_SpecialOffer_SpecialOfferID";


--
-- Name: store PK_Store_BusinessEntityID; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "PK_Store_BusinessEntityID" PRIMARY KEY (businessentityid);

ALTER TABLE sales.store CLUSTER ON "PK_Store_BusinessEntityID";


--
-- Name: employeedepartmenthistory FK_EmployeeDepartmentHistory_Department_DepartmentID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employeedepartmenthistory
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Department_DepartmentID" FOREIGN KEY (departmentid) REFERENCES human_resources.department(departmentid);


--
-- Name: employeedepartmenthistory FK_EmployeeDepartmentHistory_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employeedepartmenthistory
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: employeedepartmenthistory FK_EmployeeDepartmentHistory_Shift_ShiftID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employeedepartmenthistory
    ADD CONSTRAINT "FK_EmployeeDepartmentHistory_Shift_ShiftID" FOREIGN KEY (shiftid) REFERENCES human_resources.shift(shiftid);


--
-- Name: employeepayhistory FK_EmployeePayHistory_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employeepayhistory
    ADD CONSTRAINT "FK_EmployeePayHistory_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: employee FK_Employee_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee
    ADD CONSTRAINT "FK_Employee_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: jobcandidate FK_JobCandidate_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.jobcandidate
    ADD CONSTRAINT "FK_JobCandidate_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: address FK_Address_StateProvince_StateProvinceID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.address
    ADD CONSTRAINT "FK_Address_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid) REFERENCES person.stateprovince(stateprovinceid);


--
-- Name: businessentityaddress FK_BusinessEntityAddress_AddressType_AddressTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "FK_BusinessEntityAddress_AddressType_AddressTypeID" FOREIGN KEY (addresstypeid) REFERENCES person.addresstype(addresstypeid);


--
-- Name: businessentityaddress FK_BusinessEntityAddress_Address_AddressID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "FK_BusinessEntityAddress_Address_AddressID" FOREIGN KEY (addressid) REFERENCES person.address(addressid);


--
-- Name: businessentityaddress FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentityaddress
    ADD CONSTRAINT "FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);


--
-- Name: businessentitycontact FK_BusinessEntityContact_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "FK_BusinessEntityContact_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);


--
-- Name: businessentitycontact FK_BusinessEntityContact_ContactType_ContactTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "FK_BusinessEntityContact_ContactType_ContactTypeID" FOREIGN KEY (contacttypeid) REFERENCES person.contacttype(contacttypeid);


--
-- Name: businessentitycontact FK_BusinessEntityContact_Person_PersonID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.businessentitycontact
    ADD CONSTRAINT "FK_BusinessEntityContact_Person_PersonID" FOREIGN KEY (personid) REFERENCES person.person(businessentityid);


--
-- Name: emailaddress FK_EmailAddress_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.emailaddress
    ADD CONSTRAINT "FK_EmailAddress_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: password FK_Password_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.password
    ADD CONSTRAINT "FK_Password_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: personphone FK_PersonPhone_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.personphone
    ADD CONSTRAINT "FK_PersonPhone_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: personphone FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.personphone
    ADD CONSTRAINT "FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID" FOREIGN KEY (phonenumbertypeid) REFERENCES person.phonenumbertype(phonenumbertypeid);


--
-- Name: person FK_Person_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.person
    ADD CONSTRAINT "FK_Person_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);


--
-- Name: stateprovince FK_StateProvince_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.stateprovince
    ADD CONSTRAINT "FK_StateProvince_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.countryregion(countryregioncode);


--
-- Name: stateprovince FK_StateProvince_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: person; Owner: postgres
--

ALTER TABLE ONLY person.stateprovince
    ADD CONSTRAINT "FK_StateProvince_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);


--
-- Name: billofmaterials FK_BillOfMaterials_Product_ComponentID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ComponentID" FOREIGN KEY (componentid) REFERENCES production.product(productid);


--
-- Name: billofmaterials FK_BillOfMaterials_Product_ProductAssemblyID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "FK_BillOfMaterials_Product_ProductAssemblyID" FOREIGN KEY (productassemblyid) REFERENCES production.product(productid);


--
-- Name: billofmaterials FK_BillOfMaterials_UnitMeasure_UnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.billofmaterials
    ADD CONSTRAINT "FK_BillOfMaterials_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);


--
-- Name: document FK_Document_Employee_Owner; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.document
    ADD CONSTRAINT "FK_Document_Employee_Owner" FOREIGN KEY (owner) REFERENCES human_resources.employee(businessentityid);


--
-- Name: productcosthistory FK_ProductCostHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productcosthistory
    ADD CONSTRAINT "FK_ProductCostHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: productdocument FK_ProductDocument_Document_DocumentNode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productdocument
    ADD CONSTRAINT "FK_ProductDocument_Document_DocumentNode" FOREIGN KEY (documentnode) REFERENCES production.document(documentnode);


--
-- Name: productdocument FK_ProductDocument_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productdocument
    ADD CONSTRAINT "FK_ProductDocument_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: productinventory FK_ProductInventory_Location_LocationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productinventory
    ADD CONSTRAINT "FK_ProductInventory_Location_LocationID" FOREIGN KEY (locationid) REFERENCES production.location(locationid);


--
-- Name: productinventory FK_ProductInventory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productinventory
    ADD CONSTRAINT "FK_ProductInventory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: productlistpricehistory FK_ProductListPriceHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productlistpricehistory
    ADD CONSTRAINT "FK_ProductListPriceHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: productmodelillustration FK_ProductModelIllustration_Illustration_IllustrationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelillustration
    ADD CONSTRAINT "FK_ProductModelIllustration_Illustration_IllustrationID" FOREIGN KEY (illustrationid) REFERENCES production.illustration(illustrationid);


--
-- Name: productmodelillustration FK_ProductModelIllustration_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelillustration
    ADD CONSTRAINT "FK_ProductModelIllustration_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);


--
-- Name: productmodelproductdescriptionculture FK_ProductModelProductDescriptionCulture_Culture_CultureID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_Culture_CultureID" FOREIGN KEY (cultureid) REFERENCES production.culture(cultureid);


--
-- Name: productmodelproductdescriptionculture FK_ProductModelProductDescriptionCulture_ProductDescription_Pro; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductDescription_Pro" FOREIGN KEY (productdescriptionid) REFERENCES production.productdescription(productdescriptionid);


--
-- Name: productmodelproductdescriptionculture FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productmodelproductdescriptionculture
    ADD CONSTRAINT "FK_ProductModelProductDescriptionCulture_ProductModel_ProductMo" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);


--
-- Name: productproductphoto FK_ProductProductPhoto_ProductPhoto_ProductPhotoID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productproductphoto
    ADD CONSTRAINT "FK_ProductProductPhoto_ProductPhoto_ProductPhotoID" FOREIGN KEY (productphotoid) REFERENCES production.productphoto(productphotoid);


--
-- Name: productproductphoto FK_ProductProductPhoto_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productproductphoto
    ADD CONSTRAINT "FK_ProductProductPhoto_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: productsubcategory FK_ProductSubcategory_ProductCategory_ProductCategoryID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.productsubcategory
    ADD CONSTRAINT "FK_ProductSubcategory_ProductCategory_ProductCategoryID" FOREIGN KEY (productcategoryid) REFERENCES production.productcategory(productcategoryid);


--
-- Name: product FK_Product_ProductModel_ProductModelID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductModel_ProductModelID" FOREIGN KEY (productmodelid) REFERENCES production.productmodel(productmodelid);


--
-- Name: product FK_Product_ProductSubcategory_ProductSubcategoryID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_ProductSubcategory_ProductSubcategoryID" FOREIGN KEY (productsubcategoryid) REFERENCES production.productsubcategory(productsubcategoryid);


--
-- Name: product FK_Product_UnitMeasure_SizeUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_SizeUnitMeasureCode" FOREIGN KEY (sizeunitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);


--
-- Name: product FK_Product_UnitMeasure_WeightUnitMeasureCode; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.product
    ADD CONSTRAINT "FK_Product_UnitMeasure_WeightUnitMeasureCode" FOREIGN KEY (weightunitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);


--
-- Name: transactionhistory FK_TransactionHistory_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.transactionhistory
    ADD CONSTRAINT "FK_TransactionHistory_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: workorderrouting FK_WorkOrderRouting_Location_LocationID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorderrouting
    ADD CONSTRAINT "FK_WorkOrderRouting_Location_LocationID" FOREIGN KEY (locationid) REFERENCES production.location(locationid);


--
-- Name: workorderrouting FK_WorkOrderRouting_WorkOrder_WorkOrderID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorderrouting
    ADD CONSTRAINT "FK_WorkOrderRouting_WorkOrder_WorkOrderID" FOREIGN KEY (workorderid) REFERENCES production.workorder(workorderid);


--
-- Name: workorder FK_WorkOrder_Product_ProductID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorder
    ADD CONSTRAINT "FK_WorkOrder_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: workorder FK_WorkOrder_ScrapReason_ScrapReasonID; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.workorder
    ADD CONSTRAINT "FK_WorkOrder_ScrapReason_ScrapReasonID" FOREIGN KEY (scrapreasonid) REFERENCES production.scrapreason(scrapreasonid);


--
-- Name: productvendor FK_ProductVendor_Product_ProductID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "FK_ProductVendor_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: productvendor FK_ProductVendor_UnitMeasure_UnitMeasureCode; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "FK_ProductVendor_UnitMeasure_UnitMeasureCode" FOREIGN KEY (unitmeasurecode) REFERENCES production.unitmeasure(unitmeasurecode);


--
-- Name: productvendor FK_ProductVendor_Vendor_BusinessEntityID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.productvendor
    ADD CONSTRAINT "FK_ProductVendor_Vendor_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES purchasing.vendor(businessentityid);


--
-- Name: purchaseorderdetail FK_PurchaseOrderDetail_Product_ProductID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderdetail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: purchaseorderdetail FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderdetail
    ADD CONSTRAINT "FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID" FOREIGN KEY (purchaseorderid) REFERENCES purchasing.purchaseorderheader(purchaseorderid);


--
-- Name: purchaseorderheader FK_PurchaseOrderHeader_Employee_EmployeeID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Employee_EmployeeID" FOREIGN KEY (employeeid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: purchaseorderheader FK_PurchaseOrderHeader_ShipMethod_ShipMethodID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "FK_PurchaseOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid) REFERENCES purchasing.shipmethod(shipmethodid);


--
-- Name: purchaseorderheader FK_PurchaseOrderHeader_Vendor_VendorID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchaseorderheader
    ADD CONSTRAINT "FK_PurchaseOrderHeader_Vendor_VendorID" FOREIGN KEY (vendorid) REFERENCES purchasing.vendor(businessentityid);


--
-- Name: vendor FK_Vendor_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT "FK_Vendor_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);


--
-- Name: countryregioncurrency FK_CountryRegionCurrency_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.countryregioncurrency
    ADD CONSTRAINT "FK_CountryRegionCurrency_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.countryregion(countryregioncode);


--
-- Name: countryregioncurrency FK_CountryRegionCurrency_Currency_CurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.countryregioncurrency
    ADD CONSTRAINT "FK_CountryRegionCurrency_Currency_CurrencyCode" FOREIGN KEY (currencycode) REFERENCES sales.currency(currencycode);


--
-- Name: currencyrate FK_CurrencyRate_Currency_FromCurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currencyrate
    ADD CONSTRAINT "FK_CurrencyRate_Currency_FromCurrencyCode" FOREIGN KEY (fromcurrencycode) REFERENCES sales.currency(currencycode);


--
-- Name: currencyrate FK_CurrencyRate_Currency_ToCurrencyCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.currencyrate
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
    ADD CONSTRAINT "FK_Customer_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);


--
-- Name: customer FK_Customer_Store_StoreID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customer
    ADD CONSTRAINT "FK_Customer_Store_StoreID" FOREIGN KEY (storeid) REFERENCES sales.store(businessentityid);


--
-- Name: personcreditcard FK_PersonCreditCard_CreditCard_CreditCardID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.personcreditcard
    ADD CONSTRAINT "FK_PersonCreditCard_CreditCard_CreditCardID" FOREIGN KEY (creditcardid) REFERENCES sales.creditcard(creditcardid);


--
-- Name: personcreditcard FK_PersonCreditCard_Person_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.personcreditcard
    ADD CONSTRAINT "FK_PersonCreditCard_Person_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.person(businessentityid);


--
-- Name: salesorderdetail FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderdetail
    ADD CONSTRAINT "FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid) REFERENCES sales.salesorderheader(salesorderid) ON DELETE CASCADE;


--
-- Name: salesorderdetail FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderdetail
    ADD CONSTRAINT "FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID" FOREIGN KEY (specialofferid, productid) REFERENCES sales.specialofferproduct(specialofferid, productid);


--
-- Name: salesorderheadersalesreason FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheadersalesreason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID" FOREIGN KEY (salesorderid) REFERENCES sales.salesorderheader(salesorderid) ON DELETE CASCADE;


--
-- Name: salesorderheadersalesreason FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheadersalesreason
    ADD CONSTRAINT "FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID" FOREIGN KEY (salesreasonid) REFERENCES sales.salesreason(salesreasonid);


--
-- Name: salesorderheader FK_SalesOrderHeader_Address_BillToAddressID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_BillToAddressID" FOREIGN KEY (billtoaddressid) REFERENCES person.address(addressid);


--
-- Name: salesorderheader FK_SalesOrderHeader_Address_ShipToAddressID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_Address_ShipToAddressID" FOREIGN KEY (shiptoaddressid) REFERENCES person.address(addressid);


--
-- Name: salesorderheader FK_SalesOrderHeader_CreditCard_CreditCardID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_CreditCard_CreditCardID" FOREIGN KEY (creditcardid) REFERENCES sales.creditcard(creditcardid);


--
-- Name: salesorderheader FK_SalesOrderHeader_CurrencyRate_CurrencyRateID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_CurrencyRate_CurrencyRateID" FOREIGN KEY (currencyrateid) REFERENCES sales.currencyrate(currencyrateid);


--
-- Name: salesorderheader FK_SalesOrderHeader_Customer_CustomerID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_Customer_CustomerID" FOREIGN KEY (customerid) REFERENCES sales.customer(customerid);


--
-- Name: salesorderheader FK_SalesOrderHeader_SalesPerson_SalesPersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid) REFERENCES sales.salesperson(businessentityid);


--
-- Name: salesorderheader FK_SalesOrderHeader_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);


--
-- Name: salesorderheader FK_SalesOrderHeader_ShipMethod_ShipMethodID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesorderheader
    ADD CONSTRAINT "FK_SalesOrderHeader_ShipMethod_ShipMethodID" FOREIGN KEY (shipmethodid) REFERENCES purchasing.shipmethod(shipmethodid);


--
-- Name: salespersonquotahistory FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salespersonquotahistory
    ADD CONSTRAINT "FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES sales.salesperson(businessentityid);


--
-- Name: salesperson FK_SalesPerson_Employee_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesperson
    ADD CONSTRAINT "FK_SalesPerson_Employee_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES human_resources.employee(businessentityid);


--
-- Name: salesperson FK_SalesPerson_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesperson
    ADD CONSTRAINT "FK_SalesPerson_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);


--
-- Name: salestaxrate FK_SalesTaxRate_StateProvince_StateProvinceID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salestaxrate
    ADD CONSTRAINT "FK_SalesTaxRate_StateProvince_StateProvinceID" FOREIGN KEY (stateprovinceid) REFERENCES person.stateprovince(stateprovinceid);


--
-- Name: salesterritoryhistory FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesterritoryhistory
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES sales.salesperson(businessentityid);


--
-- Name: salesterritoryhistory FK_SalesTerritoryHistory_SalesTerritory_TerritoryID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesterritoryhistory
    ADD CONSTRAINT "FK_SalesTerritoryHistory_SalesTerritory_TerritoryID" FOREIGN KEY (territoryid) REFERENCES sales.salesterritory(territoryid);


--
-- Name: salesterritory FK_SalesTerritory_CountryRegion_CountryRegionCode; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.salesterritory
    ADD CONSTRAINT "FK_SalesTerritory_CountryRegion_CountryRegionCode" FOREIGN KEY (countryregioncode) REFERENCES person.countryregion(countryregioncode);


--
-- Name: shoppingcartitem FK_ShoppingCartItem_Product_ProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.shoppingcartitem
    ADD CONSTRAINT "FK_ShoppingCartItem_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: specialofferproduct FK_SpecialOfferProduct_Product_ProductID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.specialofferproduct
    ADD CONSTRAINT "FK_SpecialOfferProduct_Product_ProductID" FOREIGN KEY (productid) REFERENCES production.product(productid);


--
-- Name: specialofferproduct FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.specialofferproduct
    ADD CONSTRAINT "FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID" FOREIGN KEY (specialofferid) REFERENCES sales.specialoffer(specialofferid);


--
-- Name: store FK_Store_BusinessEntity_BusinessEntityID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_BusinessEntity_BusinessEntityID" FOREIGN KEY (businessentityid) REFERENCES person.businessentity(businessentityid);


--
-- Name: store FK_Store_SalesPerson_SalesPersonID; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.store
    ADD CONSTRAINT "FK_Store_SalesPerson_SalesPersonID" FOREIGN KEY (salespersonid) REFERENCES sales.salesperson(businessentityid);


--
-- PostgreSQL database dump complete
--

