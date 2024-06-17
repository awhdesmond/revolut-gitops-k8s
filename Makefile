.PHONY: clusters clean-clusters clean

clusters:
	./scripts/create-cluster.sh kind-1
	./scripts/deploy-platform.sh kind-kind-1

clean-clusters:
	kind delete cluster --name kind-1

clean: clean-clusters
