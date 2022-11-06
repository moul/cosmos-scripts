GAIAD ?= gaiad
GAIAD_HOME ?= $(HOME)/.gaia

all: extracts


EXTRACTS = auth.accounts authz.authorization bank.balances bank.supply \
        capability.owners distribution feegrant.allowances \
        gov.proposals ibc.channel_genesis ibc.client_genesis ibc.connection_genesis \
        interchainaccounts liquidity slashing staking.delegations staking.redelegations \
        staking.unbonding_delegations staking.validators transfer
EXTRACTS_JSON = $(addprefix extracts/,$(addsuffix .json,$(EXTRACTS)))
extracts: $(EXTRACTS_JSON)
$(EXTRACTS_JSON): export.json
	@mkdir -p extracts
	cat export.json | jq .app_state.$(@:extracts/%.json=%) > $@


export.json:
	$(GAIAD) export 2>&1 | jq . | tee export.json | pv
