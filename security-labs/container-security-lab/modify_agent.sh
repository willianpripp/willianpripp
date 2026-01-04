helm get values --namespace trendmicro-system trendmicro | helm upgrade \
    trendmicro \
    --namespace trendmicro-system \
    --values overrides.yaml \
    https://github.com/trendmicro/visionone-container-security-helm/archive/main.tar.gz
