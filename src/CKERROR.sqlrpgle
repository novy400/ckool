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
        /include '../include/CKOOL_h.rpgle'

        //------------------------------------------------------------- *
        dcl-proc  main;
        dcl-pi *N;
        end-pi;
          dcl-s lMsg char(200);
          dcl-s ErrorHappened ind ;
              monitor;
                CKOOL_throw('test throw');
              on-error;
                clear lMsg; 
                lMsg = CKOOL_catch();
                CKOOL_displayLongMessage('Mon message' + %trim(lMsg) +'.');
                CKOOL_writeJobLog(lMsg);
              endmon;
              on-exit ErrorHappened;
                if ErrorHappened;
                endif;
              return;
        end-proc;
