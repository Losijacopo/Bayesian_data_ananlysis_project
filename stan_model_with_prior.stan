//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//


data {
  // Define variables in data
  // Number of observations (an integer)
  int<lower=0> N;
  
  // Number of parameters
  int<lower=0> p;
  
  // Variables
  real<lower=0> age[N]; 
  int<lower=0>  died[N];
  int<lower=0>  sex[N];
  int<lower=0>  job[N];
  int<lower=0>  urban[N];
  int<lower=0>  edu[N];
}
 
parameters {
  // Define parameters to estimate
  real beta[p];
  
  // standard deviation (a positve real number)
  real<lower=0> sigma;
}
 
transformed parameters  {
  // Mean
  real mu[N];
  for (i in 1:N) {
    mu[i] = beta[1] + beta[2]*died[i] + beta[3]*sex[i] + beta[4]*job[i] +
            beta[5]*urban[i] + beta[6]*edu[i];
  }
}
 
model {
  // Weakly informative prior
  //mu ~ normal(0.5, 10);
  sigma ~ normal(0,10);
  
  // Likelihood part of the Bayesian inference
  age ~ normal(mu, sigma);

}

generated quantities{
  vector[N] log_lik;
    
  for (i in 1:N)
    log_lik[i] = normal_lpdf(age[i] | mu[i], sigma);
    
}
