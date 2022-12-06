all: outputs/forks-cosmos-sdk.csv

outputs/forks-cosmos-sdk.csv:
	./interesting-repos-forks.sh cosmos/cosmos-sdk | tee $@.tmp
	mv $@.tmp $@
