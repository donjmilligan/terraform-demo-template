# Terraform Demo Template

This repository is a modular and extensible Terraform template designed to help you quickly deploy and manage cloud infrastructure using best practices.

## 📁 Project Structure

```
terraform-demo-template-main/
├── main.tf                 # Entry point to call modules
├── provider.tf             # Cloud provider configuration
├── variables.tf            # Input variables for root module
├── modules/
│   ├── compute_lb_core/    # Compute resources with load balancer
│   ├── iam/                # IAM roles and policies
│   └── network_core/       # Networking components (VPC, subnet, etc.)
├── .gitignore
├── LICENSE
└── README.md
```

## 🚀 Modules

### 1. `compute_lb_core`
- Manages instance templates and instance groups
- Configures load balancers and persistent disks

### 2. `iam`
- Defines IAM roles, bindings, and service accounts

### 3. `network_core`
- Sets up VPCs, subnets, routers, and IP address resources

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- Cloud provider CLI (e.g., `gcloud` for Google Cloud Platform)
- Configured authentication (e.g., `gcloud auth login`)

## 📦 Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/terraform-demo-template.git
   cd terraform-demo-template
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Plan the infrastructure:
   ```bash
   terraform plan
   ```

4. Apply the changes:
   ```bash
   terraform apply
   ```

## 📌 Notes

- Adjust variables in `variables.tf` or provide a `terraform.tfvars` file.
- Each module can be customized or reused in other projects.
- Use `.tflint.hcl` files for linting recommendations.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Feel free to fork or adapt this template for your specific cloud infrastructure needs!

