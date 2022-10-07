
CREATE TABLE medicines
(
    medicine_id INT NOT NULL,
    drug_name VARCHAR(255) NOT NULL,
    expire_date DATE NOT NULL,
    PRIMARY KEY (medicine_id)
);

CREATE TABLE prescriptions
(
    prescription_id INT NOT NULL,
    details_report VARCHAR(255) NOT NULL,
    medicine_id INT NOT NULL,
    PRIMARY KEY (prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

CREATE TABLE addresses
(
    address_id INT NOT NULL,
    house_numebr VARCHAR(255) NOT NULL,
    building_name VARCHAR(255) NOT NULL,
    street_name VARCHAR(255) NOT NULL,
    zipcode INT NOT NULL,
    city VARCHAR(255) NOT NULL,
    province VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    PRIMARY KEY (address_id)
);

CREATE TABLE doctors
(
    doctor_id INT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    identification_numebr INT NOT NULL,
    address_id INT NOT NULL,
    PRIMARY KEY (doctor_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE departments
(
    department_id INT NOT NULL,
    department_name VARCHAR(255) NOT NULL,
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
    PRIMARY KEY (history_id)
    --  FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);

CREATE TABLE patients
(
    patient_id INT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    identification_number INT NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    address_id INT NOT NULL,
    history_id INT NOT NULL,
    PRIMARY KEY (patient_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (history_id) REFERENCES patient_history(history_id)
);
CREATE TABLE appointments
(
    appointment_id INT NOT NULL,
    date DATE NOT NULL,
    visit_id INT NOT NULL,
    PRIMARY KEY (appointment_id),
    --   FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
    UNIQUE (visit_id)
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

ALTER TABLE appointments ADD CONSTRAINT fk_appointments_visit_id FOREIGN KEY (visit_id) REFERENCES visits(visit_id);
ALTER TABLE patient_history ADD CONSTRAINT fk_history_visit_id FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
