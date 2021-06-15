//SMPSEL   JOB (ACCT),'SMP LIST SELECT',CLASS=A,MSGCLASS=A,
//             NOTIFY=USERID
//*
//LIST    EXEC PGM=HMASMP,REGION=1024K,PARM='DATE=U'
//SMPCDS   DD  DSN=SYS1.SMPCDS,DISP=SHR
//SMPACDS  DD  DSN=SYS1.SMPACDS,DISP=SHR
//SMPPTS   DD  DSN=SYS1.SMPPTS,DISP=SHR
//SMPLIST  DD  DISP=(NEW,PASS),UNIT=SYSDA,SPACE=(CYL,(10,4),RLSE)
//SMPRPT   DD  SYSOUT=*
//SMPOUT   DD  SYSOUT=*
//SYSPRINT DD  SYSOUT=*
//SMPLOG   DD  DUMMY
//SMPCNTL  DD  *
           LIST PTS SYSMOD .
           LIST CDS SYSMOD NOACCEPT .
//*
//SELECT  EXEC PGM=SMPTFSEL
//STEPLIB  DD  DSN=SMPTFSEL.LOAD,DISP=SHR
//INPUT    DD  DSN=*.LIST.SMPLIST,DISP=(OLD,DELETE)
//OUTPUT   DD  DSN=SMPTFSEL.CNTL,DISP=(MOD,CATLG,DELETE),
//             UNIT=SYSDA,SPACE=(TRK,(4,1),RLSE)
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
 FMID(JVT1112) FMID(JVT1122) FMID(JVT1212) FMID(JVT1222) .
