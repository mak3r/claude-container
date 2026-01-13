# Define variables for the host user's UID and GID
HOST_UID := $(shell id -u)
HOST_GID := $(shell id -g)
IMAGE_NAME := local-ckd

# Define your host home for the mount
HOST_HOME := $(shell echo $$HOME)

# Define the directory for you dev projects if it's not in home
DEVELOPMENT := /home/projects

PHONY: build

build:
	podman build -t $(IMAGE_NAME):latest .

PHONY: run

run:
	podman run -it --rm \
       	--env DISPLAY=${DISPLAY} \
	--network host \
	--volume /tmp/.X11-unix:/tmp/.X11-unix \
	--user $(HOST_UID):$(HOST_GID) \
	--userns=keep-id \
	--cap-add=SYS_PTRACE \
	-e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
	-e XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
	-e MOZ_ENABLE_WAYLAND=1 \
	-e GDK_BACKEND=wayland \
	-e HOME=$(HOST_HOME) \
	-e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(HOST_UID)/bus \
	-v $(HOST_HOME):$(HOST_HOME) \
	-v $(DEVELOPMENT):$(DEVELOPMENT) \
	-v ${XDG_RUNTIME_DIR}:${XDG_RUNTIME_DIR} \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/group:/etc/group:ro \
	-v /run/dbus:/run/dbus \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--device /dev/dri:/dev/dri \
	--ipc=host \
	$(IMAGE_NAME):latest
