# OpenSearch deploy with k8s
## 1. clone this repo
```bash
git clone
```

## 2. helm
### 1. install helm
- mac
```bash
brew install helm
```

### 2. install opensearch operator
```bash
helm repo add opensearch-operator https://opensearch-project.github.io/opensearch-k8s-operator/
helm install opensearch-operator opensearch-operator/opensearch-operator
helm repo update
```

## 3. apply opensearch-cluster
```bash
chmod +x opensearch-cluster.yml
./opensearch-cluster.yml
```
