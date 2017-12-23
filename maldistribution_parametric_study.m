
%mass flow parametrisation
% SUBPLOT(1,4,1)
% g1=maldistribution_4_stream(454,454);
% SUBPLOT(1,4,2)
% g2=maldistribution_4_stream(200,708);
% SUBPLOT(1,4,3)
% g1=maldistribution_4_stream(100,808);
% SUBPLOT(1,4,4)
% g2=maldistribution_4_stream(50,858);


SUBPLOT(1,4,1)
g1=maldistribution_4_stream(454,454);
SUBPLOT(1,4,2)
g2=maldistribution_4_stream(708,200);
SUBPLOT(1,4,3)
g1=maldistribution_4_stream(808,100);
SUBPLOT(1,4,4)
g2=maldistribution_4_stream(858,50);

% inlet temp parametrisation

% SUBPLOT(1,4,1)
% g1=maldistribution_4_stream(76,43);
% SUBPLOT(1,4,2)
% g1=maldistribution_4_stream(66,43);
% SUBPLOT(1,4,3)
% g1=maldistribution_4_stream(56,43);
% SUBPLOT(1,4,4)
% g1=maldistribution_4_stream(46,43);

% a=1932.5*0.0001:1932.5*.1:1932.5*1
% %0.0002    0.1934    0.3867    0.5799    0.7732    0.9664    1.1597    1.3529    1.5462    1.7394
% 
% 
% g1=kgp_4_stream_eff(0.0002e3,1.7394e3,1043); %915+1018=
% g1=kgp_4_stream_eff(0.1934e3,1.5462e3,1043); %915+1018=
% g1=kgp_4_stream_eff(0.3867e3,1.3529e3,1043); %915+1018=
% g1=kgp_4_stream_eff(0.5799e3,1.1597e3,1043); %915+1018=
% g1=kgp_4_stream_eff(0.7732e3,0.9664e3,1043); %915+1018=
% g1=kgp_4_stream_eff(0.9664e3,0.7732e3,1043); %915+1018=
% g1=kgp_4_stream_eff(1.1597e3,0.5799e3,1043); %915+1018=
% g1=kgp_4_stream_eff(1.3529e3,0.3867e3,1043); %915+1018=
% g1=kgp_4_stream_eff(1.5462e3,0.1934e3,1043); %915+1018=
% 
% %       r12     r13         r14     r23         r24     r34       e12     e13        e14     e23         e24     e34          
% %     0.0001    0.0002    0.0002    1.6677    1.7290    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     0.1251    0.1854    0.1922    1.4825    1.5370    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     0.2858    0.3708    0.3844    1.2971    1.3448    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     0.5000    0.5560    0.5764    1.1119    1.1528    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     0.8001    0.7413    0.7686    0.9266    0.9606    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     1.2499    0.9266    0.9606    0.7413    0.7686    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     1.9998    1.1119    1.1528    0.5560    0.5764    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     3.4986    1.2971    1.3448    0.3708    0.3844    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% %     7.9948    1.4825    1.5370    0.1854    0.1922    1.0368    3.0123   13.9930    2.2574   -0.5108       Inf    0.2199
% 
% %effectiveness plot
% % tr=[1.7674 1.5349 1.3023 1.0698]
% % eh1=[1.0118 1.0130 1.0148 1.0178]
% % eh2=[0.4939 0.6336 0.8410 1.1809]
% % 
% % plot(tr,eh1,tr,eh2)

xlabel('Heat exchanger length')
ylabel('outlet temperature')