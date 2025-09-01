# Dataverse Solution Repository Setup Guide

This guide will help you set up and configure your Dataverse solution repository for development and deployment.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Git** - [Download Git](https://git-scm.com/downloads)
2. **Node.js** (v16 or later) - [Download Node.js](https://nodejs.org/)
3. **Power Platform CLI** - Install via npm: `npm install -g @microsoft/powerplatform-cli`
4. **Visual Studio Code** (recommended) - [Download VS Code](https://code.visualstudio.com/)

## Initial Setup

### 1. Clone the Repository

```bash
git clone <your-github-repo-url>
cd <repository-name>
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Configure Environment Variables

Create a `.env` file in the root directory with your Dataverse environment details:

```env
DATAVERSE_URL=https://your-org.crm.dynamics.com
CLIENT_ID=your-app-registration-client-id
CLIENT_SECRET=your-app-registration-client-secret
TENANT_ID=your-tenant-id
```

### 4. Authenticate with Dataverse

Use the provided PowerShell script to connect to your Dataverse environment:

```powershell
.\scripts\Connect-Dataverse.ps1 -EnvironmentUrl "https://your-org.crm.dynamics.com" -EnvironmentName "Development"
```

Or use the Power Platform CLI directly:

```bash
pac auth create --name "Development" --url "https://your-org.crm.dynamics.com"
```

## GitHub Repository Setup

### 1. Create a New Repository on GitHub

1. Go to [GitHub](https://github.com) and sign in
2. Click the "+" icon in the top right and select "New repository"
3. Name your repository (e.g., "dataverse-solutions")
4. Choose visibility (public or private)
5. **Do NOT** initialize with README, .gitignore, or license (we already have these)
6. Click "Create repository"

### 2. Connect Your Local Repository to GitHub

```bash
# Add the remote repository
git remote add origin https://github.com/your-username/your-repo-name.git

# Verify the remote was added
git remote -v

# Push your code to GitHub
git add .
git commit -m "Initial commit: Dataverse solution repository setup"
git push -u origin main
```

### 3. Configure GitHub Secrets

For the CI/CD pipeline to work, you need to add the following secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Click "Settings" → "Secrets and variables" → "Actions"
3. Add the following secrets:
   - `DATAVERSE_URL`: Your Dataverse environment URL
   - `CLIENT_ID`: Azure AD app registration client ID
   - `CLIENT_SECRET`: Azure AD app registration client secret
   - `TENANT_ID`: Your Azure AD tenant ID
   - `DEV_ENVIRONMENT_URL`: Development environment URL (if different)
   - `PROD_ENVIRONMENT_URL`: Production environment URL

## Development Workflow

### 1. Create a New Solution

```bash
pac solution init --publisher-name "YourPublisher" --publisher-prefix "yp"
```

### 2. Add Components

```bash
# Add a canvas app
pac canvas add --path ./path/to/your/canvas-app

# Add a model-driven app
pac app add --path ./path/to/your/model-driven-app

# Add a plugin
pac plugin add --path ./path/to/your/plugin
```

### 3. Build and Export

```bash
# Build the solution
pac solution build

# Export using the PowerShell script
.\scripts\Export-Solution.ps1 -SolutionName "YourSolutionName" -EnvironmentName "Development"
```

### 4. Commit and Push Changes

```bash
git add .
git commit -m "Add new solution components"
git push origin main
```

## Branching Strategy

We recommend using the following branching strategy:

- `main`: Production-ready code
- `develop`: Development and testing
- `feature/*`: Feature branches for new development
- `hotfix/*`: Emergency fixes

### Creating Feature Branches

```bash
# Create and switch to a new feature branch
git checkout -b feature/new-solution-component

# Make your changes and commit
git add .
git commit -m "Add new solution component"

# Push the feature branch
git push origin feature/new-solution-component

# Create a pull request on GitHub
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**
   - Ensure your Azure AD app registration has the correct permissions
   - Verify your client ID and secret are correct
   - Check that your tenant ID is correct

2. **Power Platform CLI Issues**
   - Update to the latest version: `npm update -g @microsoft/powerplatform-cli`
   - Clear authentication cache: `pac auth clear`

3. **Solution Export Failures**
   - Ensure you have the necessary permissions in your Dataverse environment
   - Check that the solution name exists and is accessible

### Getting Help

- [Power Platform CLI Documentation](https://docs.microsoft.com/en-us/power-platform/developer/cli/introduction)
- [Dataverse Developer Documentation](https://docs.microsoft.com/en-us/power-apps/developer/data-platform/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Next Steps

1. Customize the solution templates in the `templates/` directory
2. Configure your CI/CD pipeline in `pipelines/github-actions.yml`
3. Add your specific solution components
4. Set up additional environments (dev, staging, prod)
5. Configure automated testing

For additional support, please refer to the main README.md file or contact your development team.
