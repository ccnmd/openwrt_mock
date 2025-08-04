ROOT_DIR = /home/duong/SpecialMock
IMAGE_NAME = openwrt-image
CONTAINER_NAME = openwrt-build
MOCK_DATA_DIR = $(PWD)/mypkg
OUTPUT_DIR = $(ROOT_DIR)/output
PKG_OUTPUT = $(ROOT_DIR)/package-output

.PHONY: docker-image build clean

docker-image:
	docker build -t $(IMAGE_NAME) -f Dockerfile .


create:
	docker create -it --name $(CONTAINER_NAME) \
		-v $(MOCK_DATA_DIR):/mypkg \
		-v $(OUTPUT_DIR):/build/openwrt/bin \
		-v $(PKG_OUTPUT):/build/pkg-output \
		$(IMAGE_NAME) bash

build:
	docker start $(CONTAINER_NAME)
	docker exec -it $(CONTAINER_NAME) bash -c "\
			cd /build/openwrt && \
			sed -i '/mypkg/d' feeds.conf.default && \
			echo 'src-link mypkg /mypkg' >> feeds.conf.default && \
			./scripts/feeds update -a && \
			./scripts/feeds install -a && \
			make -j8 \
		"

package:
	docker start $(CONTAINER_NAME)
	docker exec -it $(CONTAINER_NAME) bash -c "\
			cd /build/openwrt/bin/packages/arm_cortex-a8_vfpv3/mypkg && \
			cp *.apk /build/pkg-output \
		"
