# Entity Relationships

This document defines all relationships between entities in the Dataverse solution, including their types, cardinality, and business rules.

## Standard Entity Relationships

### Account ↔ Contact
**Type**: One-to-Many (1:N)  
**Parent Entity**: Account  
**Child Entity**: Contact  
**Relationship Name**: `account_primary_contact`  
**Lookup Field**: `parentcustomerid` on Contact  
**Description**: Links contacts to their primary account/organization

**Business Rules**:
- A contact can be associated with only one primary account
- An account can have multiple contacts
- When an account is deactivated, all associated contacts remain active
- Contact can exist without an account (standalone contact)

**Cascade Behavior**:
- **Assign**: Cascade
- **Delete**: Restrict
- **Merge**: Cascade
- **Reparent**: Cascade
- **Share**: Cascade
- **Unshare**: Cascade

### Account ↔ Opportunity
**Type**: One-to-Many (1:N)  
**Parent Entity**: Account  
**Child Entity**: Opportunity  
**Relationship Name**: `account_opportunities`  
**Lookup Field**: `parentaccountid` on Opportunity  
**Description**: Links opportunities to their associated account

**Business Rules**:
- An opportunity must be associated with an account
- An account can have multiple opportunities
- When an account is deactivated, opportunities remain active
- Opportunity value contributes to account revenue calculations

**Cascade Behavior**:
- **Assign**: Cascade
- **Delete**: Restrict
- **Merge**: Cascade
- **Reparent**: Cascade
- **Share**: Cascade
- **Unshare**: Cascade

### Contact ↔ Opportunity
**Type**: One-to-Many (1:N)  
**Parent Entity**: Contact  
**Child Entity**: Opportunity  
**Relationship Name**: `contact_opportunities`  
**Lookup Field**: `parentcontactid` on Opportunity  
**Description**: Links opportunities to their primary contact

**Business Rules**:
- An opportunity can be associated with one primary contact
- A contact can be associated with multiple opportunities
- Contact must be active for new opportunity associations
- Contact role in opportunity is tracked separately

**Cascade Behavior**:
- **Assign**: Cascade
- **Delete**: Restrict
- **Merge**: Cascade
- **Reparent**: Cascade
- **Share**: Cascade
- **Unshare**: Cascade

### Account ↔ Lead
**Type**: One-to-Many (1:N)  
**Parent Entity**: Account  
**Child Entity**: Lead  
**Relationship Name**: `account_leads`  
**Lookup Field**: `parentaccountid` on Lead  
**Description**: Links leads to their associated account

**Business Rules**:
- A lead can be associated with an account (optional)
- An account can have multiple leads
- Lead qualification process may create new accounts
- Lead conversion creates account and contact records

**Cascade Behavior**:
- **Assign**: Cascade
- **Delete**: Restrict
- **Merge**: Cascade
- **Reparent**: Cascade
- **Share**: Cascade
- **Unshare**: Cascade

### Contact ↔ Lead
**Type**: One-to-Many (1:N)  
**Parent Entity**: Contact  
**Child Entity**: Lead  
**Relationship Name**: `contact_leads`  
**Lookup Field**: `parentcontactid` on Lead  
**Description**: Links leads to their associated contact

**Business Rules**:
- A lead can be associated with a contact (optional)
- A contact can be associated with multiple leads
- Lead conversion may create new contact records
- Contact information helps qualify leads

**Cascade Behavior**:
- **Assign**: Cascade
- **Delete**: Restrict
- **Merge**: Cascade
- **Reparent**: Cascade
- **Share**: Cascade
- **Unshare**: Cascade

## Custom Entity Relationships

### Custom Entity ↔ Account
**Type**: Many-to-One (N:1)  
**Parent Entity**: Account  
**Child Entity**: Custom Entity  
**Relationship Name**: `account_custom_entities`  
**Lookup Field**: `new_accountid` on Custom Entity  
**Description**: Links custom entities to accounts

**Business Rules**:
- Custom entities can be associated with accounts
- Account association is optional
- Custom entity lifecycle follows account status

**Cascade Behavior**:
- **Assign**: Cascade
- **Delete**: Restrict
- **Merge**: Cascade
- **Reparent**: Cascade
- **Share**: Cascade
- **Unshare**: Cascade

## Many-to-Many Relationships

### Account ↔ Account (Subsidiary)
**Type**: Many-to-Many (N:N)  
**Entities**: Account ↔ Account  
**Relationship Name**: `account_sub_accounts`  
**Intersect Entity**: `account_sub_accounts`  
**Description**: Links parent accounts to subsidiary accounts

**Business Rules**:
- An account can have multiple subsidiaries
- An account can be a subsidiary of multiple parent accounts
- Hierarchical relationship supports organizational structure
- Revenue rollup calculations consider subsidiary relationships

### Contact ↔ Contact (Team)
**Type**: Many-to-Many (N:N)  
**Entities**: Contact ↔ Contact  
**Relationship Name**: `contact_team_contacts`  
**Intersect Entity**: `contact_team_contacts`  
**Description**: Links team members to their teams

**Business Rules**:
- Contacts can be part of multiple teams
- Teams can have multiple members
- Team relationships support collaboration features
- Team membership affects sharing and permissions

## Self-Referencing Relationships

### Account Hierarchy
**Type**: Self-Referencing (N:1)  
**Entity**: Account  
**Relationship Name**: `account_parent_account`  
**Lookup Field**: `parentaccountid` on Account  
**Description**: Hierarchical relationship within accounts

**Business Rules**:
- Accounts can have parent accounts
- Prevents circular references
- Supports organizational hierarchy
- Enables rollup calculations

### Contact Hierarchy
**Type**: Self-Referencing (N:1)  
**Entity**: Contact  
**Relationship Name**: `contact_parent_contact`  
**Lookup Field**: `parentcontactid` on Contact  
**Description**: Hierarchical relationship within contacts

**Business Rules**:
- Contacts can have parent contacts
- Supports organizational reporting structures
- Prevents circular references
- Enables team management

## Relationship Guidelines

### Naming Conventions
1. **Primary Relationships**: Use descriptive names (e.g., `account_opportunities`)
2. **Lookup Fields**: Use entity name + "id" suffix (e.g., `accountid`)
3. **Custom Relationships**: Use prefix + descriptive name (e.g., `new_account_custom_entity`)

### Best Practices
1. **Cardinality**: Choose appropriate relationship types based on business needs
2. **Cascade Behavior**: Configure cascade behavior to maintain data integrity
3. **Business Rules**: Document business rules for each relationship
4. **Performance**: Consider performance implications of complex relationships
5. **Security**: Configure relationship security appropriately

### Maintenance
1. **Documentation**: Keep relationship documentation updated
2. **Testing**: Test relationship behavior in development
3. **Migration**: Plan for relationship changes during solution updates
4. **Validation**: Validate relationship integrity regularly

## Data Integrity Rules

### Referential Integrity
- All foreign key relationships must reference valid primary keys
- Deletion of parent records is restricted when child records exist
- Cascade operations maintain referential integrity

### Business Rules
- Relationship cardinality must be enforced
- Business logic validates relationship constraints
- Workflow rules can enforce relationship requirements
- Custom validation ensures data quality

### Security Considerations
- Relationship security affects record access
- Sharing rules consider relationship hierarchies
- Role-based security can restrict relationship operations
- Audit trails track relationship changes
