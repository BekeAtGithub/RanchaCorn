ansible/playbook.yml
Set up Kubernetes configuration: Uses the az aks get-credentials command to configure kubectl to connect to your AKS cluster. It requires Azure credentials.
Deploy the FastAPI application: Applies the Kubernetes manifests for the deployment, service, and ingress using kubectl.
Verify the deployment status: Checks the rollout status of the fastapi-deployment to ensure everything is deployed correctly.
debug: Outputs a message indicating the successful deployment status.
variables;
resource_group_name: The name of the Azure resource group where the AKS cluster is located.
aks_cluster_name: The name of the AKS cluster.
azure_client_id, azure_secret, azure_tenant: Azure credentials for authentication.

Make sure your Kubernetes manifests (deployment.yml, service.yml, and ingress.yml) are correctly configured in the /k8s directory.
You may need to customize the authentication method based on your Azure setup.



ansible/roles/app-deployment/tasks/main.yml
Configure Kubernetes access: Sets up access to the AKS cluster using az aks get-credentials. The --overwrite-existing flag ensures that any previous configuration is overwritten.
Deploy the FastAPI app: Uses kubectl apply to deploy the Kubernetes manifests for your app. The with_items loop applies the deployment.yml, service.yml, and ingress.yml manifests.
Wait for the deployment to complete: Uses kubectl rollout status to wait for the fastapi-deployment to complete. The task retries up to 5 times with a 10-second delay between attempts.
Display deployment output: Uses the debug module to print the output of the deployment commands for verification.
Variables: Ensure that resource_group_name, aks_cluster_name, azure_client_id, azure_secret, and azure_tenant are provided in your Ansible inventory or as extra variables.
role_path: Refers to the path of the current role, allowing for relative paths to your Kubernetes manifests in the /k8s directory.

ansible/roles/app-deployment/templates/app-config.j2
app.name: The name of your FastAPI application.
app.version: The version of your application.
environment: The deployment environment (e.g., development, staging, production).
server.host and server.port: The host and port settings for the FastAPI app.
database: Configuration settings for connecting to your database.
logging.level: The logging level for your application (e.g., DEBUG, INFO, WARNING, ERROR).
Variables: The values in {{ ... }} are placeholders for variables that you need to define in your Ansible inventory or as extra variables when running the playbook.
You can customize this template further based on the specific needs of your application.

ansible/roles/app-deployment/handlers/main.yml
Restart FastAPI app: This handler uses kubectl rollout restart to restart the FastAPI deployment in the AKS cluster.
Check FastAPI app status: This handler waits for the FastAPI deployment to roll out successfully, retrying up to 5 times with a 10-second delay between attempts.
register & until: The register captures the status of the command, and the until condition ensures the command succeeds before continuing.
These handlers can be triggered by tasks in your playbook or role when configuration changes require a restart of the FastAPI app.
You can customize the retries and delay values as needed based on the expected behavior of your app.

You can rename main.yml to handlers.yml or any other descriptive name you prefer, as long as you update any references to it in your Ansible role. By default, Ansible expects handlers to be defined in a handlers directory, but the file name itself can be customized.
Rename by: Renaming the file: Change main.yml to handlers.yml in the handlers directory.
Update References: Ensure that any playbooks or task files referring to handlers are still able to find them. If you are not explicitly referencing the handlers file in your tasks, Ansible will automatically detect it as long as it is located in the handlers directory.
Automatic Detection: Ansible will still detect and use the handlers as long as they are in the correct handlers directory.
Best Practice: Using descriptive names like handlers.yml can improve the readability of your project, especially if the file content changes over time or becomes more specific.

ansible/roles/k8s-configuration/tasks/main.yml
Set up Kubernetes namespace: Creates the specified namespace if it does not already exist. The ignore_errors: yes allows the playbook to continue even if the namespace already exists.
Apply Kubernetes deployment configuration: Uses kubectl apply to deploy the resources defined in deployment.yml, service.yml, and ingress.yml.
Wait for the deployment to complete: Uses kubectl rollout status to wait until the deployment is successfully rolled out, with retries and delays to handle any delays in Kubernetes.
Verify service is running: Runs kubectl get services to check the status of the services in the namespace and outputs the result using debug.
variables; 
namespace: The Kubernetes namespace where the resources will be deployed.
deployment_name: The name of the deployment to monitor for rollout status.
Ensure that namespace and deployment_name are defined in your Ansible inventory or provided as extra variables.
Customize the Kubernetes manifests in the /k8s directory to suit your application’s requirements.

ansible/roles/k8s-configuration/files
The files directory within the ansible/roles/k8s-configuration role is typically used to store static files that need to be copied or applied to the target system. For the context of configuring Kubernetes resources for your AKS cluster, this directory could include:
Keep It Organized: Only include files that are necessary for your Kubernetes configuration to keep the directory clean and manageable.
    Sensitive Files: Be cautious about storing sensitive files (like private keys) and ensure they are protected appropriately.
    You can use the copy or template modules in your Ansible tasks to move these files from the files directory to the appropriate location on your target system or to apply them using kubectl.


Potential Files to Include in ansible/roles/k8s-configuration/files

    Custom Kubernetes Manifests:
        If you have any static or pre-defined YAML files that are not managed dynamically but need to be applied directly to your Kubernetes cluster, you can place them here.
        Examples:
            custom-configmap.yml
            custom-secret.yml

    Certificate Files:
        If your deployment requires custom TLS certificates, you can store the certificate files (e.g., .crt and .key files) in this directory.
        Example:
            tls.crt
            tls.key

    Shell Scripts:
        You can include shell scripts that perform specific setup tasks related to your Kubernetes configuration.
        Example:
            initialize-namespace.sh

    Static Configuration Files:
        Any other static configuration files that are needed for setting up or configuring your Kubernetes resources.
        Example:
            kubeconfig


    
Example Task Using Files;
If you have a static custom-configmap.yml file in the files directory, you could use a task like this:
yaml file can have something like: 

- name: Apply custom ConfigMap
  command: kubectl apply -f {{ role_path }}/files/custom-configmap.yml


    
ansible/roles/k8s-configuration/templates
The templates directory within the ansible/roles/k8s-configuration role is used to store Jinja2 template files that can be dynamically rendered with variables and then applied or copied to your target environment. For configuring your AKS and Kubernetes resources, you might include:
Potential Files to Include in ansible/roles/k8s-configuration/templates

    Kubernetes Manifests as Templates:
        If your Kubernetes manifests need to be dynamically generated with variables (e.g., environment-specific configurations), you can store them here as Jinja2 templates.
        Examples:
            deployment.yml.j2: A template for your Kubernetes deployment that can render values like image name, replica count, and environment-specific settings.
            service.yml.j2: A template for your Kubernetes service with dynamically rendered ports or service types.
            ingress.yml.j2: A template for your Ingress configuration, rendering values like hostnames or TLS settings.

    Configuration Files:
        Templates for any configuration files that need variable substitution before being applied.
        Examples:
            configmap.yml.j2: A ConfigMap template where data can be populated using Ansible variables.
            secret.yml.j2: A Secret template that can render sensitive data securely using Ansible Vault.

    Custom Resource Definitions (CRDs):
        If your deployment involves CRDs that need to be templated, include those as well.
        Example:
            crd-definition.yml.j2: A CRD template for a custom resource that needs variable substitution.

deployment.yml.j2
app_name, namespace, replicas, image, and container_port: These variables can be dynamically substituted using values defined in your Ansible playbook or inventory.
env_vars: A loop to add environment variables dynamically, making it flexible for different environments.
Use the template module in your Ansible tasks to render these templates and apply them to your Kubernetes cluster.
example task yml file:
- name: Render and apply Kubernetes Deployment
  template:
    src: "{{ role_path }}/templates/deployment.yml.j2"
    dest: "/tmp/deployment.yml"
- name: Apply the rendered Deployment
  command: kubectl apply -f /tmp/deployment.yml


Customizing Templates: Modify your templates based on the specific requirements of your application and infrastructure.
Security: Be careful when templating sensitive information, like secrets, and use Ansible Vault to manage such data securely.

ansible/roles/kasten-setup/tasks/main.yml
Create Kubernetes namespace: Creates the kasten-io namespace where Kasten K10 will be installed. The ignore_errors: yes allows the playbook to continue if the namespace already exists.
Add Kasten Helm repository: Adds the Kasten Helm repository to Helm.
Update Helm repositories: Updates the Helm repositories to ensure the latest charts are available.
Deploy Kasten K10 using Helm: Uses helm install to deploy Kasten K10 in the kasten-io namespace with specified settings, such as enabling token authentication and setting the storage class.
Wait for Kasten K10 deployment: Uses kubectl rollout status to wait until the Kasten K10 deployment is successfully rolled out, retrying multiple times if necessary.
Display installation status: Outputs the installation status for debugging and verification.
variables;
storage_class: The storage class to use for persistent volumes. This should be defined in your Ansible inventory or passed as an extra variable.

Customizing Storage Class: Ensure storage_class is set to a valid storage class available in your AKS cluster.
Retries and Delay: Adjust the number of retries and the delay between attempts if your Kasten K10 deployment takes longer to become ready.

ansible/roles/kasten-setup/templates
The templates directory within the ansible/roles/kasten-setup role is typically used for Jinja2 templates that need to be dynamically rendered with variables before being applied. Here are some examples of what files you might include:
Potential Files to Include in ansible/roles/kasten-setup/templates

    Kasten K10 Custom Configuration Templates:
        If Kasten K10 requires any custom configurations, such as specific YAML manifests or ConfigMaps, you can store them here as templates.
        Example: k10-config.yml.j2

    Storage Class Configuration:
        If you need to define a custom storage class for Kasten K10, you could have a template for that.
        Example: storage-class.yml.j2

    Ingress Configuration:
        If you are using an Ingress controller to expose Kasten K10, you might have a template for the Ingress resource.
        Example: k10-ingress.yml.j2

k10-config.yml.j2
log_level: A variable for setting the logging level of Kasten K10.
external_gateway_enabled: A variable to toggle the external gateway feature.
You can use the template module in your Ansible tasks to render these templates and apply them using kubectl.
Example Yaml Task:

- name: Render and apply Kasten K10 custom configuration
  template:
    src: "{{ role_path }}/templates/k10-config.yml.j2"
    dest: "/tmp/k10-config.yml"
- name: Apply the rendered configuration
  command: kubectl apply -f /tmp/k10-config.yml


Dynamic Values: Use Jinja2 variables to customize the templates based on your environment and requirements.
Sensitive Data: Be cautious when templating sensitive information and consider using Ansible Vault for encryption if needed.

ansible/roles/monitoring-setup/tasks/main.yml
Create Kubernetes namespace: Creates a monitoring namespace for Prometheus and Grafana. The ignore_errors: yes allows the playbook to continue if the namespace already exists.
Add Helm repositories: Adds the Prometheus and Grafana Helm repositories and updates them to ensure the latest charts are available.
Deploy Prometheus and Grafana using Helm: Uses helm install to deploy Prometheus and Grafana in the monitoring namespace. The LoadBalancer service type is used to make both applications accessible.
Wait for deployments to be ready: Uses kubectl rollout status to wait for the Prometheus and Grafana deployments to complete, retrying multiple times if necessary.
Display installation status: Outputs the installation status of Prometheus and Grafana for debugging and verification.
variables;
grafana_admin_user: The admin username for Grafana.
grafana_admin_password: The admin password for Grafana.
storage_class: The storage class to be used for persistent volumes in Grafana.

Security: Ensure that grafana_admin_password is a secure password and consider encrypting it using Ansible Vault.
Retries and Delay: Adjust the number of retries and delay between attempts based on the expected behavior of your deployments.

ansible/roles/monitoring-setup/templates
The templates directory within the ansible/roles/monitoring-setup role is used for Jinja2 templates that need to be dynamically rendered with variables for configuring Prometheus, Grafana, or any custom monitoring settings. Here are some examples of what files you might include:
Potential Files to Include in ansible/roles/monitoring-setup/templates

    Prometheus Configuration Template:
        If you have custom Prometheus configuration needs, such as additional scrape targets, alert rules, or global settings, you can create a prometheus.yml.j2 template.
        Example: prometheus.yml.j2

    Grafana Datasource Template:
        You may want to create a Grafana datasource configuration to connect Grafana to Prometheus or other monitoring sources.
        Example: grafana-datasource.yml.j2

    Grafana Dashboard Templates:
        If you have specific Grafana dashboards you want to deploy or pre-configure, you can include JSON templates for those dashboards.
        Example: grafana-dashboard.json.j2

prometheus.yml.j2
scrape_interval: Customizable scrape interval for Prometheus.
evaluation_interval: Customizable evaluation interval for alerting rules.
scrape_configs: Configuration for scraping metrics from Kubernetes nodes and pods.

grafana-datasource.yml.j2

prometheus_url: The URL to your Prometheus server, which can be dynamically set using Ansible variables.


grafana-dashboard.json.j2

dashboard_title: The title of the Grafana dashboard, customizable with Ansible variables.
panels: An example panel for monitoring CPU usage.
Use the template module in your Ansible tasks to render these templates and apply them to your monitoring stack.
Example YAML Task for Applying Prometheus Configuration:

- name: Render and apply Prometheus configuration
  template:
    src: "{{ role_path }}/templates/prometheus.yml.j2"
    dest: "/etc/prometheus/prometheus.yml"
- name: Reload Prometheus to apply new configuration
  command: systemctl reload prometheus

Customization: Modify these templates based on your specific monitoring requirements.
Sensitive Data: Be cautious with any sensitive information in templates and use Ansible Vault for encryption if necessary.


ansible.cfg 
    [defaults]: Contains default settings for Ansible operations.
        inventory: Specifies the path to your inventory file. Adjust this as needed.
        remote_user: The default user for SSH connections. Replace your-username with the appropriate user.
        transport: Specifies the transport method for connections (usually ssh).
        host_key_checking: Enables SSH host key checking to prevent man-in-the-middle attacks. Set to True for security.
        timeout: Sets the timeout for SSH connections (in seconds).
        retry_files_enabled: Enables retry files to help with failed playbook runs.
        retry_files_save_path: The directory where retry files are saved.
        library: Specifies additional module directories if needed.
        module_utils: Path for custom module utilities, if any.
        roles_path: Directory path for roles used in your playbooks.
        verbosity: Sets the verbosity level for output. Higher numbers increase verbosity.

    [privilege_escalation]: Settings for privilege escalation when executing tasks.
        become: Enables privilege escalation (set to True to use sudo).
        become_method: The method to use for privilege escalation, commonly sudo.
        become_user: The user to switch to (usually root).


    Update the inventory, remote_user, and any other settings to match your environment and preferences.
    Adjust verbosity and other parameters based on your debugging or logging needs.


    Ensure that the ansible.cfg file is in your project's root directory for it to be recognized.
    Sensitive information should not be included in this file; consider using Ansible Vault for managing secrets.