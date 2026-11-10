#!usr/bin/env bash

export SNPS_SCRIPTS=/home/maleman/snps_scripts

# Run the corresponding script for each tool
for f in "$SNPS_SCRIPTS"/*.sh; do
	source "$f"
done

