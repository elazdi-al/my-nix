# Variables
FLAKE_PATH := ~/nix
REBUILD_CMD := darwin-rebuild switch --flake $(FLAKE_PATH)

# Default target
all: rebuild

# Target to rebuild the system using the flake
rebuild:
	@echo "Rebuilding system with flake..."
	$(REBUILD_CMD)

# Target to show help
help:
	@echo "Available targets:"
	@echo "  all     - Rebuild the system (default target)"
	@echo "  rebuild - Rebuild the system using the flake"
	@echo "  help    - Show this help message"

.PHONY: all rebuild help
