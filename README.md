# KaaS
Kubernetes-as-a-Service is a managed service that enables you to run containerized applications in a preprovisioned shared cluster. Running containerized applications securely and efficiently is a complex task and requires an expertise to build and maintain your own cluster. KaaS does these things for you, so you can focus on what is important for your software product.

### How it works
You register yourself as a `tenant` and choose `free` or `buisness` plan. The platform generates an access token and tenant domain. There are few services available under tenant domain
 - https://manage.{TENANT_DOMAIN} dashboard to manage your workload
 - https://logs.{TENANT_DOMAIN} centralized logging
 - https://repo.{TENANT_DOMAIN} container repository
 - https://rbac.{TENANT_DOMAIN} dashboard to manage security

### Pricing model
For students, open-source developers or hobby projects, we offer a generous free tier.

### Development
The platform uses Infrastructure as Code and Continuous Delivery principles via Terraform and Github Actions frameworks.
```
# setup local environment
git checkout master
echo $token > backend.hcl
terraform init -backend-config=backend.hcl
terraform apply
export KUBECONFIG=.kube/config
```
