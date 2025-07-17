## 🔁 CI/CD Pipeline Integration

I am not at this level of Terraform use that I can do the integration myself
I am assuming in this test, for my benefit in this test, that I am soley a contributor.
I have only ever collaborated with someone who is DevOps who takes charge of the main pipelines, rather than myself doing it.

## 🧠 Design Decisions

- **Modular Simplicity**: The configuration is structured flatly in a single directory (`tf/`) for clarity and speed of development. In production, we would extract components into reusable modules (e.g., VPC, ECS cluster, IAM roles).
  
- **Separation of Concerns**: Files are logically split (`variables.tf`, `providers.tf`, `locals.tf`, `main.tf`) to isolate concerns and improve maintainability.

- **Reusability**: Input variables (declared in `variables.tf`) enable this Terraform configuration to be reused across different environments (dev, staging, prod) with different values.

---
