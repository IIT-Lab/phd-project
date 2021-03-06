%% Physical layer
R = 500;
N_Service = 5;
N_Slice =  10;
N_rrh = 10;
BW = 120*1e3;%10*1e6;  
n0 = -174;%-174 ; %dbm
N0 = db2pow(n0)/1000;
Pc1 = 10; %watt
Pc  = db2pow(Pc1)/1000;
Pt = 30;
Pmax = db2pow(Pt)/1000;
Rt = .1*BW;%0.1*BW; 
N_PRB = 10;
imax = 1;
NumOfUtInService = randi([1 5],1, N_Service);
NumOfUtInService = UEN*ones(1,N_Service);
N_Ut = sum(NumOfUtInService);
rrh2slice = randi([0 imax],N_rrh, N_Slice); 
Crrh = zeros(1, N_rrh);
Prrh = zeros(1,N_rrh);
Power = zeros(counter_max, N_Ut);
Power_cnvg_Thr = 0.01;
service2slice = zeros(N_Service, N_Slice);    %randi([0 imax],N_Service, N_Slice); %2 we want to find this!!!!!
Ut2Service = zeros(sum(NumOfUtInService),N_Service); %3 -->true
PRB2Slice = randi([0 imax],N_PRB, N_Slice); %4 
Ut_map = zeros(N_Ut, N_PRB);  % map it
Popt = ones(1, N_Ut)*Pmax/N_Ut;
iter_max =1;
N_BBU = 2;
BBU_map = zeros(N_BBU, N_Slice);
var_q = 1e-5;
C_thresh = 1000*Rt/BW;
  
%% VNF MAC LAYER
N_VNF1 = 10;
VNF2Slice1 = randi([0 imax],N_VNF1, N_Slice); %5
N_VNF2 = 10;
VNF2Slice2 = randi([0 imax],N_VNF2, N_Slice); %6
mu1 = 10* Rt;
alpha_m1  = Rt;
mu2 = 10* Rt;
alpha_m2  = Rt;
lamda = Rt/10000;
delay_thresh = 9.2593e-06;
Delay_Slice1 = zeros(N_Slice,1);
Delay_Slice2 = zeros(N_Slice,1);
Delay_Transmission = zeros(N_Slice,1);
delay_max = 3e-4;
priority_service = ones(1,N_Service);
Delay_Slice = zeros(1,N_Slice);
%%
lambda_r = ones(1,N_Ut)*Rt/100;
mu = ones(1,N_rrh)*Pmax*100;
Kr = ones(1,N_rrh)*(2^(C_thresh/10) * var_q)*1000;
tr = ones(1,N_Ut)*(1/(delay_max-mean(Delay_Slice))+lamda)/10; 