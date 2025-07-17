Hello Folks,

Here is my submission.

I am not at a very high level of Terraform that I can do the integration myself
I am assuming in this test, for my benefit in this test, that I am soley a contributor on some network aspects.
I have only ever collaborated with someone who is DevOps who takes charge of the main pipelines, rather than myself doing it.
Full disclosure. I also utilized help from ChatGPT to create the loops.

## 🧠 Design Decisions

- **Modular Simplicity**: The configuration is structured flatly in a single directory (`tf/`) for clarity and speed of development. 
  
- **Separation of Concerns**: Files are logically split (`variables.tf`, `providers.tf`, `locals.tf`, `main.tf`) to isolate concerns and improve maintainability.

- **Reusability**: Input variables (declared in `variables.tf`) enable this Terraform configuration to be reused across different environments (dev, staging, prod) with different values.

---
