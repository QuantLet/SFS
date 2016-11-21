SFSIBTdk = function(s0, r, t, n, func) {
    
    source("IBTblackscholes.R")
    source("IBTcrr.R")
    source("IBTimpliedvola.R")
    
    if (s0 <= 0) {
        print("SFSIBTdk: Price of Underlying Asset should be positive! Please input again")
        print("s0=")
        s0 = scan()
    }
    if ((r < 0) || (r > 1)) {
        print("SFSIBTdk: Interest rate need to be between 0 and 1! Please input again")
        print("r=")
        r = scan()
    }
    if (t <= 0) {
        print("SFSIBTdk: Time to expiration should be positive! Please input again")
        print("t=")
        t = scan()
    }
    if (n < 1) {
        print("SFSIBTdk: Number of steps should be at least equal to 1! Please input again")
        print("n=")
        n = scan()
    }
    if (n > 150) {
        # Constraint of n, otherwise it will take too much time
        print("SFSIBTdk: Could you please choose a smaller n? Please input again")
        print("n=")
        n = scan()
    }
    dt          = t/n
    Smat        = matrix(0, n + 1, n + 1)   # Stock price at nodes
    Smat[1, 1]  = s0                        # First node equals the underlying price
    ADmat       = matrix(0, n + 1, n + 1)   # Arrow-Debreu prices
    ADmat[1, 1] = 1                         # First Arrow-Debreu price equals 1
    pmat        = matrix(0, n, n)           # Transition probabilites
    infl        = exp(r * dt)
    
    for (i in seq(1, n)) {
        # Step 1 : Find central nodes of stock tree 
        # (i+1) is odd
        if ((i%%2) == 0) {
            mi = (i/2 + 1)
            Smat[mi, i + 1] = s0  # center point price set to spot
            if ((s0 < infl * Smat[mi - 1, i]) || (s0 > infl * Smat[mi, i])) {
                Smat[mi, i + 1] = infl * (Smat[mi - 1, i] + Smat[mi, i])/2
            }
            lnode = mi
            llnode = mi
        } else {
            # (i+1) is even find the upper and the lower node
            mi = round((i + 1)/2)
            Call_Put_Flag = 1   # 1 for call/0 for put
            S = Smat[mi, i]     # S_n^i
            sigma = IBTimpliedvola(s0, S, i * dt, func)  # func=1 for interpolation, else a parabola
            C = IBTcrr(s0, S, r, sigma, i * dt, i, Call_Put_Flag)  # Call price from BS model
            rho_u = 0
            if ((mi + 1) <= i) {
                rho_u = sum(ADmat[(mi + 1):i, i] * (infl * Smat[(mi + 1):i, i] - 
                  S))
            }
            Su = S * (infl * C + ADmat[mi, i] * S - rho_u)/(ADmat[mi, i] * S * infl - 
                infl * C + rho_u)  # Upper node
            Sl = S^2/Su  # Lower node
            # Compensation 
            if ((mi == 1) && ((Su < infl * S) || (Sl > infl * S))) {
                print("SFSIBTdk: Sorry that in the condition of interest rate being higher than volatility, this method cannot give definite output and will terminate automatically")
                print("Please type another interest rate")
                print("r=")
                r = scan()
            }
            # Compensation 
            if ((mi > 1) && ((Su < infl * S) || (Sl < infl * S))) {
                Su = sqrt(S^3/Smat[mi - 1, i])
                Sl = S^2/Su
            }
            if ((mi < i) && (mi > 1)) {
                if ((Su > infl * Smat[mi + 1, i]) || (Sl < infl * Smat[mi - 1, i])) {
                  Su = sqrt(S^3/Smat[mi - 1, i])
                  Sl = S^2/Su
                }
                if ((Su > infl * Smat[mi + 1, i]) || (Su < infl * S)) {
                  Su = infl * (S + Smat[mi + 1, i])/2
                }
                if ((Sl > infl * S) || (Sl < infl * Smat[mi - 1, i])) {
                  Sl = infl * (S + Smat[mi - 1, i])/2
                }
            }
            Smat[mi + 1, i + 1] = Su
            Smat[mi, i + 1] = Sl
            lnode  = mi + 1
            llnode = mi
        }
        
        # Step 2 : Find upper nodes of stock tree 
        for (j in seq(lnode + 1, i + 1)) {
            Call_Put_Flag = 1  # Call price
            S = Smat[j - 1, i]  # S_n^i, i=j-1, i^1 = j
            sigma = IBTimpliedvola(s0, S, i * dt, func)  # func=1 for interpolation, else a parabola
            C = IBTcrr(s0, S, r, sigma, i * dt, i, Call_Put_Flag)  # Call price from BS model
            rho_u = 0
            if (j <= i) {
                rho_u = sum(ADmat[j:i, i] * (infl * Smat[j:i, i] - S))
            }
            F = S * infl
            Su = (Smat[j - 1, i + 1] * (C * infl - rho_u) - ADmat[j - 1, i] * S * 
                (F - Smat[j - 1, i + 1]))/(C * infl - rho_u - ADmat[j - 1, i] * (F - 
                Smat[j - 1, i + 1]))  # Upper node
            # Compensation
            if (j <= i) {
                if ((Su > infl * Smat[j, i]) || (Su < infl * S)) {
                  Su = Smat[j, i] * Smat[j - 1, i + 1]/Smat[j - 1, i]
                }
                if ((Su > infl * Smat[j, i]) || (Su < infl * S)) {
                  Su = infl * (Smat[j, i] + S)/2
                }
            } else {
                if ((Su > S * exp(2 * sigma * sqrt(dt))) || (Su < infl * S)) {
                  print("compensation j>=i")
                  Su = S * Smat[j - 1, i + 1]/Smat[j - 2, i]
                }
            }
            Smat[j, i + 1] = Su
        }
        
        # Step 3 : Find lower nodes of stock tree
        if ((llnode - 1) != 0) {
            for (j in seq(llnode - 1, 1)) {
                Call_Put_Flag = 0  # Put price
                S = Smat[j, i]  # S_n^i
                sigma = IBTimpliedvola(s0, S, i * dt, func)  # func=1 for interpolation, else a parabola
                P = IBTcrr(s0, S, r, sigma, i * dt, i, Call_Put_Flag)  # Put price from BS model
                rho_l = 0
                if (j > 1) {
                  rho_l = sum(ADmat[1:j - 1, i] * (S - infl * Smat[1:j - 1, i]))
                }
                F = S * infl
                Sl = (Smat[j + 1, i + 1] * (P * infl - rho_l) + ADmat[j, i] * S * 
                  (F - Smat[j + 1, i + 1]))/(P * infl - rho_l + ADmat[j, i] * (F - 
                  Smat[j + 1, i + 1]))  # Lower node
                  
                # Compensation 
                if (j > 1) {
                  if ((Sl < infl * Smat(j - 1, i)) || (Sl > infl * S)) {
                    Sl = Smat[j - 1, i] * Smat[j + 1, i + 1]/S
                  }
                  if ((Sl < infl * Smat(j - 1, i)) || (Sl > infl * S)) {
                    Sl = infl * (Smat[j - 1, i] + S)/2
                  }
                } else {
                  if ((Sl > infl * S) || (Sl < S * exp(-2 * sigma * sqrt(dt)))) {
                    Sl = S * Smat[j + 1, i + 1]/Smat[j + 1, i]
                  }
                }
                Smat[j, i + 1] = Sl
            }
        }
        
        # Step 4 : Find nodes of probability and Arrow Debreu tree
        # Transition probabilities
        pmat[1, 1] = (infl * Smat[1, 1] - Smat[1, 2])/(Smat[2, 2] - Smat[1, 2])
        if (i > 1) {
            pmat[1:i, i] = (infl * Smat[1:i, i] - Smat[1:i, i + 1])/(Smat[2:(i + 
                1), i + 1] - Smat[1:i, i + 1])
        }
        # Arrow-Debreu Prices 
        ADmat[1, i + 1] = ADmat[1, i] * (1 - pmat[1, i])/infl
        if (i > 1) {
            ADmat[2:i, i + 1] = (ADmat[2:i, i] * (1 - pmat[2:i, i]) + ADmat[1:(i - 
                1), i] * pmat[1:(i - 1), i])/infl
        }
        ADmat[i + 1, i + 1] = ADmat[i, i] * pmat[i, i]/infl
    }
    
    # Step 5 : Find nodes of implied local volatility tree
    LVmat = matrix(0, n, n)
    for (i in seq(1, n, 1)) {
        LVmat[1:i, i] = log(Smat[2:(i + 1), i + 1]/Smat[1:i, i + 1]) * (pmat[1:i, 
            i] * (1 - pmat[1:i, i]))^0.5  #
    }
    for (i in seq(1, n)) {
        M = pmat[1:i, i] * log(Smat[2:(i + 1), i + 1]/Smat[1:i, i]) + (1 - pmat[1:i, 
            i]) * log(Smat[1:i, i + 1]/Smat[1:i, i])
    }
    
    print(Smat)
    print(ADmat)
    print(pmat)
    print(LVmat)
    
    SFSIBTdk = list(S = Smat, p = pmat, AD = ADmat, LV = LVmat)
    
}  # function end 
