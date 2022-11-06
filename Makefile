GAIAD ?= gaiad
GAIAD_HOME ?= $(HOME)/.gaia

export.json:
	$(GAIAD) export 2>&1 | jq . | tee export.json | pv
