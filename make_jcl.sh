## Run this script to generate the install JCL

cat << 'END'
//SUPRTREK JOB (SYS),'Super Trek',CLASS=A,
//       MSGCLASS=A,REGION=4096K,
//       USER=IBMUSER,PASSWORD=SYS1
//CLEANUP EXEC PGM=IDCAMS
//SYSIN    DD *
  DELETE SYSGEN.SUPRTREK.LOAD SCRATCH PURGE
  DELETE SYSGEN.SUPRTREK.HELPFILE SCRATCH PURGE
  SET MAXCC=0
//SYSPRINT DD SYSOUT=*
//MAKEDSN  EXEC PGM=IEFBR14
//SUPRTREK DD  DSN=SYSGEN.SUPRTREK.LOAD,
//             UNIT=SYSALLDA,VOL=SER=PUB001,
//             SPACE=(CYL,(30,20,20),RLSE),
//             DISP=(NEW,CATLG,DELETE)
//*
//* Assemble QTIME, QDATE, BPAGE, AND CPAGE
//* Link and place in SYSGEN.SUPRTREK.LOAD
//* ========================================
END

for i in QTIME QDATE BPAGE CPAGE; do

cat << END
//*
//* $i
//*
//$(printf "%-8s" ${i:0:8}) EXEC ASMFCL,
//       PARM.LKED='LIST'
//ASM.SYSIN DD *
END

cat $i.HLASM

echo "/*"
echo "//LKED.SYSLMOD DD DSN=SYSGEN.SUPRTREK.LOAD($i),DISP=SHR"

done

echo "//*"
echo "//* Compile/Link Fortran programs DEDUCT RANKING"
echo "//* ST79INIT SUPRTREK and place them in SYSGEN.SUPRTREK.LOAD"
echo "//* ========================================"

for i in DEDUCT RANKING ST79INIT SUPRTREK; do

cat << END
//*
//* $i
//*
//$(printf "%-8s" ${i:0:8}) EXEC FORTHCL,
//  PARM.FORT='MAP,NODECK,LOAD'
//FORT.SYSLIN DD  DSNAME=&LOADSET,UNIT=SYSSQ,DISP=(MOD,PASS),
//             SPACE=(CYL,(200,50),RLSE)
//FORT.SYSIN  DD *
END

cat $i.F90

echo "/*"
echo "//LKED.SYSLIB  DD"
echo "//             DD DSN=SYSGEN.SUPRTREK.LOAD,DISP=SHR"
echo "//LKED.SYSLMOD DD DSN=SYSGEN.SUPRTREK.LOAD($i),DISP=SHR"

done

cat << 'END'
//*
//* Install CLIST SYS1.CMDPROC(SUPRTREK)
//*
//CLIST    EXEC PGM=PDSLOAD
//STEPLIB  DD  DSN=SYSC.LINKLIB,DISP=SHR
//SYSPRINT DD  SYSOUT=*
//SYSUT2   DD  DSN=SYS1.CMDPROC,DISP=SHR
//SYSUT1   DD  *
./ ADD NAME=SUPRTREK
END

cat SUPRTREK.CLIST
echo "/*"

cat << END
//HELPFILE EXEC PGM=IEBGENER
//SYSIN    DD DUMMY
//SYSPRINT DD SYSOUT=*
//SYSUT2   DD DISP=(NEW,CATLG),DSN=SYSGEN.SUPRTREK.HELPFILE,
//            UNIT=3390,VOL=SER=PUB001,
//            SPACE=(CYL,(3,3),RLSE),
//            DCB=(RECFM=F,LRECL=72)
//SYSUT1   DD *
END
cat ST79HELP.txt
echo "/*"
echo "//"
exit