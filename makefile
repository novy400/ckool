PROJET= CKOOL
DBGVIEW=*ALL
DBGVIEWSQL=*SOURCE
#BIN_LIB=$(PROJET)
BIN_LIB=NOVY4001
#WRK_LIB=$(PROJET)WRK
WRK_LIB=NOVY4002
SRC_LIB=NOVY4001
#DB_LIB=
BND_LIB=$(BIN_LIB)
INC_LIB= '/home/NOVY400/include/'
LIBLIST=$(BIN_LIB)


# The shell we use
SHELL=/QOpenSys/usr/bin/qsh


# Makefile for migrate project

all: crtlib CKOOL.srvpgm CKOOLOGMSG.cmd
crtlib:  $(WRK_LIB).lib $(BIN_LIB).lib 

CKOOL.srvpgm : CKOOL.inc CKOOL.rpgle
CKOOL.tgm : CKOOL.srvpgm ARCHIAPI.bnddir 
CKLOGMSG.pgm : CKLOGMSG.sqlrpgle
CKLOGMSG.tgm : CKOOL.srvpgm CKLOGMSG.pgm
CKLOGMSG.cmd : CKLOGMSG.tgm
ARCHIAPI.bnddir : CKOOL.entry




%.lib:
	-system -q "CRTLIB $*"
	@touch $@

%.pgm:
	$(eval modules := $(patsubst %,$(WRK_LIB)/%,$(basename $(filter %.rpgle %.sqlrpgle,$(notdir $^)))))
	liblist -af $(LIBLIST);\
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(modules))"
	@touch $@
	system "DLTOBJ OBJ($(WRK_LIB)/*ALL) OBJTYPE(*MODULE)"

%.inc: include/%.rpgleinc
	cp  '$<'  $(INC_LIB)
	@touch $@

%.rpgle: src/%.rpgle
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QRPGLESRC.file/$*.mbr') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	liblist -af $(LIBLIST);\
	system "CRTRPGMOD MODULE($(WRK_LIB)/$*) SRCSTMF('$<') DBGVIEW($(DBGVIEW)) TGTCCSID(*JOB)"
	@touch $@

%.sqlrpgle: src/%.sqlrpgle
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QRPGLESRC.file/$*.mbr') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	liblist -af $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(WRK_LIB)/$*) SRCSTMF('$<') COMMIT(*NONE) OBJTYPE(*MODULE) RPGPPOPT(*LVL2) COMPILEOPT('TGTCCSID(*JOB)') DBGVIEW($(DBGVIEWSQL))"
	@touch $@

%.clle: src/%.clle
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QCLSRC.file/$*.mbr') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	system "CRTBNDCL PGM($(BIN_LIB)/$*) SRCFILE($(SRC_LIB)/QCLSRC) SRCMBR(*PGM)"
	@touch $@

%.cmd: src/%.cmd
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QCMDSRC.file/$*.mbr') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(SRC_LIB)/QCMDSRC)"
	system "CHGCMD CMD($(BIN_LIB)/$*) PGM(*LIBL/$*)"
	@touch $@

%.srvpgm: 
	system "CPYFRMSTMF FROMSTMF('./src/$*.binder') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QSRVSRC.file/$*.mbr') MBROPT(*replace) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	system "CRTSRVPGM SRVPGM($(BIN_LIB)/$*) MODULE($(patsubst %,$(WRK_LIB)/%,$(basename $^))) OPTION(*DUPPROC) SRCFILE($(SRC_LIB)/QSRVSRC)"

	@touch $@
	system "DLTOBJ OBJ($(WRK_LIB)/*ALL) OBJTYPE(*MODULE)"


%.dspf: src/%.dspf
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*replace) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	system "CRTDSPF FILE($(BIN_LIB)/$*) SRCFILE($(SRC_LIB)/QDDSSRC) SRCMBR($*) REPLACE(*YES)"
	@touch $@

%.pf:
	system "CPYFRMSTMF FROMSTMF('./src/$*.pf') TOMBR('/QSYS.lib/$(SRC_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*replace) STMFCCSID(*STMF) DBFCCSID(*FILE) STMFCODPAG(1208)"
	system "CHGPF FILE($(DB_LIB)/$*) SRCFILE($(SRC_LIB)/QDDSSRC)"
	@touch $@

%.sql: sql/%.sql
	liblist -c $(LIBLIST);\
	system "RUNSQLSTM SRCSTMF('$<') COMMIT(*NONE) NAMING(*SQL)"
	@touch $@

%.bnddir: 
	-system -q "CRTBNDDIR BNDDIR($(BIN_LIB)/$*)"
	-system -q "ADDBNDDIRE BNDDIR($(BND_LIB)/$*) OBJ($(patsubst %.entry,(*LIBL/% *SRVPGM *IMMED),$^))"
	@touch $@

%.entry:
    # Basically do nothing..
	@touch $@

clean:
	rm -f *.lib *.pgm *.rpgle *.sqlrpgle *.cmd *.srvpgm *.dspf
	
release:
	@echo " -- Creating release. --"
	@echo " -- Creating save file. --"
	system "CRTSAVF FILE($(BIN_LIB)/RELEASE)"
	system "SAVLIB LIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE) OMITOBJ((RELEASE *FILE))"
	-rm -r release
	-mkdir release
	system "CPYTOSTMF FROMMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE.FILE') TOSTMF('./release/release.savf') STMFOPT(*REPLACE) STMFCCSID(1252) CVTDTA(*NONE)"
	@echo " -- Cleaning up... --"
	system "DLTOBJ OBJ($(BIN_LIB)/RELEASE) OBJTYPE(*FILE)"
	@echo " -- Release created! --"
	@echo ""
	@echo "To install the release, run:"
	@echo "  > CRTLIB $(BIN_LIB)"
	@echo "  > CPYFRMSTMF FROMSTMF('./release/release.savf') TOMBR('/QSYS.lib/$(BIN_LIB).lib/RELEASE.FILE') MBROPT(*REPLACE) CVTDTA(*NONE)"
	@echo "  > RSTLIB SAVLIB($(BIN_LIB)) DEV(*SAVF) SAVF($(BIN_LIB)/RELEASE)"
	@echo ""