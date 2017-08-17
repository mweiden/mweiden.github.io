default: site

.PHONY: clean
clean:
	git clean -fd
	find . | egrep -v '^[.]|[.][.]|[.]/LICENSE[.]txt|[.]/Makefile|[.]/README.md|[.]/nanoc|[.]git$$' | xargs rm -r

.PHONY: site
site: clean
	cd nanoc && make
	cp -r nanoc/output/* ./

