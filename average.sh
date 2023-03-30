#!/bin/bash

PARM='common.parm7'
TRAJ0='../ecFc/combined_common.ecFc.nc'
TRAJ1='../Fg228/combined_common.Fg228.nc'
TRAJ2='../Fg238/combined_common.Fg238.nc'
TRAJ3='../Fng228/combined_common.Fng228.nc'
TRAJ4='../ngnhFg238/combined_common.ngnhFg238.nc'

cpptraj <<EOF
parm $PARM
trajin $TRAJ0 1 last 5
trajin $TRAJ1 1 last 5
trajin $TRAJ2 1 last 5
trajin $TRAJ3 1 last 5
trajin $TRAJ4 1 last 5

# RMS-fit to first frame
rms first :1-406

# Create an average structure
average Avg.fullFc.rst7 ncrestart

go

EOF

