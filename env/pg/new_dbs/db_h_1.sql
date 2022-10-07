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


CREATE TABLE medicines
(
    medicine_id INT NOT NULL,
    drug_name VARCHAR NOT NULL,
    expire_date DATE NOT NULL,
    PRIMARY KEY (medicine_id)
);

CREATE TABLE prescriptions
(
    prescription_id INT NOT NULL,
    details_report VARCHAR NOT NULL,
    medicine_id INT NOT NULL,
    PRIMARY KEY (prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

CREATE TABLE addresses
(
    address_id INT NOT NULL,
    house_numebr VARCHAR NOT NULL,
    building_name VARCHAR NOT NULL,
    street_name VARCHAR NOT NULL,
    zipcode INT NOT NULL,
    city VARCHAR NOT NULL,
    province VARCHAR NOT NULL,
    country VARCHAR NOT NULL,
    PRIMARY KEY (address_id)
);

CREATE TABLE doctors
(
    doctor_id INT NOT NULL,
    first_name VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    identification_numebr INT NOT NULL,
    address_id INT NOT NULL,
    PRIMARY KEY (doctor_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE departments
(
    department_id INT NOT NULL,
    department_name VARCHAR NOT NULL,
    doctor_id INT NOT NULL,
    address_id INT NOT NULL,
    PRIMARY KEY (department_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE patient_history
(
    history_id INT NOT NULL,
    visit_id INT NOT NULL,
    PRIMARY KEY (history_id),
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);

CREATE TABLE patients
(
    patient_id INT NOT NULL,
    first_name VARCHAR NOT NULL,
    identification_number INT NOT NULL,
    last_name VARCHAR NOT NULL,
    address_id INT NOT NULL,
    history_id INT NOT NULL,
    PRIMARY KEY (patient_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (history_id) REFERENCES patient_history(history_id)
);

CREATE TABLE visits
(
    visit_id INT NOT NULL,
    type_of_visit CHAR NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    prescription_id INT NOT NULL,
    department_id INT NOT NULL,
    appointment_id INT NOT NULL,
    PRIMARY KEY (visit_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    UNIQUE (appointment_id)
);

CREATE TABLE appointments
(
    appointment_id INT NOT NULL,
    date DATE NOT NULL,
    visit_id INT NOT NULL,
    PRIMARY KEY (appointment_id),
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
    UNIQUE (visit_id)
);