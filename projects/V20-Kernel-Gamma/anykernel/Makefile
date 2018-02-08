OUTZIP=gamma-kernel-$(shell date +%F).zip
$(OUTZIP):
	cp gamma-kernel.zip ../out/$(OUTZIP)
	s3cp ../out/$(OUTZIP) us996/
gamma-kernel.zip: 
	cp ../out/Image.gz-dtb ./
	zip -r9 gamma-kernel.zip * -x *.zip
.PHONY: | gamma-kernel.zip $(OUTZIP)
