# Environment Variables

This document defines all environment variables and configuration settings used across different environments in the Dataverse solution.

## Environment Types

### Development Environment
**Purpose**: Active development and testing  
**Access**: Development team only

**Configuration**:
```env
# Dataverse Environment
DATAVERSE_URL=https://dev-org.crm.dynamics.com
ENVIRONMENT_NAME=Development
ENVIRONMENT_TYPE=Development

# Authentication
CLIENT_ID=your-dev-client-id
CLIENT_SECRET=your-dev-client-secret
TENANT_ID=your-tenant-id

# Solution Configuration
SOLUTION_NAME=YourSolutionName
SOLUTION_VERSION=1.0.0
PUBLISHER_NAME=YourPublisher
PUBLISHER_PREFIX=yp

# Development Settings
DEBUG_MODE=true
LOG_LEVEL=DEBUG
ENABLE_PLUGIN_TRACING=true
ENABLE_WORKFLOW_TRACING=true

# Database Settings
DATABASE_TYPE=Development
ENABLE_AUDIT=true
ENABLE_DUPLICATE_DETECTION=false

# Integration Settings
EXTERNAL_API_URL=https://dev-api.example.com
WEBHOOK_URL=https://dev-webhook.example.com
```

### Test Environment
**Purpose**: Quality assurance and user acceptance testing  
**Access**: QA team and business stakeholders

**Configuration**:
```env
# Dataverse Environment
DATAVERSE_URL=https://test-org.crm.dynamics.com
ENVIRONMENT_NAME=Test
ENVIRONMENT_TYPE=Test

# Authentication
CLIENT_ID=your-test-client-id
CLIENT_SECRET=your-test-client-secret
TENANT_ID=your-tenant-id

# Solution Configuration
SOLUTION_NAME=YourSolutionName
SOLUTION_VERSION=1.0.0
PUBLISHER_NAME=YourPublisher
PUBLISHER_PREFIX=yp

# Test Settings
DEBUG_MODE=false
LOG_LEVEL=INFO
ENABLE_PLUGIN_TRACING=false
ENABLE_WORKFLOW_TRACING=false

# Database Settings
DATABASE_TYPE=Test
ENABLE_AUDIT=true
ENABLE_DUPLICATE_DETECTION=true

# Integration Settings
EXTERNAL_API_URL=https://test-api.example.com
WEBHOOK_URL=https://test-webhook.example.com
```

### Production Environment
**Purpose**: Live business operations  
**Access**: End users and administrators

**Configuration**:
```env
# Dataverse Environment
DATAVERSE_URL=https://prod-org.crm.dynamics.com
ENVIRONMENT_NAME=Production
ENVIRONMENT_TYPE=Production

# Authentication
CLIENT_ID=your-prod-client-id
CLIENT_SECRET=your-prod-client-secret
TENANT_ID=your-tenant-id

# Solution Configuration
SOLUTION_NAME=YourSolutionName
SOLUTION_VERSION=1.0.0
PUBLISHER_NAME=YourPublisher
PUBLISHER_PREFIX=yp

# Production Settings
DEBUG_MODE=false
LOG_LEVEL=WARNING
ENABLE_PLUGIN_TRACING=false
ENABLE_WORKFLOW_TRACING=false

# Database Settings
DATABASE_TYPE=Production
ENABLE_AUDIT=true
ENABLE_DUPLICATE_DETECTION=true

# Integration Settings
EXTERNAL_API_URL=https://api.example.com
WEBHOOK_URL=https://webhook.example.com
```

## Variable Categories

### Authentication Variables
| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `CLIENT_ID` | Azure AD app registration client ID | Yes | `12345678-1234-1234-1234-123456789012` |
| `CLIENT_SECRET` | Azure AD app registration client secret | Yes | `your-client-secret` |
| `TENANT_ID` | Azure AD tenant ID | Yes | `12345678-1234-1234-1234-123456789012` |
| `DATAVERSE_URL` | Dataverse environment URL | Yes | `https://org.crm.dynamics.com` |

### Solution Configuration
| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `SOLUTION_NAME` | Name of the Dataverse solution | Yes | `YourSolutionName` |
| `SOLUTION_VERSION` | Version of the solution | Yes | `1.0.0` |
| `PUBLISHER_NAME` | Publisher name for the solution | Yes | `YourPublisher` |
| `PUBLISHER_PREFIX` | Publisher prefix | Yes | `yp` |

### Environment Settings
| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `ENVIRONMENT_NAME` | Human-readable environment name | Yes | `Development` |
| `ENVIRONMENT_TYPE` | Environment type | Yes | `Development` |
| `DEBUG_MODE` | Enable debug mode | No | `true` |
| `LOG_LEVEL` | Logging level | No | `DEBUG` |

### Database Settings
| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `DATABASE_TYPE` | Database type | Yes | `Development` |
| `ENABLE_AUDIT` | Enable audit logging | No | `true` |
| `ENABLE_DUPLICATE_DETECTION` | Enable duplicate detection | No | `false` |

### Integration Settings
| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `EXTERNAL_API_URL` | External API endpoint | No | `https://api.example.com` |
| `WEBHOOK_URL` | Webhook endpoint | No | `https://webhook.example.com` |
| `INTEGRATION_KEY` | Integration authentication key | No | `your-integration-key` |

## Security Considerations

### Sensitive Variables
The following variables contain sensitive information and should be handled securely:

- `CLIENT_SECRET`
- `INTEGRATION_KEY`
- `DATABASE_PASSWORD`
- `ENCRYPTION_KEY`

### Security Best Practices
1. **Never commit secrets to version control**
2. **Use Azure Key Vault for production secrets**
3. **Rotate secrets regularly**
4. **Use least privilege principle**
5. **Monitor secret access**

### Environment-Specific Security
- **Development**: Lower security requirements, easier access
- **Test**: Medium security, controlled access
- **Production**: Highest security, restricted access

## Configuration Management

### Local Development
For local development, create a `.env` file in the root directory:

```env
# Copy from environment-specific template
DATAVERSE_URL=https://dev-org.crm.dynamics.com
CLIENT_ID=your-dev-client-id
CLIENT_SECRET=your-dev-client-secret
TENANT_ID=your-tenant-id
SOLUTION_NAME=YourSolutionName
```

### CI/CD Pipeline
For CI/CD pipelines, use GitHub Secrets:

1. Go to repository settings
2. Navigate to Secrets and variables → Actions
3. Add the required secrets
4. Reference them in workflows using `${{ secrets.SECRET_NAME }}`

### Environment Templates
Create environment-specific template files:

- `.env.development`
- `.env.test`
- `.env.production`

## Validation and Testing

### Environment Validation
Create validation scripts to ensure all required variables are set:

```bash
#!/bin/bash
required_vars=("DATAVERSE_URL" "CLIENT_ID" "CLIENT_SECRET" "TENANT_ID")

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Error: $var is not set"
        exit 1
    fi
done

echo "All required environment variables are set"
```

### Configuration Testing
Test environment configurations:

```bash
# Test Dataverse connection
pac auth create --name "Test" --url $DATAVERSE_URL --clientId $CLIENT_ID --clientSecret $CLIENT_SECRET --tenantId $TENANT_ID

# Test solution access
pac solution list
```

## Troubleshooting

### Common Issues
1. **Authentication Errors**: Check CLIENT_ID, CLIENT_SECRET, and TENANT_ID
2. **Connection Errors**: Verify DATAVERSE_URL format
3. **Permission Errors**: Ensure proper Azure AD app registration
4. **Environment Mismatch**: Confirm environment variables match target environment

### Debug Mode
Enable debug mode for troubleshooting:

```env
DEBUG_MODE=true
LOG_LEVEL=DEBUG
ENABLE_PLUGIN_TRACING=true
```

### Logging
Configure logging levels:

- `DEBUG`: Detailed debugging information
- `INFO`: General information
- `WARNING`: Warning messages
- `ERROR`: Error messages only

## Documentation

### Environment Setup
Document environment setup procedures for each environment type.

### Configuration Changes
Track configuration changes and their impact.

### Rollback Procedures
Document procedures for rolling back configuration changes.

### Emergency Contacts
Maintain list of emergency contacts for each environment.
