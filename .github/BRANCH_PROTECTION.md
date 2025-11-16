# Branch Protection Configuration

This document explains how to enable branch protection to prevent merging PRs with failing checks.

## GitHub Branch Protection Settings

To prevent merging PRs when the pipeline is failing, configure the following settings on GitHub:

### Steps to Enable

1. Go to your repository on GitHub
2. Click on **Settings** → **Branches**
3. Under "Branch protection rules", click **Add rule** or edit the existing rule for `main`
4. Configure the following settings:

### Required Settings

- **Branch name pattern**: `main`
- ✅ **Require status checks to pass before merging**
  - ✅ **Require branches to be up to date before merging**
  - Under "Status checks that are required", select:
    - `Build and Test` (from the pr-checks.yml workflow)
- ✅ **Require a pull request before merging** (recommended)
  - Set "Required number of approvals before merging" to at least 1 (optional)
- ✅ **Do not allow bypassing the above settings** (recommended)

### Additional Recommended Settings

- ✅ **Require conversation resolution before merging**
- ✅ **Require linear history** (optional, keeps git history clean)
- ✅ **Include administrators** (applies rules to repo admins too)

## Workflow Overview

The `pr-checks.yml` workflow will now run on:
- All pull requests targeting `main`
- All pushes to branches (except `main`)

The workflow performs:
1. Elm build compilation check
2. Tailwind CSS build check
3. Full build verification
4. Artifact verification (ensures all expected files are generated)

Once branch protection is enabled with the settings above, PRs will be blocked from merging if any of these checks fail.
