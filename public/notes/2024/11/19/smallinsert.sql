-- can you generate some insert scripts as a sample for all the tables except the history tables? 

-- Sure! Here are some sample `INSERT` scripts for all the tables except the history tables:

-- ```sql
-- Insert into contacts
insert into contacts (uuid, name, type, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 'John Doe', 'person', 'admin', current_timestamp, null, null);

insert into contacts (uuid, name, type, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 'Acme Corporation', 'company', 'admin', current_timestamp, null, null);

-- Insert into phone_numbers
insert into phone_numbers (uuid, contact_id, country_code, number, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 1, '+1', '1234567890', 'work', 'admin', current_timestamp, null, null);

insert into phone_numbers (uuid, contact_id, country_code, number, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 2, '+1', '0987654321', 'support', 'admin', current_timestamp, null, null);

-- Insert into addresses
insert into addresses (uuid, contact_id, address_line1, address_line2, city, state, postal_code, country, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 1, '123 Main St', 'Apt 4B', 'New York', 'NY', '10001', 'USA', 'home', 'admin', current_timestamp, null, null);

insert into addresses (uuid, contact_id, address_line1, address_line2, city, state, postal_code, country, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 2, '456 Corporate Blvd', null, 'Los Angeles', 'CA', '90001', 'USA', 'office', 'admin', current_timestamp, null, null);

-- Insert into email_addresses
insert into email_addresses (uuid, contact_id, email, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 1, 'john.doe@example.com', 'personal', 'admin', current_timestamp, null, null);

insert into email_addresses (uuid, contact_id, email, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 2, 'contact@acme.com', 'business', 'admin', current_timestamp, null, null);

-- Insert into social_media_links
insert into social_media_links (uuid, contact_id, platform, url, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 1, 'LinkedIn', 'https://linkedin.com/in/johndoe', 'professional', 'admin', current_timestamp, null, null);

insert into social_media_links (uuid, contact_id, platform, url, label, created_by, created_at, modified_by, modified_at)
values (gen_random_uuid(), 2, 'Twitter', 'https://twitter.com/acme', 'official', 'admin', current_timestamp, null, null);
```

-- These scripts should give you a good starting point. Let me know if you need any further assistance!