      **==========================================================================================*
      * \brief Projet CKOOL                                         *
      * \author novy                                                                                *
      * \date                                                                       *
      * \warning No warning                                                                       *
      * ----------------------------------------------------------------------------------------- *
      * \info compilation :                                                                       *
      *       .................................................................................  *
      *       ..................................................................................  *
      * ----------------------------------------------------------------------------------------- *
      *                                                                                           *
      * \rev  dd.mm.ccyy                                                                          *
      *       ..................................................................................  *
      *       ..................................................................................  *
      */==========================================================================================*
        /if defined(*CRTBNDRPG)
         ctl-opt dftactgrp(*no)
                 actgrp(*new);
        /endif
        Ctl-Opt BndDir('QC2LE':'ARCHIAPI')
                Option(*nodebugio:*srcstmt:*nounref)
                main(main);
        /include '/home/NOVY400/include/CKOOL.rpgleinc'

        //------------------------------------------------------------- *
        dcl-proc  main;
        dcl-pi *N;
          pMsg like(CKOOL_longText) const;
        end-pi;
          dcl-s ErrorHappened ind ;
          CKOOL_writeJobLog('Mon message' + %trim(pMsg) +'.');
        on-exit ErrorHappened;
          dsply ('aie c ballot !');
          if ErrorHappened;
          else;  
          dsply ('c fini !');
          endif;
          return;
        end-proc;
