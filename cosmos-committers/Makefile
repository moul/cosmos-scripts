all: outputs/commiters-cosmos-sdk.csv outputs/commiters-tendermint.csv

# COSMOSSDK
outputs/forks-cosmos-sdk.csv:
	./interesting-repos-forks.sh cosmos/cosmos-sdk | tee $@.tmp
	mv $@.tmp $@

outputs/commiters-cosmos-sdk.csv: outputs/forks-cosmos-sdk.csv
	mkdir -p .tmp/cosmos-sdk
	for repo in cosmos/cosmos-sdk `cat $< | cut -d, -f1`; do \
		echo $$repo; \
		./active-commiters-for-repo.sh $$repo | tee .tmp/cosmos-sdk/commiters-`echo $$repo | tr / -`.csv; \
	done

	cat .tmp/cosmos-sdk/commiters-*.csv \
		| grep '[^,].*,[^,].*,[^,].*,[^,].*$$' \
		| grep -v repo,login \
		| sort -u -t , -k 2,2 \
		| sed 's/^[^,]*,//' \
		| sed 's/,[^,]*,[^,]*$$//' \
		| awk -F , '{if(NF==2){print $$N}else{print "noname,"$$1}}' \
		> $@.tmp
	mv $@.tmp $@

# TENDERMINT
outputs/forks-tendermint.csv:
	./interesting-repos-forks.sh tendermint/tendermint | tee $@.tmp
	mv $@.tmp $@

outputs/commiters-tendermint.csv: outputs/forks-tendermint.csv
	mkdir -p .tmp/tendermint
	for repo in cosmos/tendermint `cat $< | cut -d, -f1`; do \
		echo $$repo; \
		./active-commiters-for-repo.sh $$repo | tee .tmp/tendermint/commiters-`echo $$repo | tr / -`.csv; \
	done

	cat .tmp/tendermint/commiters-*.csv \
		| grep '[^,].*,[^,].*,[^,].*,[^,].*$$' \
		| grep -v repo,login \
		| sort -u -t , -k 2,2 \
		| sed 's/^[^,]*,//' \
		| sed 's/,[^,]*,[^,]*$$//' \
		| awk -F , '{if(NF==2){print $$N}else{print "noname,"$$1}}' \
		> $@.tmp
	mv $@.tmp $@
