DEVICE=h918
OUTZIP=gamma-kernel-$(shell date +%F)-$(DEVICE).zip
OUTDIR=../out
$(OUTZIP): gamma-kernel.zip
	cp gamma-kernel.zip $(OUTDIR)/$(OUTZIP)
#	s3cp $(OUTDIR)/$(OUTZIP) $(DEVICE)/
gamma-kernel.zip: ../out/Image.gz-dtb anykernel-$(DEVICE).sh
	cp ../out/Image.gz-dtb ./
	cp anykernel-$(DEVICE).sh anykernel.sh
	zip -r9 gamma-kernel.zip * -x *.zip -x anykernel-*.sh -x Makefile
.PHONY: | gamma-kernel.zip $(OUTZIP)
