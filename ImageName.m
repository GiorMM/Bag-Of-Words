function out = ImageName(in)
%In is the number of the in th picture input
%Out is the image file name
%For example, if in=3, then out='ukbench00003. jpg. dsift'

out = 'ukbench00';
if(in < 10)
    out = [out, '00', num2str(in)];
elseif((10 <= in) && (in < 100))
    out = [out, '0', num2str(in)];
else
    out = [out, num2str(in)];
end
out = [out, '.jpg'];

end


