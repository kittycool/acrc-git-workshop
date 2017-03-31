test

## Set job parameters

inputfile=dsdsdsds

## Job Name
#BSUB -J ANSYS-Fluent

## Queue  Name
#BSUB -q medium_priority

## Output and Input Errors
#BSUB -o job%J.out
#BSUB -e job%J.err

## Specify walltime in HH:MM
#BSUB -W 120:00

## 16 Processors per Host
#BSUB -R "span[ptile=16]"

## Requesting for 32 cores
## Hello there
#BSUB -n 16

## Need to make our own machinefile
MACHINEFILE=mymacs.$LSB_JOBID
for i in `echo $LSB_HOSTS`
do
echo $i
done > $MACHINEFILE


## load module enviroement
module load ansys-fluent-17.1

## Run fluent program (Using ANSYS Internal Intel MPIi using 16 cores "-t16")
fluent 3d -g -t16 -mpi=intel -ssh -lsf -cnf=$MACHINEFILE -pinfiniband -nmon -i $inputfile >& $LSB_JOBID.log 2>&1
