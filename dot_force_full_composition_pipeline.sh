#! /usr/bin/env bash

# sets force full composition pipeline in nvidia driver
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
