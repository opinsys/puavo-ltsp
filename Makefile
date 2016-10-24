subdirs = bootserver client puavo-install tools ruby-puavobs
install-subdirs = $(subdirs:%=install-%)
clean-subdirs = $(subdirs:%=clean-%)

debian_template_dir = debian.$(shell lsb_release -s -c)

.PHONY : all
all : $(subdirs)

.PHONY : $(subdirs)
$(subdirs) :
	$(MAKE) -C $@

.PHONY : $(install-subdirs)
$(install-subdirs) :
	$(MAKE) -C $(@:install-%=%) install

.PHONY : install
install : $(install-subdirs)

.PHONY : $(clean-subdirs)
$(clean-subdirs) :
	$(MAKE) -C $(@:clean-%=%) clean

.PHONY : clean
clean : $(clean-subdirs)

$(debian_template_dir) :
	cp -a debian.default '$@'

.PHONY: debian
debian: $(debian_template_dir)
	rm -rf '$@'
	cp -a '$<' debian
	puavo-dch $(shell cat VERSION)

.PHONY : deb-binary-arch
deb-binary-arch : debian
	dpkg-buildpackage -B -us -uc

.PHONY : deb
deb : debian
	dpkg-buildpackage -us -uc
