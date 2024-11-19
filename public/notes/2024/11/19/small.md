#### Contacts Table
#### Phone Numbers Table
#### Addresses Table
#### Email Addresses Table
#### Social Media Links Table

#### Example: Phone Numbers History Table



### Contacts Table
### Phone Numbers Table
### Addresses Table
### Email Addresses Table
### Social Media Links Table

#### Phone Numbers History Table
### Addresses History Table
### Email Addresses History Table
### Social Media Links History Table










### Contacts Table
```sql
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('person', 'company')) NOT NULL,
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP
);
```

### Phone Numbers Table
```sql
CREATE TABLE phone_numbers (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    country_code VARCHAR(5),
    number VARCHAR(20) NOT NULL,
    label VARCHAR(50),
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP
);
```

### Addresses Table
```sql
CREATE TABLE addresses (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100) NOT NULL,
    label VARCHAR(50),
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP
);
```

### Email Addresses Table
```sql
CREATE TABLE email_addresses (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL,
    label VARCHAR(50),
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP
);
```

### Social Media Links Table
```sql
CREATE TABLE social_media_links (
    id SERIAL PRIMARY KEY,
    uuid UUID DEFAULT gen_random_uuid() NOT NULL,
    contact_id INTEGER REFERENCES contacts(id) ON DELETE CASCADE,
    platform VARCHAR(50) NOT NULL,
    url VARCHAR(255) NOT NULL,
    label VARCHAR(50),
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP
);
```

### History Tables for Auditing Changes

#### Phone Numbers History Table
```sql
CREATE TABLE phone_numbers_history (
    id SERIAL PRIMARY KEY,
    phone_number_id INTEGER NOT NULL,
    uuid UUID NOT NULL,
    contact_id INTEGER,
    country_code VARCHAR(5),
    number VARCHAR(20),
    label VARCHAR(50),
    created_by VARCHAR(255),
    created_at TIMESTAMP,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION log_phone_number_changes() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO phone_numbers_history (phone_number_id, uuid, contact_id, country_code, number, label, created_by, created_at, modified_by, modified_at)
        VALUES (OLD.id, OLD.uuid, OLD.contact_id, OLD.country_code, OLD.number, OLD.label, OLD.created_by, OLD.created_at, OLD.modified_by, OLD.modified_at);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER phone_number_changes
AFTER UPDATE ON phone_numbers
FOR EACH ROW EXECUTE FUNCTION log_phone_number_changes();
```

### Addresses History Table
```sql
CREATE TABLE addresses_history (
    id SERIAL PRIMARY KEY,
    address_id INTEGER NOT NULL,
    uuid UUID NOT NULL,
    contact_id INTEGER,
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    label VARCHAR(50),
    created_by VARCHAR(255),
    created_at TIMESTAMP,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION log_address_changes() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO addresses_history (address_id, uuid, contact_id, address_line1, address_line2, city, state, postal_code, country, label, created_by, created_at, modified_by, modified_at)
        VALUES (OLD.id, OLD.uuid, OLD.contact_id, OLD.address_line1, OLD.address_line2, OLD.city, OLD.state, OLD.postal_code, OLD.country, OLD.label, OLD.created_by, OLD.created_at, OLD.modified_by, OLD.modified_at);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER address_changes
AFTER UPDATE ON addresses
FOR EACH ROW EXECUTE FUNCTION log_address_changes();
```

### Email Addresses History Table
```sql
CREATE TABLE email_addresses_history (
    id SERIAL PRIMARY KEY,
    email_address_id INTEGER NOT NULL,
    uuid UUID NOT NULL,
    contact_id INTEGER,
    email VARCHAR(255),
    label VARCHAR(50),
    created_by VARCHAR(255),
    created_at TIMESTAMP,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION log_email_address_changes() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO email_addresses_history (email_address_id, uuid, contact_id, email, label, created_by, created_at, modified_by, modified_at)
        VALUES (OLD.id, OLD.uuid, OLD.contact_id, OLD.email, OLD.label, OLD.created_by, OLD.created_at, OLD.modified_by, OLD.modified_at);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER email_address_changes
AFTER UPDATE ON email_addresses
FOR EACH ROW EXECUTE FUNCTION log_email_address_changes();
```

### Social Media Links History Table
```sql
CREATE TABLE social_media_links_history (
    id SERIAL PRIMARY KEY,
    social_media_link_id INTEGER NOT NULL,
    uuid UUID NOT NULL,
    contact_id INTEGER,
    platform VARCHAR(50),
    url VARCHAR(255),
    label VARCHAR(50),
    created_by VARCHAR(255),
    created_at TIMESTAMP,
    modified_by VARCHAR(255),
    modified_at TIMESTAMP,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION log_social_media_link_changes() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO social_media_links_history (social_media_link_id, uuid, contact_id, platform, url, label, created_by, created_at, modified_by, modified_at)
        VALUES (OLD.id, OLD.uuid, OLD.contact_id, OLD.platform, OLD.url, OLD.label, OLD.created_by, OLD.created_at, OLD.modified_by, OLD.modified_at);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER social_media_link_changes
AFTER UPDATE ON social_media_links
FOR EACH ROW EXECUTE FUNCTION log_social_media_link_changes();
```