**free
/if defined(CKOOL_H_DEFINED)       
/eof                               
/endif                             
/define CKOOL_H_DEFINED  
dcl-pr Qp0zLprintf int(10) extproc('Qp0zLprintf');
       szOutputStg  pointer value options(*string); 
end-pr;
dcl-c TOOLS_LINEFEED x'0d25';
dcl-s CKOOL_longText varchar(65535);
// Ecrit un message ou une expression dans la log du job.    
dcl-pr CKOOL_writeJobLog extproc(*dclcase);                                
       pText like(CKOOL_longText) Const;
end-pr;          
