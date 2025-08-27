# FBSR (Factorio Blueprint String Renderer) commands

fbsr_dir := "Factorio-FBSR/FactorioBlueprintStringRenderer"
fbsr_config := fbsr_dir / "config.json"
fbsr_config_template := fbsr_dir / "res/config-template.json"

# Run FBSR CLI with arguments 
fbsr *ARGS:
    #!/usr/bin/env bash
    set -euo pipefail
    mvn --quiet --file {{fbsr_dir}}/pom.xml exec:java -Dexec.args="{{ARGS}}"

# Show FBSR configuration
fbsr-config: (fbsr "cfg-show")

# Configure Factorio installation (auto-detect)
fbsr-setup: (fbsr "cfg-factorio" "-find-install")

# Generate default vanilla profile (depends on setup)
fbsr-vanilla: fbsr-setup (fbsr "profile-default-vanilla")

# Build assets for profile (depends on vanilla profile existing)
fbsr-build-assets PROFILE="vanilla": fbsr-vanilla
    #!/usr/bin/env bash
    set -euo pipefail
    # Asset building needs more heap space
    MAVEN_OPTS="-Xmx40G" mvn --quiet --file {{fbsr_dir}}/pom.xml exec:java -Dexec.args="build {{PROFILE}}"

# Show all profile statuses
fbsr-status: (fbsr "profile-status" "-a")

# Run bot service (depends on assets being built)
fbsr-bot:
    @echo "Starting FBSR bot service..."
    @echo "Note: Run 'just fbsr-build-assets' first if you haven't built assets yet."
    @just fbsr bot-run

# Check bot status
fbsr-bot-status: (fbsr "bot-status")

# Kill bot service
fbsr-bot-kill: (fbsr "bot-kill")

# Render blueprint to test file (bot must be running)
fbsr-render BLUEPRINT:
    @echo "Note: Bot service must be running. Use 'just fbsr-bot' to start it."
    @just fbsr bot-render "{{BLUEPRINT}}" -full -t

# Render blueprint to specific file (bot must be running)
fbsr-render-file BLUEPRINT OUTPUT:
    @echo "Note: Bot service must be running. Use 'just fbsr-bot' to start it."
    @just fbsr bot-render "{{BLUEPRINT}}" -full -o="{{OUTPUT}}"

# Enable Web API for automation
fbsr-webapi PORT="8080": fbsr-setup (fbsr "cfg-webapi" "-enable" "-port" PORT)

# Run FBSR with Web API (for automation)
fbsr-serve: fbsr-webapi
    @echo "Starting FBSR with Web API..."
    @just fbsr bot-run

# Show help for FBSR
fbsr-help: (fbsr "help")
