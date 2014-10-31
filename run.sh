#!/bin/bash
docker run -d -ti -p 8002:8000 -v `pwd`/images:/opt/presentation/images -v `pwd`:/opt/presentation/lib/md rossbachp/presentation
