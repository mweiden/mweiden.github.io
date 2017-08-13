default: site

.PHONY: site
site:
	cd nanoc && make
	cp nanoc/output/* ./

.PHONY: clean
clean:
	git clean -fd
