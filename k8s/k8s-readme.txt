add all these ymls to .gitignore file if you store any sensitive data

deployment.yml
apiVersion: Specifies the API version for the Deployment resource (apps/v1).
kind: Indicates that this is a Deployment resource.
metadata: Metadata for the Deployment, including the name and labels.
spec.replicas: Defines the number of pod replicas to deploy.
spec.selector: Specifies how to identify the set of pods targeted by this Deployment.
spec.template: Defines the pod template:

    metadata.labels: Labels applied to the pods created by this Deployment.
    spec.containers: Specifies the container configuration:
        name: The name of the container.
        image: The Docker image to use. Replace my-fastapi-app:latest with your actual image name.
        ports: The container port to expose (8000 in this case for FastAPI).
        env: Example environment variable configuration.
        resources: Resource requests and limits for the container.
    restartPolicy: Ensures that pods are restarted automatically if they fail.
replicas: Adjust the number of replicas based on your scaling requirements.
image: Replace my-fastapi-app:latest with the appropriate image name and tag from your Docker registry.
environment variables: Modify or add environment variables as needed for your application.
resources: Adjust the resource requests and limits based on the needs of your application.


grafana.yml
Deployment:

    apiVersion: Specifies the API version for the Deployment resource.
    kind: Indicates that this is a Deployment resource.
    metadata: Contains the name and labels for the Grafana deployment.
    spec.replicas: Specifies the number of replicas (1 in this case).
    spec.selector: Matches pods with the app: grafana label.
    spec.template: Defines the pod configuration for Grafana.
    containers:
        image: The Grafana image to use. Replace grafana/grafana:latest with the version you want to deploy.
        ports: Exposes Grafana on port 3000.
        env: Uses secrets to set the admin user and password for Grafana.
        resources: Specifies the resource requests and limits for the Grafana container.
    restartPolicy: Ensures that the Grafana pod restarts if it fails.
Service:

    apiVersion: Specifies the API version for the Service resource.
    kind: Indicates that this is a Service resource.
    metadata: Contains the name and labels for the Grafana service.
    spec.type: LoadBalancer exposes Grafana externally using a load balancer.
    spec.ports: Maps port 80 on the load balancer to port 3000 on the Grafana container.
    spec.selector: Matches the app: grafana label to route traffic to the Grafana pod.

Secrets: Ensure you have a Kubernetes secret named grafana-admin with keys admin-user and admin-password for Grafana credentials.
LoadBalancer: The LoadBalancer service type is used to expose Grafana externally. If your Kubernetes environment does not support load balancers, consider using a NodePort or ClusterIP service type.
replicas: Adjust the number of replicas if you need to scale Grafana.
image: Specify the version of Grafana you want to use.
resources: Customize resource requests and limits based on your environment and Grafana usage.

ingress.yml
    apiVersion: Specifies the API version for the Ingress resource.
    kind: Indicates that this is an Ingress resource.
    metadata: Contains the name, namespace, and annotations for the Ingress.
        annotations: Configure behavior for the Nginx Ingress controller:
            nginx.ingress.kubernetes.io/rewrite-target: Rewrites the URL path for the backend service.
            nginx.ingress.kubernetes.io/ssl-redirect: Forces SSL redirection.
            nginx.ingress.kubernetes.io/proxy-body-size: Sets the maximum body size for client requests.
    spec.ingressClassName: Specifies the ingress class (e.g., nginx) used by your ingress controller.
    spec.tls: Configures TLS for secure connections:
        hosts: Lists the domains for which TLS is enabled.
        secretName: Specifies the name of the TLS secret containing your SSL certificate and key.
    spec.rules: Defines the routing rules for your application:
        host: The domain name for your application.
        http.paths: Configures the paths and backend services:
            path: The path to match for routing traffic.
            pathType: The type of path matching (e.g., Prefix).
            backend.service.name: The name of the service to route traffic to.
            backend.service.port.number: The port number of the service.

    your-domain.com: Replace with your actual domain name.
    your-tls-secret: Replace with the name of your TLS secret for SSL termination.
    fastapi-service: Replace with the name of your FastAPI service.
    ingressClassName: Ensure that the ingress class name matches your ingress controller (e.g., nginx or another ingress class).

    TLS: Make sure you have created a TLS secret in the same namespace with the appropriate SSL certificate and key.
    Annotations: You can add or modify annotations based on your ingress controller and specific needs.


k8s/kasten-backup.yml
    Profile: Configures a backup profile for Azure Blob Storage:
        name: The name of the backup profile (azure-backup-profile).
        namespace: The namespace where Kasten K10 is installed (kasten-io).
        objectStoreType: Set to azure for Azure Blob Storage.
        credentials: Specifies the Azure storage account credentials:
            accountName: Your Azure storage account name.
            accountKey: Your Azure storage account key. These should be securely managed.

    Policy: Sets a backup policy for Kasten K10:
        frequency: Specifies a daily backup schedule using the @daily cron expression.
        profile: References the azure-backup-profile for backups.
        selectors.matchTags: Adjust this to select the resources you want to back up based on their labels.

    Security: Store your accountName and accountKey in a Kubernetes secret instead of hard-coding them in the YAML file. Reference the secret in your configuration for better security.
    Azure Region: Make sure to use the Azure region where your AKS cluster and storage account are located.
    Namespace: Ensure the namespace is correct (kasten-io)


prometheus.yml
    ConfigMap: Contains the prometheus.yml configuration for Prometheus, which defines scrape intervals and targets, including nodes, pods, API servers, and other Kubernetes components.
    Deployment: Defines the Prometheus deployment, including:
        replicas: The number of Prometheus pods.
        image: The Prometheus image to use.
        args: Arguments to configure Prometheus, including the config file path and storage path.
        volumeMounts: Mounts the Prometheus configuration and storage.
        resources: Resource requests and limits for the Prometheus container.
        volumes: Defines a ConfigMap volume for the configuration and a storage volume for Prometheus data.
    Service: Exposes Prometheus using a LoadBalancer service, making it accessible externally on port 80.


    Storage: emptyDir is used for ephemeral storage in this example. For production, you should use a PersistentVolume for data retention.
    LoadBalancer: The LoadBalancer service type makes Prometheus accessible externally. You can change it to ClusterIP if you want Prometheus to be accessible only within the cluster.
    Azure-Specific Adjustments: Ensure your AKS cluster supports LoadBalancer services and configure any Azure-specific settings as needed.


service.yml
apiVersion: Specifies the API version for the Service resource (v1).
kind: Indicates that this is a Service resource.
metadata: Contains the name and labels for the Service.

    name: The name of the Service (fastapi-service).
    namespace: The namespace where the Service is deployed (default).
    labels: Labels to categorize and identify the Service.

spec: Defines the specifications for the Service.

    type: LoadBalancer exposes the Service externally with a load balancer. This is useful in AKS to make the service accessible from outside the cluster.
    ports: Specifies the ports for the Service:
        port: The external port to expose (80 in this case).
        targetPort: The port on the pods that the traffic is forwarded to (8000 for FastAPI).
        protocol: The protocol used (TCP).
    selector: Matches the app: fastapi-app label on the pods to route traffic to them.
    LoadBalancer: Using LoadBalancer in AKS will automatically create an Azure Load Balancer to expose the FastAPI app. Ensure that your AKS setup supports this.
Namespace: The Service is deployed in the default namespace. If your app is in a different namespace, update this accordingly.
Port Configuration: Make sure the targetPort matches the port your FastAPI app is listening on (8000 in this case).
Namespace: If your FastAPI app is in a different namespace, update the namespace field.
Port: Adjust the port and targetPort as needed based on your application's configuration.
Service Type: If you don't want external access, you can change type: LoadBalancer to ClusterIP.








