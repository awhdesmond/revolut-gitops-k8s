.PHONY: kind

kind:
    kind create cluster -n kind-1 --config=kind/kind-1.yaml

clean-clusters:
    kind delete cluster --name kind-1

clean: clean-clusters
