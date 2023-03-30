#!/bin/bash

for sys in Fg228 Fg238 ecFc ngnhFg238 Fng228 ; do

cpptraj << EOF

readdata evecs.Fng228.dat name Evecs_Fng228
readdata evecs.$sys.dat name Evecs_$sys

modes name Evecs_Fng228 name2 Evecs_$sys beg 1 end 15 rmsip out rmsip.Fng228-$sys.dat

EOF

done
