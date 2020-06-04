# KaaS
Kubernetes-as-a-Service is a managed service that enables you to run containerized applications in a preprovisioned shared cluster. Running containerized applications securely and efficiently is a complex task and requires an expertise to build and maintain your own cluster. KaaS does these things for you, so you can focus on what is important for your business.

### How it works
You register yourself as a `tenant` and choose `free` or `buisness` plan. The platform generates an access token and tenant domain. There are few services available under tenant domain
 - https://admin.<tenant_domain> dashboard to manage your workload
 - https://logs.<tenant_domain> centralized logging
 - https://reg.<tenant_domain> container registry
 - https://rbac.<tenant_domain> dashboard to manage security

### Pricing model
For students, open-source developers or hobby projects, we offer a generous free tier.

### Development
The platform uses Infrastructure as Code and Continuous Delivery principles via Terraform and Github Actions frameworks.
```
# install terraform
curl -LO https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip
unzip ./terraform_0.12.25_linux_amd64.zip
sudo mv ./terraform /usr/local/bin

# setup local environment
git checkout master
echo $token >> backend.hcl
terraform init -backend-config=backend.hcl
terraform apply
./kubeconfig.sh
export KUBECONFIG=.key/admin.conf
```
Example app
```
cd example
terraform apply
cd manifest
kubectl apply -f app.yml
kubectl apply -f service.yml
kubectl apply -f secret.yml
kubectl apply -f ingress.yml
cd .. && ./ip_address.sh
terraform apply -target=aws_route53_record.app
```
