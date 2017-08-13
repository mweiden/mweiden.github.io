default: site

.PHONY: site
site:
	cd nanoc && make
	cp -r nanoc/output/* ./

.PHONY: clean
clean:
	git clean -fd
