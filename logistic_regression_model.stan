data {
  // Define variables in data
  // Number of observations (an integer)
  int<lower=0> N;
  
  // Number of parameters
  int<lower=0> p;
  
  // Variables
  int  died[N];
  int<lower=0>  urban[N];
  int<lower=0>  year[N];
  int<lower=0>  season[N];
  int<lower=0>  sex[N];
  int<lower=0>  age[N];
  int<lower=0>  edu[N];
  int<lower=0>  job[N];
  int<lower=0>  method[N];
}
 
parameters {
  // Define parameters to estimate
  real beta[p];
}
 
transformed parameters  {
  // Probability trasformation from linear predictor
  real<lower=0> odds[N];
  real<lower=0, upper=1> prob[N];
  for (i in 1:N) {
    odds[i] = exp(beta[1] + beta[2]*urban[i]  + beta[3]*year[i] + 
                            beta[4]*season[i] + beta[5]*sex[i]  + 
                            beta[6]*age[i]    + beta[7]*edu[i]  +
                            beta[8]*job[i]    + beta[9]*method[i] );
    prob[i] = odds[i] / (odds[i] + 1);
  }
}
 
model {
  // Prior part of Bayesian inference (flat if unspecified)
 
  // Likelihood part of Bayesian inference
    died ~ bernoulli(prob);
}
