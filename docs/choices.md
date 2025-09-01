# Choices (Option Sets)

This document defines all option sets and their values used throughout the Dataverse solution.

## Standard Option Sets

### Account Status
**Logical Name**: `statecode`  
**Display Name**: Status  
**Description**: Status of the account record

| Value | Label | Description |
|-------|-------|-------------|
| 0 | Active | Account is active and operational |
| 1 | Inactive | Account is inactive or deactivated |

### Account Status Reason
**Logical Name**: `statuscode`  
**Display Name**: Status Reason  
**Description**: Reason for the account status

| Value | Label | Description | State |
|-------|-------|-------------|-------|
| 1 | Active | Account is active | Active |
| 2 | Inactive | Account is inactive | Inactive |

### Contact Status
**Logical Name**: `statecode`  
**Display Name**: Status  
**Description**: Status of the contact record

| Value | Label | Description |
|-------|-------|-------------|
| 0 | Active | Contact is active |
| 1 | Inactive | Contact is inactive |

### Contact Status Reason
**Logical Name**: `statuscode`  
**Display Name**: Status Reason  
**Description**: Reason for the contact status

| Value | Label | Description | State |
|-------|-------|-------------|-------|
| 1 | Active | Contact is active | Active |
| 2 | Inactive | Contact is inactive | Inactive |

### Opportunity Status
**Logical Name**: `statecode`  
**Display Name**: Status  
**Description**: Status of the opportunity

| Value | Label | Description |
|-------|-------|-------------|
| 0 | Open | Opportunity is open and active |
| 1 | Won | Opportunity has been won |
| 2 | Lost | Opportunity has been lost |

### Opportunity Status Reason
**Logical Name**: `statuscode`  
**Display Name**: Status Reason  
**Description**: Reason for the opportunity status

| Value | Label | Description | State |
|-------|-------|-------------|-------|
| 1 | In Progress | Opportunity is in progress | Open |
| 2 | On Hold | Opportunity is on hold | Open |
| 3 | Won | Opportunity has been won | Won |
| 4 | Canceled | Opportunity has been canceled | Lost |
| 5 | Out-Sold | Opportunity was out-sold | Lost |

### Lead Status
**Logical Name**: `statecode`  
**Display Name**: Status  
**Description**: Status of the lead

| Value | Label | Description |
|-------|-------|-------------|
| 0 | Open | Lead is open and active |
| 1 | Qualified | Lead has been qualified |
| 2 | Disqualified | Lead has been disqualified |

### Lead Status Reason
**Logical Name**: `statuscode`  
**Display Name**: Status Reason  
**Description**: Reason for the lead status

| Value | Label | Description | State |
|-------|-------|-------------|-------|
| 1 | New | New lead | Open |
| 2 | Contacted | Lead has been contacted | Open |
| 3 | Qualified | Lead has been qualified | Qualified |
| 4 | Disqualified | Lead has been disqualified | Disqualified |
| 5 | No Longer Interested | Lead is no longer interested | Disqualified |
| 6 | Cannot Contact | Cannot contact the lead | Disqualified |

## Custom Option Sets

### Priority
**Logical Name**: `new_priority`  
**Display Name**: Priority  
**Description**: Priority level for records

| Value | Label | Description | Color |
|-------|-------|-------------|-------|
| 1 | Low | Low priority | Green |
| 2 | Normal | Normal priority | Blue |
| 3 | High | High priority | Orange |
| 4 | Critical | Critical priority | Red |

### Category
**Logical Name**: `new_category`  
**Display Name**: Category  
**Description**: Category classification

| Value | Label | Description |
|-------|-------|-------------|
| 1 | Sales | Sales related |
| 2 | Marketing | Marketing related |
| 3 | Support | Support related |
| 4 | Operations | Operations related |
| 5 | Other | Other category |

### Region
**Logical Name**: `new_region`  
**Display Name**: Region  
**Description**: Geographic region

| Value | Label | Description |
|-------|-------|-------------|
| 1 | North America | North America |
| 2 | Europe | Europe |
| 3 | Asia Pacific | Asia Pacific |
| 4 | Latin America | Latin America |
| 5 | Middle East | Middle East |
| 6 | Africa | Africa |

## Global Option Sets

### Yes/No
**Logical Name**: `new_yesno`  
**Display Name**: Yes/No  
**Description**: Standard yes/no choice

| Value | Label | Description |
|-------|-------|-------------|
| 1 | Yes | Yes |
| 2 | No | No |

### Approval Status
**Logical Name**: `new_approvalstatus`  
**Display Name**: Approval Status  
**Description**: Status of approval process

| Value | Label | Description |
|-------|-------|-------------|
| 1 | Pending | Pending approval |
| 2 | Approved | Approved |
| 3 | Rejected | Rejected |
| 4 | Under Review | Under review |

## Usage Guidelines

### When to Use Option Sets
1. **Limited Choices**: When there are a fixed number of valid choices
2. **Data Consistency**: To ensure consistent data entry
3. **Reporting**: For easier reporting and filtering
4. **User Experience**: To provide clear choices to users

### Best Practices
1. **Naming Convention**: Use descriptive names (e.g., `new_priority` not `priority`)
2. **Value Assignment**: Use sequential numbers starting from 1
3. **Labels**: Use clear, user-friendly labels
4. **Descriptions**: Provide helpful descriptions for each value
5. **Colors**: Use colors to enhance visual distinction
6. **Localization**: Consider multi-language support if needed

### Maintenance
1. **Documentation**: Keep this document updated when adding new option sets
2. **Deprecation**: Mark deprecated values but don't delete them immediately
3. **Migration**: Plan for data migration when changing option sets
4. **Testing**: Test option set changes in development before production

## Customization Notes

- All custom option sets use the `new_` prefix to avoid conflicts
- Option sets are created at the solution level for portability
- Global option sets can be reused across multiple entities
- Local option sets are specific to individual entities
