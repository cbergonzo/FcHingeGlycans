#!/bin/bash

PARM='common.parm7'
TRAJ0='../ecFc/combined_common.ecFc.nc'
TRAJ1='../Fg228/combined_common.Fg228.nc'
TRAJ2='../Fg238/combined_common.Fg238.nc'
TRAJ3='../Fng228/combined_common.Fng228.nc'
TRAJ4='../ngnhFg238/combined_common.ngnhFg238.nc'

for sys in ecFc Fg228 Fg238 Fng228 ngnhFg238 ; do

/nisthome/bergonzoc/Programs/cpptraj/bin/cpptraj <<EOF
parm $PARM
trajin ../$sys/combined_common.$sys.nc
reference Avg.fullFc.rst7

# RMS-fit to first frame
rms reference :1-406@CA

# Create an average structure
#average Avg.$sys.rst7 ncrestart

# Save coordinates as 'crd1'
createcrd crd1
run

# Fit to average structure
reference Avg.fullFc.rst7 [avg]

# RMS-fit to average structure
crdaction crd1 rms ref [avg] :1-406@CA

# Calculate coordinate covariance matrix
crdaction crd1 matrix covar :1-406@CA name gaccCovar

# Diagonalize coordinate covariance matrix, first 15 E.vecs
runanalysis diagmatrix gaccCovar name gaccEvecs out evecs.$sys.dat vecs 15 nmwiz nmwizvecs 5 nmwizfile $sys.nmd nmwizmask :1-406@CA

#Comment in if you already have evecs stored and need to read them in to do projections
#readdata evecs.$sys.dat name gaccEvecs

# Now create separate projections for loop region for each trajectory
#
crdaction crd1 projection P1 modes gaccEvecs \
beg 1 end 15 :1-406@CA crdframes 1,40000

dataset makexy P1:1 P1:2 name pca112
writedata plot.$sys.12.agr pca112

# Now histogram first 5 projections for each
#
hist P1:1,*,*,*,100 out pca.hist.$sys.agr norm name P1-1
hist P1:2,*,*,*,100 out pca.hist.$sys.agr norm name P1-2
hist P1:3,*,*,*,100 out pca.hist.$sys.agr norm name P1-3

EOF
done
