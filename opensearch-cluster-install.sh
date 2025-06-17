#!/bin/bash

# 사용자로부터 네임스페이스 입력 받기
read -p "설치할 네임스페이스를 입력하세요: " NAMESPACE

# 네임스페이스가 비어있을 경우 종료
if [[ -z "$NAMESPACE" ]]; then
  echo "❌ 네임스페이스를 입력해야 합니다."
  exit 1
fi

# 네임스페이스 생성 (이미 존재하면 무시)
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# 사용자에게 클러스터 정의 파일 존재 여부 확인
if [[ ! -f opensearch-cluster.yml ]]; then
  echo "⚠️ 'opensearch-cluster.yml' 파일이 현재 디렉토리에 없습니다. 스크립트를 종료합니다."
  exit 1
fi

# 모든 노드의 vm.max_map_count 재설정 데몬셋 적용
kubectl apply -f opensearch-vmmp-daemonset.yml

# 클러스터 정의 파일을 해당 네임스페이스로 적용
kubectl apply -n $NAMESPACE -f opensearch-cluster.yml

echo "✅ OpenSearch Operator와 클러스터가 '$NAMESPACE' 네임스페이스에 설치되었습니다."

