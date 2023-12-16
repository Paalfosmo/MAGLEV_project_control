%poles = [-20,-20,-1000,-12,-30,-30,-20,-12,-17,-23, -90, -10];
poles = [-100,-100,-100,-120,-300,-320,-210,-120,-170,-230, -90, -140];
A_n = [
    zeros(6), eye(6);
    zeros(6), zeros(6)
    ];

B_n = [
    zeros(6);
    eye(6)
    ];

K_tst = place(A_n,B_n,poles);

    I_m = [params.permanent.J/params.physical.mu0*params.permanent.l(1);
        params.permanent.J/params.physical.mu0*params.permanent.l(2);
        params.permanent.J/params.physical.mu0*params.permanent.l(3);
        params.permanent.J/params.physical.mu0*params.permanent.l(4);
        ];