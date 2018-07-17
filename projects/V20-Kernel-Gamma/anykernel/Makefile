OUTZIP=gamma-kernel-$(shell date +%F).zip
$(OUTZIP): gamma-kernel.zip
	cp gamma-kernel.zip ../out/$(OUTZIP)
	s3cp ../out/$(OUTZIP) h918/
gamma-kernel.zip: ../out/Image.gz-dtb
	cp ../out/Image.gz-dtb ./
	zip -r9 gamma-kernel.zip * -x *.zip -x Makefile
.PHONY: | gamma-kernel.zip $(OUTZIP)
