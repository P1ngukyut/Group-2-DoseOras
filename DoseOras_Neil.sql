create database DoseOras;

create table Users (
	user_id int auto_increment primary key,
	first_name varchar(100),
	last_name varchar(100),
	email varchar(150),
	password_hash varchar(255),
	phone varchar(20),
	role enum('admin', 'user', 'caregiver') not null default 'user'
);

create table Medicines(
	medicine_id int auto_increment primary key,
	name varchar(100) not null,
	quantity int not null,
	dosage_amount decimal(5,2) not null
);

create table User_medicines (
	user_id int not null,
	medicine_id int not null,
	primary key(user_id, medicine_id),
	foreign key (user_id) references Users(user_id),
	foreign key (medicine_id) references Medicines(medicine_id)
);

create table Devices (
	device_id int auto_increment primary key,
	user_id int not null,
	device_name varchar(100) not null,
	device_uid varchar(100) unique not null,
	ip_address varchar(45),
	status enum('Connected', 'Disconnected'),   
	foreign key (user_id) references Users(user_id)
);

create table Schedules (
	schedule_id int auto_increment primary key,
	user_id int not null,
	medicine_id int not null,
	dosage_time time not null,
	frequency int not null,
	wait_time time,
	start_date date not null,
	end_date date,
	foreign key (user_id) references Users(user_id),
	foreign key (medicine_id) references Medicines(medicine_id)
);

create table Alarms (
	alarm_id int auto_increment primary key,
	schedule_id int not null,
	user_id int not null,
	device_id int not null,
	alarm_type enum('reminder', 'missed', 'snooze') not null,
	message varchar(255),
	warning_message varchar(255), 
	foreign key (schedule_id) references Schedules(schedule_id),
	foreign key (user_id) references Users(user_id),
	foreign key (device_id) references Devices(device_id)
);

create table Logs (
	log_in int auto_increment primary key,
	schedule_id int,
	user_id int,
	medicine_id int,
	alarm_id int,
	performed_by int,
	action_type enum('INSERT', 'UPDATE', 'DELETE') not null,
	time_stamp datetime default CURRENT_TIMESTAMP(),
	old_value TEXT,
	new_value TEXT,
	foreign key (schedule_id) references Schedules(schedule_id),
	foreign key (user_id) references Users(user_id),
	foreign key (medicine_id) references Medicines(medicine_id),
	foreign key (alarm_id) references Alarms(alarm_id),
	foreign key (performed_by) references Users(user_id)
);

