
lint:
	docker run --rm \
        -v "$(shell pwd):/data:ro" \
        avtodev/markdown-lint:v1 \
		--config /data/.markdownlint.yaml \
		/data

fix:
	docker run --rm \
        -v "$(shell pwd):/data" \
        avtodev/markdown-lint:v1 \
        --fix \
		--config /data/.markdownlint.yaml \
		/data

apply-rodeos: apply-rodeo-neuvector apply-rodeo-rancher

apply-rodeo-neuvector:
	hfcli apply scenario git-maintained-rodeo-neuvector Rodeos/NeuVector/

apply-rodeo-rancher:
	hfcli apply scenario git-maintained-rodeo-rancher Rodeos/Rancher/

get-rodeos: get-rodeo-neuvector get-rodeo-rancher

get-rodeo-neuvector:
	hfcli get scenario git-maintained-rodeo-neuvector Rodeos/NeuVector/

get-rodeo-rancher:
	hfcli get scenario git-maintained-rodeo-rancher Rodeos/Rancher/