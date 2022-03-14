#!/bin/bash

cpu=$(echo nproc | bash)

./x-ui --threads=$cpu --config=config.json
