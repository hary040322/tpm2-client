# Makefile for a self-test.
# author: liuqun
# date: 20170308

.PHONY: all
all: main

# PREFIX should be the same dir where TPM2.0-TSS libraries has been installed to
PREFIX := /usr/local
LOCAL_LIB_DIR := $(PREFIX)/lib
LOCAL_INCLUDE_DIR := $(PREFIX)/include

# lib configuration
SAPI_LIB := $(LOCAL_LIB_DIR)/libsapi.a
TCTI_DEVICE_LIB := $(LOCAL_LIB_DIR)/libtcti-device.a
TCTI_SOCKET_LIB := $(LOCAL_LIB_DIR)/libtcti-socket.a

LIBS := $(SAPI_LIB) $(TCTI_DEVICE_LIB) $(TCTI_SOCKET_LIB)
CFLAGS := -g -O0 \
          -Wall -Wextra \
          -I$(LOCAL_INCLUDE_DIR)
CXXFLAGS := $(CFLAGS)
COMPILE_c = $(COMPILE.c)
COMPILE_cpp = $(COMPILE.cpp)

main: main.o tcti_util.o
	$(LINK.o) -o $@ $^ $(LIBS)

%.o: %.c
	$(COMPILE_c) -o $@ $<

%.o: %.c %.h
	$(COMPILE_c) -o $@ $<

%.o: %.cpp
	$(COMPILE_cpp) -o $@ $<

%.o: %.cpp %.h
	$(COMPILE_cpp) -o $@ $<

.PHONY: clean
clean:
	$(RM) *.o
