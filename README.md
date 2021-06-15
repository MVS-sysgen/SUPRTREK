# SuperTrek aka Star Trek 79

## Install (does not work)

To install run `make_jcl.sh > suprtrek.jcl` and submit `suprtrek.jcl`.

:warning: This does not compile/link on MVS 3.8j with FORTRAN IV

## To Fix

The FORTRAN compiler included with MVS 3.8j does not have List Directed I/O (noted by the `*` in the READ statement). Which means that the following 26 entries in `SUPRTREK.F90` need to have FORTRAN format statements added.

| Line Number | Entry |
|:-----------:|-------|
| 1190:|      `READ(5,*,ERR=3000,END=4000)IPROB1`|
| 2025:|      `READ(5,*,ERR=9,END=99)JCM`|
| 4849:|      `READ(5,*,END=9680)NHOL1,NHOL2`|
| 4906:|      `READ(5,*,ERR=800,END=9680)LEVEL`|
| 4911:|      `READ(5,*,ERR=801,END=9680)NQUAD`|
| 4932:|      `READ(5,*,ERR=50,END=9680)MTOT`|
| 4963:|      `READ(5,*,END=9680)ITFCTR`|
| 5308:|      `READ(5,*,ERR=899,END=4321)ICM`|
| 5336:|      `READ(5,*,ERR=898,END=4321)X`|
| 5355:|      `READ(5,*,ERR=897,END=4321)X`|
| 5375:|      `READ(5,*,ERR=895,END=4321)PNRGY`|
| 5394:|      `READ(5,*,ERR=893,END=4321)DTORP`|
| 5425:|      `READ(5,*,ERR=891,END=4321)PNRGY`|
| 5436:|      `READ(5,*,ERR=871,END=4321)IBTYPE`|
| 5446:|      `READ(5,*,ERR=890,END=4321)ITRSTP`|
| 5476:|      `READ(5,*,END=4321,ERR=874)IPROB2`|
| 5510:|      `READ(5,*,ERR=888,END=4321)ADDFL`|
| 5556:|      `READ(5,*,ERR=885,END=4321)IBMEN`|
| 5570:|      `READ(5,*,ERR=8835,END=4321)IGUESS,JGUESS`|
| 5616:|      `READ(5,*,ERR=882,END=4321)IMSG`|
| 5626:|      `READ(5,*,ERR=881,END=4321)KBRG`|
| 5636:|      `READ(5,*,ERR=880,END=4321)XWRP`|
| 5646:|      `READ(5,*,END=4321,ERR=873)NGHTFP`|
| 5657:|      `READ(5,*,ERR=879,END=4321)RTBRG`|
| 5665:|      `READ(5,*,ERR=878,END=4321)SDEF`|
| 5680:|      `READ(5,*,ERR=876,END=4321)ISHSTR`|

More information about format statements: More information about that here: http://www.jaymoseley.com/hercules/fortran/fort_mini.htm#format

From (halfmeg on Yahoo Groups)[https://turnkey-mvs.yahoogroups.narkive.com/JDMQ038f/cobol-compiler-date#post14]:

```
One of the things which 'sensitized' me to wanting the source for things installed was KLINGON and SUPRTREK. Load modules were brought in from the CBT Tape easy install load module file. The only problem is they had been compiled with compilers which we don't have the run time for so didn't work ... SUPRTREK source had been (?) modified so that our FORTRAN version chokes on 140+ errors which can be fixed as they are all the same type thing. From another post where the problem is detailed a little:

""The source of SUPRTREK that needs fixing is in CBT249.FILE038. All the "READ(5,*" statements need a format label with valid format statement instead of that * which if for a later version of Fortran than H."

Later FORTRAN compiler accept the * and determine a length. Our FORTRAN version needs a specific label of x length there which varies from place to place depending upon the variable being compared to after the read. I believe a proper fix involves adding a FORMAT statement for each * needed in each subroutine. Think there were 140 or so errors of this type. Multiples might be taken care of by one FORMAT in a particular subroutine."
```