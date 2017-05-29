#!/bin/bash

cd scripts
gnome-terminal -e "bash -c ./run_hss; bash"
gnome-terminal -e "bash -c ./run_mme; bash"
gnome-terminal -e "bash -c ./run_spgw; bash"
cd ..
