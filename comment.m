function [cOut,sReg] = comment(cOut,sReg,commtext)
%COMMENT prints a comment starting with the % symbol

cOut=[cOut sprintf('%% %s\n',commtext)];

end

