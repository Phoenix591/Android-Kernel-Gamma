# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Hacked up a simple Makefile for the V20 Kernel, this has a lot of optimized
# flags and went a little extreme on specifying the flags since this is for a 
# remote compile target.
#
#                                               Feb 2017 - Omar Avelar
#
# Extra info and references taken from:
# https://wiki.codeaurora.org/xwiki/bin/QAEP/release
# https://github.com/aosp-mirror/kernel_common
# https://source.codeaurora.org/external/gigabyte/kernel/msm/log/?h=caf/msm-3.18
#
#
# Merging remote tracking from:
# git pull -s recursive -X theirs https://source.codeaurora.org/quic/la/kernel/msm-3.18 <TAG_NAME>
# git pull -s recursive -X theirs https://github.com/LineageOS/android_kernel_lge_msm8996 <TAG_NAME>
# git pull -s recursive -X theirs https://github.com/aosp-mirror/kernel_common android-3.18
#
# Keeping CAF up to date:
# git remote add codeaurora https://source.codeaurora.org/quic/la/kernel/msm-3.18
# git checkout caf
# git fetch --tags codeaurora
# git merge <TAG_NAME>
#

############################################################################
########################## GLOBAL MAKE ARGUMENTS ###########################
############################################################################

export ARCH := arm64
export ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
export CROSS_COMPILE := $(ROOT_DIR)/gcc/linaro-6.4/bin/aarch64-linux-gnu-
#export CROSS_COMPILE := /home/kyle/cross/bin/aarch64-linux-gnu-
export KBUILD_VERBOSE := 0

############################################################################
##################### LOCAL SETUP AND FILE STRUCTURES ######################
############################################################################
export DEVICE = h918
KDEFCONFIG := lineageos_$(DEVICE)_oxavelar_defconfig
KSRC_PATH = $(ROOT_DIR)/kernel/
OUT_PATH := $(ROOT_DIR)/out
KBUILD_OUT_PATH = $(OUT_PATH)/kbuild
MBUILD_OUT_PATH = $(OUT_PATH)/mbuild
DBUILD_OUT_PATH = $(OUT_PATH)/dbuild


############################################################################
############## KERNEL OPTIMIZATION FLAGS FOR THE QCOM S820 #################
############################################################################

export QCOM_S820 := \
        -march=armv8.1-a+simd+crc+crypto \
        -mtune=cortex-a72 \
        --param l1-cache-line-size=64 \
        --param l1-cache-size=32 \
        --param l2-cache-size=512 \

export 1GRAPHITE_FLAGS := \
        -fgraphite-identity \
        -ftree-loop-linear \
        -floop-interchange \
        -floop-strip-mine \
        -floop-block \

export KCFLAGS := \
        -pipe \
        -finline-functions \
        -O3 \
#	-fuse-ld=bfd \
        -fomit-frame-pointer \
        -ftree-vectorize \
        -ftree-slp-vectorize \
        -fvect-cost-model \
        -ftree-partial-pre \
        -fweb \
        -fgcse \
        -fgcse-sm \
        -fgcse-las \
        -fgcse-after-reload \
        -fivopts \
        -fsection-anchors \
        -fsched-spec-load \
        -ftree-loop-distribution \
        -ftree-loop-distribute-patterns \
        -ftree-loop-im \
        -ftree-loop-if-convert \
        -ftree-loop-if-convert-stores \
        -fpredictive-commoning \
        -foptimize-register-move \
        -fipa-cp-clone \
        -fipa-pta \
        -fmodulo-sched \
        -fmodulo-sched-allow-regmoves \
        $(QCOM_S820) \
        $(GRAPHITE_FLAGS) \

export KCFLAGS += -Wno-maybe-uninitialized
<<<<<<< HEAD
export LDFLAGS += -O2 --hash-style=gnu --as-needed -flto
=======
export LDFLAGS += -O3 --hash-style=gnu --as-needed
>>>>>>> 80b2c86d... Keep lto disabled thats a can of worms that isnt happening

export KCFLAGS += -Wno-misleading-indentation
export KCFLAGS += -Wno-tautological-compare
export KCFLAGS += -Wno-array-bounds
export KCFLAGS += -fno-use-linker-plugin

############################################################################
########################### KERNEL BUILD STEPS #############################
############################################################################

.PHONY: kernel
kernel:
	mkdir -p "$(KBUILD_OUT_PATH)"
	$(MAKE) -C "$(KSRC_PATH)" O="$(KBUILD_OUT_PATH)" "$(KDEFCONFIG)"
<<<<<<< HEAD
	$(MAKE) -C "$(KSRC_PATH)" O="$(KBUILD_OUT_PATH)" CONFIG_NO_ERROR_ON_MISMATCH=y Image.gz-dtb
=======
#	$(MAKE) -C "$(KSRC_PATH)" O="$(KBUILD_OUT_PATH)" menuconfig
	$(MAKE) -C "$(KSRC_PATH)" O="$(KBUILD_OUT_PATH)" CONFIG_NO_ERROR_ON_MISMATCH=y CONFIG_DEBUG_SECTION_MISMATCH=y KCFLAGS+="$(KCFLAGS)" Image.gz-dtb
>>>>>>> 80b2c86d... Keep lto disabled thats a can of worms that isnt happening
	cp -f "$(KBUILD_OUT_PATH)/arch/$(ARCH)/boot/Image.gz-dtb" "$(OUT_PATH)/Image.gz-dtb"
	$(MAKE) -C anykernel DEVICE=$(DEVICE)

.PHONY: modules
modules:
	# General modules from the kernel
	mkdir -p "$(MBUILD_OUT_PATH)"
	$(MAKE) -C "$(KSRC_PATH)" O="$(MBUILD_OUT_PATH)" "$(KDEFCONFIG)"
	$(MAKE) -C "$(KSRC_PATH)" O="$(MBUILD_OUT_PATH)" modules
	# Copy the created modules to the ramdisk path and strip debug symbols
	find "$(MBUILD_OUT_PATH)" -iname *.ko -exec cp -f \{\} "$(OUT_PATH)/lib/modules/" \;
	strip --strip-debug --strip-unneeded --remove-section=.comment --remove-section=.note "$(OUT_PATH)/lib/modules/*.*o"

.PHONY: clean
clean:
	$(MAKE) -C "$(KSRC_PATH)" mrproper
	rm -rf "$(OUT_PATH)"

