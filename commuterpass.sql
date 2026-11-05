CREATE DATABASE IF NOT EXISTS commuterpass CHARACTER SET 2 COLLATE

USE commuterpass;

CREATE TABLE IF NOT EXISTS student_accounts (
    id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    school VARCHAR(190) NOT NULL,
    school_student_number VARCHAR(50) NULL,
    school_year VARCHAR(9) NOT NULL DEFAULT '',
    semester VARCHAR(10) NOT NULL DEFAULT '',
    password VARCHAR(255) NOT NULL,
    eligible TINYINT(1) NOT NULL DEFAULT 1,
    expires_at DATE NOT NULL,
    failed_scan_day DATE NULL,
    failed_scan_attempts TINYINT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_student_school_number (school, school_student_number)
);

CREATE TABLE IF NOT EXISTS transactions (
    id VARCHAR(40) PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL DEFAULT '',
    student_name VARCHAR(150) NOT NULL,
    passenger_type VARCHAR(30) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    regular_fare DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(10, 2) NOT NULL,
    paid_fare DECIMAL(10, 2) NOT NULL,
    created_at DATETIME NOT NULL,
    INDEX idx_transactions_created_at (created_at)
);

CREATE TABLE IF NOT EXISTS fare_matrix (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fare_month CHAR(7) NOT NULL,
    origin VARCHAR(150) NOT NULL,
    destination VARCHAR(150) NOT NULL,
    route_key VARCHAR(255) NOT NULL,
    distance_km DECIMAL(8, 2) NOT NULL,
    fare DECIMAL(10, 2) NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_fare_matrix_route_month (fare_month, route_key),
    INDEX idx_fare_matrix_month (fare_month)
);

CREATE TABLE IF NOT EXISTS operator_vehicle (
    id TINYINT UNSIGNED PRIMARY KEY,
    operator_name VARCHAR(150) NOT NULL,
    driver_name VARCHAR(150) NOT NULL,
    driver_license_number VARCHAR(60) NOT NULL,
    driver_license_expiry DATE NOT NULL,
    vehicle_make VARCHAR(80) NOT NULL,
    vehicle_model VARCHAR(80) NOT NULL,
    vehicle_plate VARCHAR(20) NOT NULL,
    franchise_number VARCHAR(80) NOT NULL,
    franchise_expiry DATE NOT NULL,
    or_number VARCHAR(80) NOT NULL,
    cr_number VARCHAR(80) NOT NULL,
    verification_status VARCHAR(20) NOT NULL DEFAULT 'pending',
    review_note VARCHAR(500) NOT NULL DEFAULT '',
    submitted_at DATETIME NOT NULL,
    reviewed_at DATETIME NULL
);