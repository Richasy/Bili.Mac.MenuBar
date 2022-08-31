#!/bin/sh
#
# Use this script to regenerate the Protocol Buffer and gRPC files
# needed to build the example.
#
# Note that it requires updated protoc, protoc-gen-swift, and
# protoc-gen-grpc-swift binaries and assumes that protoc-gen-swift
# is installed in $HOME/local/bin.

protoc \
    bilibili/app/dynamic/v2/*.proto \
    --swift_out=Source \
    --grpc-swift_out=Source
