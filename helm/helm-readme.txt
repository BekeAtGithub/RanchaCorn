The file extension for YAML files can be either .yaml or .yml, and both are valid. It's a matter of personal or organizational preference, and Kubernetes, Helm, and most tools that work with YAML are compatible with either extension. However, it's generally recommended to stick to one convention for consistency across your project.
Common Practice:

    .yaml: This is more commonly used and is the official extension as per the YAML specification.
    .yml: Still widely used and accepted, but slightly less common.

For your Helm chart, using .yaml is the preferred and more common choice. So, you should name it chart.yaml.


chart.yaml
apiVersion: The version of the Helm chart API to use (v2 for Helm 3).
name: The name of the Helm chart (my-fastapi-app).
description: A brief description of the Helm chart.
version: The version of the Helm chart itself (used for versioning the chart).
appVersion: The version of the application being deployed (e.g., 1.0.0).


values.yaml
    replicaCount: The default number of replicas for your FastAPI application.
    image: Configuration for your Docker image:
        repository: The name of your Docker image. Replace this with your image name from your container registry.
        tag: The tag of the image to pull. Replace latest with a specific tag if necessary.
        pullPolicy: Specifies when to pull the image (e.g., IfNotPresent, Always, or Never).
    service: Configuration for the Kubernetes Service:
        type: LoadBalancer to expose the service externally.
        port: The external port to expose.
        targetPort: The port on the container where your FastAPI app is running (8000).
    resources: Resource requests and limits for the container.
    ingress: Configuration for Ingress:
        enabled: Set to true to enable Ingress.
        annotations: Annotations for the Nginx Ingress controller.
        hosts: The domain name(s) for your application. Replace myapp.example.com with your actual domain.
        tls: TLS configuration for secure connections. Replace myapp-tls with your TLS secret name and domain.
    autoscaling: Configuration for horizontal pod autoscaling:
        enabled: Set to true to enable autoscaling.
        minReplicas and maxReplicas: The minimum and maximum number of replicas.
        targetCPUUtilizationPercentage: The target CPU utilization percentage for scaling.
    nodeSelector, tolerations, and affinity: Configuration for scheduling pods on specific nodes or based on certain conditions.


    image.repository and image.tag: Replace with your actual Docker image and tag.
    ingress.hosts: Update with your domain name and adjust the TLS settings if needed.
    service.type: If you don’t need external access, you can change this to ClusterIP or NodePort.
    resources: Adjust resource requests and limits based on the needs of your application.


helm/templates
helm/templates directory contains Kubernetes manifest templates used by Helm to generate the final YAML files that are applied to your cluster. These templates are written in YAML and use Go templating syntax to inject values from values.yaml and other Helm mechanisms.
Common Files in helm/templates

    deployment.yaml:
        Template for the Kubernetes Deployment resource that defines how your application pods are created and managed.
        Uses values from values.yaml for configuring the number of replicas, container image, resource limits, etc.

service.yaml
Template for the Kubernetes Service resource that exposes your application.
Configures the service type, ports, and selector.

ingress.yaml:

    Template for the Kubernetes Ingress resource to manage external access to your application.
    Configures hosts, paths, and TLS settings using values from values.yaml


_helpers.tpl:

    A file for defining reusable template helpers and functions to simplify your templates.
    Often used to define consistent naming conventions for resources.



configmap.yaml (Optional):

    Template for a ConfigMap resource if your application requires configuration files or environment settings.

secret.yaml (Optional):

    Template for a Secret resource if your application needs to store sensitive information like passwords or API keys.

    deployment.yaml: Defines how your application is deployed (e.g., replicas, containers, resource limits).
    service.yaml: Configures how your application is exposed (e.g., LoadBalancer, ports).
    ingress.yaml: Manages external access to your application.
    _helpers.tpl: Contains helper templates for consistency.
    configmap.yaml and secret.yaml: Used for application configuration and sensitive data, if needed.

    Modify these templates to match your application's requirements.
    Use the .Values object to dynamically inject values from values.yaml.


app-config.yml
    apiVersion: Specifies the ArgoCD API version for the Application resource.
    kind: Indicates that this is an ArgoCD Application resource.
    metadata: Contains the name and namespace for the ArgoCD application. The namespace should be argocd, where ArgoCD is installed.
    spec.project: Specifies the ArgoCD project to associate with this application. The default project is typically used unless you have a custom project defined.
    source:
        repoURL: The URL of your Git repository. Replace this with the URL of your repository.
        targetRevision: The branch or commit to track in the repository.
        path: The path to the Helm chart in your repository (e.g., helm).
    destination:
        server: The Kubernetes API server URL. https://kubernetes.default.svc is used to refer to the in-cluster API server.
        namespace: The namespace where your FastAPI application will be deployed. Adjust this if your app is in a different namespace.
    syncPolicy:
        automated: Enables automated synchronization of the application:
            prune: Deletes resources not defined in the Git repository.
            selfHeal: Automatically corrects drift if a resource is modified manually.
        retry: Configures retry behavior if the synchronization fails, with a specified backoff strategy.

    repoURL: Replace with the URL of your Git repository.
    targetRevision: Specify the branch to track (e.g., main, master, or a specific branch).
    path: Update the path to point to your Helm chart within the repository.
    namespace: Ensure the namespace is correct for your deployment environment.
    syncPolicy: Adjust the retry settings and automated sync options as needed.

    This configuration enables GitOps for your FastAPI application using ArgoCD, ensuring your application stays in sync with the desired state defined in your Git repository.
    Make sure your Helm chart and Kubernetes manifests are correctly set up in the specified path of your repository.


project-config.yml
    apiVersion: Specifies the ArgoCD API version for the AppProject resource.
    kind: Indicates that this is an AppProject resource.
    metadata: Contains the name and namespace for the ArgoCD project. The namespace should be argocd, where ArgoCD is installed.
    spec.description: A brief description of the project.
    sourceRepos: Specifies the allowed Git repositories for applications in this project. Replace this with your repository URL.
    destinations: Lists the allowed destination clusters and namespaces for applications in this project.
        namespace: The namespace where applications can be deployed (default in this case).
        server: The Kubernetes API server URL. https://kubernetes.default.svc is used to refer to the in-cluster API server.
    clusterResourceWhitelist: Specifies which cluster-scoped resources can be managed. * allows all resources.
    namespaceResourceBlacklist: Specifies resources that cannot be managed in namespaces, such as ResourceQuota.
    syncWindows: Allows you to define time windows for when applications can be synchronized. Leave this empty ([]) if you don't need any restrictions.
    roles: Defines custom roles and permissions for users:
        developer: An example role with permissions to get and sync the fastapi-app application.
        policies: Specifies the actions allowed for this role.
    signatureKeys: Allows specifying keys for verifying signed commits if required.

    sourceRepos: Update with the URL of your Git repository.
    destinations: Adjust the namespace and server if your applications will be deployed in a different location.
    roles: Customize roles and permissions based on your team's needs.
    syncWindows: Define sync windows if you want to restrict when deployments can occur.

    Security: Carefully configure the clusterResourceWhitelist and namespaceResourceBlacklist to ensure only the necessary resources can be managed.
    Roles: Add or modify roles and permissions as needed to control access for different teams or users.


prometheus-config.yml
    global: Sets the global scrape and evaluation intervals.
        scrape_interval: How often Prometheus will scrape targets for metrics. The default is set to 15s.
        evaluation_interval: How often Prometheus will evaluate rules (e.g., alerting rules). The default is also 15s.
    scrape_configs: Defines the configurations for scraping metrics from different Kubernetes components:
        job_name: A name for the scrape job.
        kubernetes_sd_configs: Uses Kubernetes service discovery to find targets based on the specified role (e.g., node, pod, endpoints, ingress).
        scheme: Specifies https for secure connections where needed (e.g., API servers and kubelets).
        tls_config: Specifies the CA file for TLS authentication.
        bearer_token_file: The path to the service account token for authentication.
        metrics_path: The path where metrics are exposed (e.g., /metrics/cadvisor for cAdvisor metrics).
        relabel_configs: Relabeling configuration to extract metadata labels for nodes.

    scrape_interval and evaluation_interval: Adjust these values based on your performance and data requirements.
    scrape_configs: Customize the scrape jobs to include or exclude specific Kubernetes components as needed. You can also add additional jobs for custom metrics if your application exposes them.
    Authentication and Security: Ensure that the tls_config and bearer_token_file paths are correct for your AKS setup.

    Kubernetes Service Discovery: Prometheus uses Kubernetes service discovery to automatically find and scrape metrics from Kubernetes components.
    Security: Ensure your Prometheus configuration securely handles authentication and does not expose sensitive data.


monitoring/grafana-dashboards/dashboard1.json
    id: Set to null for a new dashboard. Grafana will assign an ID automatically.
    uid: A unique identifier for the dashboard. You can customize this as needed.
    title: The name of the dashboard, in this case, "AKS Monitoring Dashboard".
    tags: Tags for categorizing the dashboard, such as "kubernetes" and "aks".
    timezone: Set to "browser" to use the user's local timezone.
    refresh: The interval for refreshing the dashboard, set to "10s" for real-time monitoring.
    panels: An array of panels to display on the dashboard:
        CPU Usage Panel:
            type: graph to create a graph panel.
            datasource: Set to "Prometheus" (make sure your Prometheus data source is configured in Grafana).
            expr: The Prometheus query for CPU usage, aggregated by namespace.
            legendFormat: How to display the legend for each namespace.
            yaxis: Configured to show CPU usage as a percentage.
        Memory Usage Panel:
            type: graph to create a graph panel.
            expr: The Prometheus query for memory usage, aggregated by namespace.
            yaxis: Configured to show memory usage in bytes.
    templating: An empty list for now; you can add variables for more dynamic dashboards.
    annotations: Configuration for annotations and alerts.

    Datasource: Ensure "Prometheus" is the name of your configured data source in Grafana. If it has a different name, update the datasource field.
    Prometheus Queries: Modify the Prometheus queries (expr) to fit your specific monitoring needs.
    Panels: Add more panels or modify the existing ones to display additional metrics relevant to your AKS environment.

monitoring/grafana-dashboards/dashboard2.json
    id: Set to null for a new dashboard. Grafana will automatically assign an ID.
    uid: A unique identifier for the dashboard (network-disk-dashboard).
    title: The name of the dashboard, "Network and Disk Monitoring".
    tags: Tags for categorization, like "kubernetes", "network", and "disk".
    refresh: The interval for refreshing the dashboard, set to "10s" for real-time monitoring.
    panels: An array of panels for network and disk usage monitoring:
        Network Ingress:
            expr: Prometheus query to calculate the rate of incoming network traffic, grouped by namespace.
            yaxis: Configured to display bytes per second.
        Network Egress:
            expr: Prometheus query to calculate the rate of outgoing network traffic, grouped by namespace.
            yaxis: Configured similarly to the ingress panel.
        Disk Read I/O:
            expr: Prometheus query for the rate of disk read operations, grouped by namespace.
        Disk Write I/O:
            expr: Prometheus query for the rate of disk write operations, grouped by namespace.
    templating: An empty list; you can add variables for dynamic queries.
    annotations: Built-in annotations for marking events on the graphs.


    Datasource: Ensure "Prometheus" is the correct name of your data source in Grafana.
    Prometheus Queries: Modify the Prometheus queries as needed to match your monitoring requirements.
    Panels: You can add or adjust panels to include more metrics relevant to your environment.






