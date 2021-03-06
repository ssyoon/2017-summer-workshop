## ------------------------------------------------------------------------
require(afex)
load("ssk16_dat_preapred.rda") # data preapred in 'prepare_data.R'
str(dat)
# 'data.frame':	2196 obs. of  8 variables:
# $ p_id       : Factor w/ 183 levels "102_P(if,then)",..: 63 63 63 63 63 63 63 63 63 63 ...
# $ i_id       : Factor w/ 12 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ CgivenA    : num  52 60 6 0 8 8 79 0 51 79 ...
# $ DV         : num  52 1 5 0 7 0 84 0 51 94 ...
# $ rel_cond   : Factor w/ 3 levels "PO","NE","IR": 1 3 2 2 2 2 1 3 3 1 ...
# $ dv_question: Factor w/ 2 levels "probability",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ dv         : num  0.02 -0.49 -0.45 -0.5 -0.43 -0.5 0.34 -0.5 0.01 0.44 ...
# $ c_given_a  : num  0.02 0.1 -0.44 -0.5 -0.42 -0.42 0.29 -0.5 0.01 0.29 ...

## ---- eval=FALSE---------------------------------------------------------
## mixed(dv ~ ...)

m_full <- mixed(dv ~ c_given_a*rel_cond*dv_question +
                  (rel_cond*c_given_a||p_id) +
                  (rel_cond*c_given_a*dv_question||i_id),
                dat, expand_re = TRUE,
                control = lmerControl(optCtrl = list(maxfun=1e8)),
                method = "S")
m_full
# Mixed Model Anova Table (Type 3 tests, S-method)
# 
# Model: dv ~ c_given_a * rel_cond * dv_question + (rel_cond * c_given_a || 
# Model:     p_id) + (rel_cond * c_given_a * dv_question || i_id)
# Data: dat
# Effect        df           F p.value
# 1                      c_given_a 1, 190.51 1091.33 ***  <.0001
# 2                       rel_cond  2, 23.40  163.62 ***  <.0001
# 3                    dv_question  1, 53.87        0.02     .88
# 4             c_given_a:rel_cond  2, 27.45   39.73 ***  <.0001
# 5          c_given_a:dv_question  1, 19.83        0.00     .95
# 6           rel_cond:dv_question  2, 29.67        2.20     .13
# 7 c_given_a:rel_cond:dv_question 2, 280.91      2.63 +     .07
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1

## ------------------------------------------------------------------------
data("fhch2010", package = "afex")
str(fhch2010)
# 'data.frame':	13222 obs. of  10 variables:
# $ id       : Factor w/ 45 levels "N1","N12","N13",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ task     : Factor w/ 2 levels "naming","lexdec": 1 1 1 1 1 1 1 1 1 1 ...
# $ stimulus : Factor w/ 2 levels "word","nonword": 1 1 1 2 2 1 2 2 1 2 ...
# $ density  : Factor w/ 2 levels "low","high": 2 1 1 2 1 2 1 1 1 1 ...
# $ frequency: Factor w/ 2 levels "low","high": 1 2 2 2 2 2 1 2 1 2 ...
# $ length   : Factor w/ 3 levels "4","5","6": 3 3 2 2 1 1 3 2 1 3 ...
# $ item     : Factor w/ 600 levels "abide","acts",..: 363 121 202 525 580 135 42 368 227 141 ...
# $ rt       : num  1.091 0.876 0.71 1.21 0.843 ...
# $ log_rt   : num  0.0871 -0.1324 -0.3425 0.1906 -0.1708 ...
# $ correct  : logi  TRUE TRUE TRUE TRUE TRUE TRUE ...

## ---- eval=FALSE---------------------------------------------------------
## mixed(log_rt ~ ...)
## 

m_fhch <- mixed(log_rt ~ task*stimulus*density*frequency*length + 
                  (stimulus*density*frequency*length||id) +
                  (task||item), fhch2010, 
                method = "S", expand_re = TRUE)
