function x = TrapzInteg(dx,dx0,x0,dt)
% persistent dx0
% %%
% if exist('dx0','var')
%     dx0 = 0;
% end
%%

x = 0.5 * ( dx(:) + dx0(:) ) * dt + x0(:);      % Calculate the integration
%dx0 = dx(:);
%end  %function