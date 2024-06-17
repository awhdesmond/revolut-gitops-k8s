.PHONY: clusters clean-clusters clean

KUBE_CONTEXT?=kind-kind1
ENV?=local

kind:
	./scripts/create-cluster.sh kind-1
	./scripts/deploy-platform.sh kind-kind-1 local

clean-kind:
	kind delete cluster --name kind-1

platform:
	./scripts/deploy-platform.sh $(KUBE_CONTEXT) $(ENV)
