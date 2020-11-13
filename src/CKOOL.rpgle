**free
ctl-opt nomain
        option(*nodebugio:*srcstmt:*nounref)
        bnddir('QC2LE');
/include '/home/NOVY400/include/CKOOL.rpgle'

 
//                                                                    
//\brief  Ecrit un message ou une expression dans la log du job.                                      
//                                                                    
//|                                                                   
//|   example:  CKOOL_writeJobLog( 'Write this data ' + %char(toto)); 
//\param /input  : Message ou Expression.                                       
//\TODO                                                               
//.....                                                               
//                                                                    
dcl-proc CKOOL_writeJobLog export;
  dcl-pi *N;
       pText like(CKOOL_longText) Const;
  end-pi;
  dcl-c THISPROC 'CKOOL_writeJobLog'; 
  dcl-s lErrorCode int(10);
  dcl-s lText like(CKOOL_longText);
  monitor;
  //initialisation
  // traitement
  clear lErrorCode;
  clear lText;
  lText =%trim(pText) + TOOLS_LINEFEED;
  lErrorCode = Qp0zLprintf(lText);
  // finalisation 
  return;
  on-error;
  //ko =======> anomalie ................
  return;
  endmon;
end-proc;
//                                                                    
//\brief  Ecrit un message ou une expression dans la log du job.                                      
//                                                                    
//|                                                                   
//|   example:  CKOOL_writeJobLog( 'Write this data ' + %char(toto)); 
//\param /input  : Message ou Expression.                                       
//\TODO                                                               
//.....                                                               
//                                                                    
dcl-proc CKOOL_displayLongMessage export;
  dcl-pi *N;
       pMessage like(CKOOL_longMessage) Const;
  end-pi;
  dcl-c THISPROC 'CKOOL_displayLongMessage'; 
  Dcl-Pr DspLongMsg ExtPgm('QUILNGTX');
    Text Char(16773100) const options(*varsize);
    Length Int(10) const;
    Msgid Char(7) const;
    Qualmsgf Char(20) const;
    ErrorCode Char(32767) options(*varsize);
  End-Pr;
  Dcl-Ds ErrorCode qualified;
    bytesProv Int(10) inz(0);
    bytesAvail Int(10) inz(0);
  End-Ds;
  monitor;
  //initialisation
  // traitement
  clear ErrorCode;
  DspLongMsg( pMessage :%Len(pMessage) :*blanks :*blanks : ErrorCode );
  // finalisation 
  return;
  on-error;
  //ko =======> anomalie ................
  return;
  endmon;
end-proc;

