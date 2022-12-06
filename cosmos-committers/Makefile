all: outputs/commiters-cosmos-sdk.csv

outputs/forks-cosmos-sdk.csv:
	./interesting-repos-forks.sh cosmos/cosmos-sdk | tee $@.tmp
	mv $@.tmp $@

outputs/commiters-cosmos-sdk.csv: outputs/forks-cosmos-sdk.csv
	mkdir -p .tmp
	#for repo in cosmos/cosmos-sdk `cat $< | cut -d, -f1`; do \
	#	echo $$repo; \
	#	./active-commiters-for-repo.sh $$repo | tee .tmp/commiters-`echo $$repo | tr / -`.csv; \
	#done

	cat .tmp/commiters-*.csv \
		| grep '[^,].*,[^,].*,[^,].*,[^,].*$$' \
		| grep -v repo,login \
		| sort -u -t , -k 2,2 \
		| sed 's/^[^,]*,//' \
		| sed 's/,[^,]*,[^,]*$$//' \
		| awk -F , '{if(NF==2){print $$N}else{print "noname,"$$1}}' \
		> $@.tmp
	mv $@.tmp $@

	#rm -f .tmp/commiters-*.csv
