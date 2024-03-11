default: site

.PHONY: clean
clean:
	rm -r index.html pages/

.PHONY: site
site: clean
	cd nanoc && make
	cp -r nanoc/output/{index.html,pages} ./

