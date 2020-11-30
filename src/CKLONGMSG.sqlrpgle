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
        /include '../include/CKOOL.rpgle'

        //------------------------------------------------------------- *
        dcl-proc  main;
        dcl-pi *N;
          pMsg char(200) const;
        end-pi;
          dcl-s ErrorHappened ind ;
          CKOOL_displayLongMessage('Mon long message' + %trim(pMsg) +'.');
        on-exit ErrorHappened;
          if ErrorHappened;
          endif;
          return;
        end-proc;
