# Landing Page

This repository hosts a simple static website built with HTML and CSS, utilizing various technologies for deployment and infrastructure management.
I work as a DevOps Engineer, infrastructure, cloud management and CI/CD are daily stuff for me, but I am not keen on designing and developing a web site. That is the reason why I used ChatGPT to write and review the HTML and CSS code.

## Technologies Used

### 1. HTML & CSS
- **Purpose**: Used for creating the structure and styling of the static website.
- **Files**: 
  - `index.html`: The main HTML file.
  - `styles.css`: The CSS file for styling.

### 2. GitHub Actions
- **Purpose**: Automates the deployment process to AWS S3.
- **How It Works**: 
  - The CI/CD pipeline is configured to trigger on pushes to the `main` branch.
  - It uploads `index.html` and `styles.css` to the designated S3 bucket.

### 3. AWS S3
- **Purpose**: Serves as the hosting solution for the static website.
- **Configuration**: 
  - An S3 bucket is created to host the website with public read access.
  - Configured for static website hosting, with an index and error document.

### 4. AWS CloudFront
- **Purpose**: Provides a Content Delivery Network (CDN) for faster content delivery and HTTPS support.
- **Configuration**: 
  - A CloudFront distribution is set up to point to the S3 bucket.
  - Ensures secure access to the website.

### 5. Terraform
- **Purpose**: Infrastructure as Code (IaC) tool for managing AWS resources.
- **How It Works**: 
  - A `main.tf` file defines the infrastructure (S3 bucket and CloudFront distribution).
  - Runs `terraform apply` to create and manage the infrastructure.

## Getting Started

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Configure AWS Credentials**: Set up AWS credentials with appropriate permissions for S3 and CloudFront.
3. **AWS Initial setup**: Install AWS CLI and run the `setup_aws.sh` script. The required parameters are the AWS S3 bucket name and the AWS region. 
3. **Set Up Terraform**: 
   - Update the `terraform.tfvars` with your custom values
   - Create a new environment variable containing a GitHub Token. It will be used by Terraform to authenticate with GitHub and create GitHub Action secrets.
     ```bash
     export GITHUB_TOKEN="xxxxxxxxx"
     ```
   - Initialize and apply Terraform to create the necessary AWS resources.
   - Execute the following commands:
     ```bash
     terraform init
     terraform plan
     terraform apply
     ```
4. **Configure GitHub Actions**: Check your repository settings and GitHub Actions secrets created using Terraform.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

Inspired by the Nerdearla community, fostering collaboration and knowledge sharing in technology.
