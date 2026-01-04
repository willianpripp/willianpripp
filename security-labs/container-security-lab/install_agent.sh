helm install \
    trendmicro \
    --namespace trendmicro-system --create-namespace \
    --values overrides.yaml \
    https://github.com/trendmicro/visionone-container-security-helm/archive/main.tar.gz