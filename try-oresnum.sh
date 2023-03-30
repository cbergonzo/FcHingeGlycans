#!/bin/bash

for ((i=0; i<=3; i+=1)) ; do
run=`printf "%2.2i" $i`

cpptraj <<EOF
###Change numbering to 228###
parm nowat.ecFc.parm7
trajin ../5PROD/ecFc/analysis/nowat.nc.'$i'

change oresnums of :1-207 min 13 max 219
change oresnums of :208-426 min 237 max 442
change chainid of :1-413 to A
resinfo :;208&::A
resinfo :;435&::A

distance d01 :;14-114@CA&::A :;237-337@CA&::A out dist_tot.noimage.COM.$run.dat noimage
distance d02 :;73@CA&::A :;296@CA&::A out dist_tot.noimage.NLN.$run.dat noimage

angle a01 :;76@CA&::A :;204@CA&::A :;138@CA&::A out ang.CH2A-CH3A.$run.dat
angle a02 :;299@CA&::A :;427@CA&::A :;361@CA&::A out ang.CH2B-CH3B.$run.dat
angle a03 :;204@CA&::A :;138@CA&::A :;427@CA&::A out ang.CH3A-CH3B.$run.dat
angle a04 :;427@CA&::A :;361@CA&::A :;204@CA&::A out ang.CH3B-CH3A.$run.dat

dihedral di01 :;76@CA&::A :;95@CA&::A :;204@CA&::A :;138@CA&::A out dih.CH2A-CH3A.$run.dat
dihedral di02 :;299@CA&::A :;318@CA&::A :;427@CA&::A :;361@CA&::A out dih.CH2B-CH3B.$run.dat
dihedral di03 :;204@CA&::A :;138@CA&::A :;361@CA&::A :;427@CA&::A out dih.CH3A-CH3B.$run.dat

#distance d03 :431 :440 out dist_tot.noimage.com_2MA.$run.dat noimage

go

EOF

done
