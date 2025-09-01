# Data Dictionary

This document provides a comprehensive overview of all entities, fields, and their definitions in the Dataverse solution.

## Standard Entities

### Account
**Purpose**: Represents companies, organizations, or other business entities.

| Field Name | Type | Description | Required | Business Rules |
|------------|------|-------------|----------|----------------|
| accountid | GUID | Unique identifier | Yes | Auto-generated |
| name | Single Line of Text | Company/organization name | Yes | Max 160 characters |
| accountnumber | Single Line of Text | Account number for reference | No | Max 20 characters |
| telephone1 | Single Line of Text | Primary phone number | No | Phone format validation |
| emailaddress1 | Single Line of Text | Primary email address | No | Email format validation |
| address1_city | Single Line of Text | City in address | No | Max 80 characters |
| address1_country | Single Line of Text | Country in address | No | Max 80 characters |
| createdon | DateTime | Record creation date | Yes | Auto-generated |
| modifiedon | DateTime | Last modification date | Yes | Auto-generated |
| statecode | Option Set | Record state (Active/Inactive) | Yes | Default: Active |
| statuscode | Option Set | Record status | Yes | Default: Active |

### Contact
**Purpose**: Represents individuals associated with accounts or standalone contacts.

| Field Name | Type | Description | Required | Business Rules |
|------------|------|-------------|----------|----------------|
| contactid | GUID | Unique identifier | Yes | Auto-generated |
| parentcustomerid | Lookup | Associated account | No | References account.accountid |
| firstname | Single Line of Text | First name | No | Max 50 characters |
| lastname | Single Line of Text | Last name | Yes | Max 50 characters |
| emailaddress1 | Single Line of Text | Primary email address | No | Email format validation |
| telephone1 | Single Line of Text | Primary phone number | No | Phone format validation |
| jobtitle | Single Line of Text | Job title/position | No | Max 100 characters |
| createdon | DateTime | Record creation date | Yes | Auto-generated |
| modifiedon | DateTime | Last modification date | Yes | Auto-generated |
| statecode | Option Set | Record state (Active/Inactive) | Yes | Default: Active |
| statuscode | Option Set | Record status | Yes | Default: Active |

### Opportunity
**Purpose**: Represents potential sales opportunities.

| Field Name | Type | Description | Required | Business Rules |
|------------|------|-------------|----------|----------------|
| opportunityid | GUID | Unique identifier | Yes | Auto-generated |
| parentaccountid | Lookup | Associated account | No | References account.accountid |
| parentcontactid | Lookup | Associated contact | No | References contact.contactid |
| name | Single Line of Text | Opportunity name | Yes | Max 300 characters |
| estimatedvalue | Currency | Estimated deal value | No | Positive values only |
| estimatedclosedate | DateTime | Expected close date | No | Future date validation |
| actualvalue | Currency | Actual deal value | No | Positive values only |
| actualclosedate | DateTime | Actual close date | No | Date validation |
| stepname | Single Line of Text | Current sales stage | No | Max 100 characters |
| createdon | DateTime | Record creation date | Yes | Auto-generated |
| modifiedon | DateTime | Last modification date | Yes | Auto-generated |
| statecode | Option Set | Record state (Open/Won/Lost) | Yes | Default: Open |
| statuscode | Option Set | Record status | Yes | Default: Open |

### Lead
**Purpose**: Represents potential customers or sales leads.

| Field Name | Type | Description | Required | Business Rules |
|------------|------|-------------|----------|----------------|
| leadid | GUID | Unique identifier | Yes | Auto-generated |
| parentaccountid | Lookup | Associated account | No | References account.accountid |
| parentcontactid | Lookup | Associated contact | No | References contact.contactid |
| firstname | Single Line of Text | First name | No | Max 50 characters |
| lastname | Single Line of Text | Last name | Yes | Max 50 characters |
| companyname | Single Line of Text | Company name | No | Max 160 characters |
| emailaddress1 | Single Line of Text | Primary email address | No | Email format validation |
| telephone1 | Single Line of Text | Primary phone number | No | Phone format validation |
| subject | Single Line of Text | Lead subject/topic | Yes | Max 300 characters |
| createdon | DateTime | Record creation date | Yes | Auto-generated |
| modifiedon | DateTime | Last modification date | Yes | Auto-generated |
| statecode | Option Set | Record state (Open/Qualified/Disqualified) | Yes | Default: Open |
| statuscode | Option Set | Record status | Yes | Default: New |

## Custom Entities

### Custom Entity
**Purpose**: Template for custom entity development.

| Field Name | Type | Description | Required | Business Rules |
|------------|------|-------------|----------|----------------|
| custom_entityid | GUID | Unique identifier | Yes | Auto-generated |
| name | Single Line of Text | Entity name | Yes | Max 100 characters |
| description | Multiple Lines of Text | Entity description | No | Max 2000 characters |
| createdon | DateTime | Record creation date | Yes | Auto-generated |
| modifiedon | DateTime | Last modification date | Yes | Auto-generated |
| statecode | Option Set | Record state (Active/Inactive) | Yes | Default: Active |
| statuscode | Option Set | Record status | Yes | Default: Active |

## Option Sets

### Account Status
- Active (1)
- Inactive (2)

### Contact Status
- Active (1)
- Inactive (2)

### Opportunity Status
- Open (0)
- Won (1)
- Lost (2)

### Lead Status
- New (1)
- Contacted (2)
- Qualified (3)
- Disqualified (4)

## Business Rules

1. **Email Validation**: All email fields must follow standard email format
2. **Phone Validation**: Phone numbers should include country code when applicable
3. **Date Validation**: Close dates cannot be in the past for open opportunities
4. **Currency Validation**: All currency values must be positive
5. **Required Fields**: Name fields are required for all entities
6. **State Management**: Records cannot be deleted, only deactivated

## Data Retention

- **Active Records**: Kept indefinitely
- **Inactive Records**: Archived after 7 years
- **Audit Logs**: Maintained for 10 years
- **Deleted Records**: Soft delete with 30-day recovery window
