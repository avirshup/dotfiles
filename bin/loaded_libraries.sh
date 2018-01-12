#!/usr/bin/env bash

proc=$1

lsof -p ${proc} | awk '{print $9}' | grep -E '\.(so|dylib)'
