#!/bin/bash

# Zero disk before creating disk image

dd if=/dev/zero of=/zero
rm -f /zero
