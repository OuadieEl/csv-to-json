# =============================================================================
# Project Properties
# =============================================================================

# The name of the binary
BINARY_NAME=csv-to-json

# The path to the main package
CMD_PATH=.

# Get the version from the latest git tag. Default to v0.0.0 if no tags.
# `git describe --tags --always` provides a fallback to commit hash.
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "v0.0.0-dev")

# Go build flags
# -s -w: to make the binary smaller
# -X main.version=$(VERSION): to inject version information
LDFLAGS = -ldflags="-s -w -X main.version=$(VERSION)"

# =============================================================================
# Build Targets
# =============================================================================

.PHONY: all build clean

all: build

# Build for the host OS/ARCH
build: 
	@echo "==> Building for $(shell go env GOOS)/$(shell go env GOARCH)"
	@go build $(LDFLAGS) -o bin/$(BINARY_NAME) $(CMD_PATH)

# Clean build artifacts
clean:
	@echo "==> Cleaning build artifacts"
	@rm -rf ./bin

# =============================================================================
# Cross-Compilation & Distribution
# =============================================================================

.PHONY: build-all archive release

# Alias for `archive`
release: archive

# Build for all target platforms
build-all: clean
	@echo "==> Building all targets"
	@$(MAKE) build-platform GOOS=linux GOARCH=amd64
	@$(MAKE) build-platform GOOS=linux GOARCH=arm64
	@$(MAKE) build-platform GOOS=windows GOARCH=amd64
	@$(MAKE) build-platform GOOS=windows GOARCH=arm64
	@$(MAKE) build-platform GOOS=darwin GOARCH=amd64
	@$(MAKE) build-platform GOOS=darwin GOARCH=arm64

# Create archives for all target platforms
archive: build-all build-mac-universal
	@echo "==> Archiving all targets"
	@$(MAKE) archive-platform GOOS=linux GOARCH=amd64
	@$(MAKE) archive-platform GOOS=linux GOARCH=arm64
	@$(MAKE) archive-platform GOOS=windows GOARCH=amd64 EXT=.exe
	@$(MAKE) archive-platform GOOS=windows GOARCH=arm64 EXT=.exe
	@$(MAKE) archive-platform GOOS=darwin GOARCH=amd64
	@$(MAKE) archive-platform GOOS=darwin GOARCH=arm64
	@$(MAKE) archive-mac-universal

# =============================================================================
# Helper Targets (Not intended for direct use)
# =============================================================================

.PHONY: build-platform archive-platform build-mac-universal archive-mac-universal

# Helper to build for a specific platform
build-platform:
	@echo "  -> Building for $(GOOS)/$(GOARCH)"
	@GOOS=$(GOOS) GOARCH=$(GOARCH) go build $(LDFLAGS) -o bin/$(GOOS)_$(GOARCH)/$(BINARY_NAME)$(EXT) $(CMD_PATH)
	@cp LICENSE bin/$(GOOS)_$(GOARCH)/
	@cp README.md bin/$(GOOS)_$(GOARCH)/

# Helper to archive a specific platform
archive-platform:
	@echo "  -> Archiving for $(GOOS)/$(GOARCH)"
	@cd bin/$(GOOS)_$(GOARCH) && \
		if [ "$(EXT)" = ".exe" ]; then \
			zip ../$(BINARY_NAME)_$(VERSION)_$(GOOS)_$(GOARCH).zip $(BINARY_NAME)$(EXT) LICENSE README.md; \
		else \
			tar -czf ../$(BINARY_NAME)_$(VERSION)_$(GOOS)_$(GOARCH).tar.gz $(BINARY_NAME) LICENSE README.md; \
		fi

# Build macOS Universal Binary
build-mac-universal:
	@echo "==> Building macOS Universal Binary"
	@mkdir -p bin/darwin_universal
	@lipo -create -output bin/darwin_universal/$(BINARY_NAME) bin/darwin_amd64/$(BINARY_NAME) bin/darwin_arm64/$(BINARY_NAME)
	@cp LICENSE bin/darwin_universal/
	@cp README.md bin/darwin_universal/

# Archive macOS Universal Binary
archive-mac-universal:
	@echo "==> Archiving macOS Universal Binary"
	@cd bin/darwin_universal && tar -czf ../$(BINARY_NAME)_$(VERSION)_darwin_universal.tar.gz $(BINARY_NAME) LICENSE README.md
