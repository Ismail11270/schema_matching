create table addresses (
	id integer primary key auto_increment,
    post_code varchar(10) not null,
    country varchar(20) not null,
    city varchar(20) not null,
    street varchar(30),
    house_number integer,
    flat_number integer );
    
    
create table students
( ID INTEGER PRIMARY KEY AUTO_INCREMENT,
  FIRST_NAME VARCHAR(20) NOT NULL,
  LAST_NAME VARCHAR(20) NOT NULL,
  BIRTHDAY DATE NOT NULL,
  ADDRESS_ID INTEGER,
  FOREIGN KEY (ADDRESS_ID) REFERENCES addresses(id)
  );
  