
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
