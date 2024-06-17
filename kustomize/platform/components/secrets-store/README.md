#  Secrets Store CSI Driver

Secrets Store CSI Driver for Kubernetes secrets - Integrates secrets stores with Kubernetes via a Container Storage Interface (CSI) volume.

The Secrets Store CSI Driver secrets-store.csi.k8s.io allows Kubernetes to mount multiple secrets, keys, and certs stored in enterprise-grade external secrets stores into their pods as a volume. Once the Volume is attached, the data in it is mounted into the container’s file system.

```bash
ROOT_DIR=$(git rev-parse --show-toplevel)

pushd ${ROOT_DIR}/kustomize/platform/components/secrets-store

helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
helm fetch \
    --untar \
    --untardir charts \
    secrets-store-csi-driver/secrets-store-csi-driver

helm template \
    --output-dir base \
    --namespace platform-secrets \
    --set syncSecret.enabled=true\
    secrets-store-csi-driver \
    charts/secrets-store-csi-driver

mv base/secrets-store-csi-driver/templates base/
rm -rf charts base/secrets-store-csi-driver

pushd base
kustomize create --autodetect --recursive
popd
popd

```

## References

* https://secrets-store-csi-driver.sigs.k8s.io/getting-started/installation
* https://github.com/aws/secrets-store-csi-driver-provider-aws

