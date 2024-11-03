rancher-config.yml
apiVersion: Specifies the Rancher API version for the configuration.
kind: Indicates that this is a Cluster resource.
metadata.name: The name of the AKS cluster in Rancher.
spec.displayName: A human-readable name for the AKS cluster in the Rancher UI.
spec.aksConfig: Configuration details specific to the AKS cluster:

    resourceGroup: The Azure resource group where the AKS cluster is deployed.
    region: The Azure region where the AKS cluster is located.
    nodeCount: The number of nodes in the default AKS node pool.
    nodeVmSize: The VM size for the AKS nodes.
    kubernetesVersion: The Kubernetes version to use.
    networkPlugin: The network plugin for AKS (e.g., azure).
    networkPolicy: The network policy for AKS (e.g., azure).

cloudCredentialSecretName: The name of the secret in Rancher that holds your Azure credentials.
defaultPodSecurityPolicyTemplateName: The default Pod Security Policy template (e.g., restricted).
Custom Values: Update the values, such as resourceGroup, region, nodeCount, nodeVmSize, and kubernetesVersion, to match your AKS configuration.
Azure Credentials: Ensure you have a secret named azure-credentials in Rancher with your Azure credentials for authentication.


cluster-setup.sh
set -e: Ensures that the script exits immediately if any command fails.
RANCHER_URL: The URL of your Rancher instance. Replace this with your actual Rancher URL.
RANCHER_API_TOKEN: Your Rancher API token. Replace this with a valid token from your Rancher instance.
RANCHER_CLUSTER_CONFIG_PATH: The path to your rancher-config.yml file.
curl: Used to authenticate with Rancher and check the cluster status.
kubectl apply: Applies the Rancher cluster configuration to set up the AKS cluster.
Polling Loop: Checks the status of the AKS cluster in Rancher every 30 seconds, up to 30 times, to wait for the cluster to become active.
Rancher URL and API Token: Make sure you have access to your Rancher instance and have generated an API token.
jq: This script uses jq to parse JSON responses from the Rancher API. Make sure jq is installed on your system.
how to use:
chmod +x cluster-setup.sh
./cluster-setup.sh

Secure API Token: Keep your API token secure and consider using a secret management solution if possible.
Adjust Timeout: Modify the polling loop if your cluster setup takes longer than expected.
















