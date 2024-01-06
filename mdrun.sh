gmx_mpi grompp -f minim.mdp -o em.tpr -c solv.gro -maxwarn 2 -p topol.top
gmx_mpi mdrun -v deffnm em -ntomp 20
gmx_mpi grompp -f cg.mdp -o em1.trp -c em.gro -maxwarn 2 -p topol.top
gmx_mpi mdrun -v -deffnm em1 -ntomp 20
gmx_mpi grompp -f nvt.tpr -c em1.gro -maxwarn 2 -p topol.top -r em1.gro
gmx_mpi mdrun -v -deffnm nvt -nb gpu -bonded gpu -ntomp 20 -pin off
gmx_mpi grompp -f npt.mdp -o npt.tpr -c nvt.gro -maxwarn 2 -p topol.top -r nvt.gro
gmx_mpi mdrun -v -deffnm npt -nb gpu -pme gpu -bonded gpu -ntomp 20 -pin off
gmi_mpi grompp -f md.mdp -o md.tpr -c npt.gro -maxwarn 2 -p topol.top -r npt.gro
gmx_mpi mdrun -v -deffnm md -nb gpu -pme gpu -bonded gpu -ntomp 20 -pin off
