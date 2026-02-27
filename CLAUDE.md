# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal landing page — a static website (HTML + CSS) hosted on AWS S3 with CloudFront as CDN. Infrastructure is managed with Terraform, and deployment is automated via GitHub Actions.

## Branches

- `main` — production branch; pushes here trigger the CI/CD deployment pipeline
- `develop` — development branch for staging changes before merging to `main`

## Deployment

There is no build step. The site consists of only two files: `index.html` and `styles.css`. To deploy, merge changes into `main` — GitHub Actions will sync both files to S3 and invalidate the CloudFront cache.

The workflow uses four GitHub Actions secrets (provisioned by Terraform):
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `S3_BUCKET`
- `CLOUDFRONT_DISTRIBUTION_ID`

## Infrastructure (Terraform)

All Terraform files are in `terraform/`. The stack provisions:
- S3 bucket for static website hosting (`s3bucket.tf`)
- CloudFront distribution pointing to the S3 bucket (`cloudfront.tf`)
- GitHub Actions secrets in this repository (`github_secrets.tf`)
- Remote state stored in S3 (`state.tf`)

Provider configuration (`providers.tf`) uses the `personal` AWS CLI profile (`~/.aws/credentials`) and the `integrations/github` provider (requires `GITHUB_TOKEN` env var).

### First-time infrastructure setup

1. Update `state.tf` with the actual S3 backend bucket and key.
2. Update `s3bucket.tf` with the actual bucket name (replace `your-unique-bucket-name`).
3. Export GitHub token:
   ```bash
   export GITHUB_TOKEN="your_token"
   ```
4. Run from the `terraform/` directory:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
