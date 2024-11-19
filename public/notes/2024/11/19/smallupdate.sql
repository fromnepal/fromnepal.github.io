now can you also update these rows you just added? 

Certainly! Here are some sample `UPDATE` statements for the rows we just inserted:

```sql
-- Update contacts
update contacts
set name = 'Johnathan Doe', modified_by = 'admin', modified_at = current_timestamp
where name = 'John Doe';

update contacts
set name = 'Acme Corp', modified_by = 'admin', modified_at = current_timestamp
where name = 'Acme Corporation';

-- Update phone_numbers
update phone_numbers
set number = '1112223333', modified_by = 'admin', modified_at = current_timestamp
where number = '1234567890';

update phone_numbers
set number = '9998887777', modified_by = 'admin', modified_at = current_timestamp
where number = '0987654321';

-- Update addresses
update addresses
set address_line1 = '789 New St', city = 'San Francisco', state = 'CA', modified_by = 'admin', modified_at = current_timestamp
where address_line1 = '123 Main St';

update addresses
set address_line1 = '101 Business Rd', city = 'San Diego', state = 'CA', modified_by = 'admin', modified_at = current_timestamp
where address_line1 = '456 Corporate Blvd';

-- Update email_addresses
update email_addresses
set email = 'john.doe@newdomain.com', modified_by = 'admin', modified_at = current_timestamp
where email = 'john.doe@example.com';

update email_addresses
set email = 'info@acme.com', modified_by = 'admin', modified_at = current_timestamp
where email = 'contact@acme.com';

-- Update social_media_links
update social_media_links
set url = 'https://linkedin.com/in/johnathandoe', modified_by = 'admin', modified_at = current_timestamp
where url = 'https://linkedin.com/in/johndoe';

update social_media_links
set url = 'https://twitter.com/acmecorp', modified_by = 'admin', modified_at = current_timestamp
where url = 'https://twitter.com/acme';
```

These updates modify the previously inserted rows with new values and set the `modified_by` and `modified_at` fields to reflect the changes. Let me know if you need any further modifications!