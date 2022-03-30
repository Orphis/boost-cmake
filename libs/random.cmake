_add_boost_lib(
  NAME random
  SOURCES
    ${boost_SOURCE_DIR}/libs/random/src/random_device.cpp
)

_add_boost_test(
  NAME random_test
  LINK
    Boost::random
    Boost::unit_test_framework
  TESTS
    RUN ${boost_SOURCE_DIR}/libs/random/test/histogram.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/multiprecision_float_test.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/multiprecision_int_test.cpp
    # RUN ${boost_SOURCE_DIR}/libs/random/test/statistic_tests.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_bernoulli.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_bernoulli_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_beta.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_beta_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_binomial.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_binomial_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_cauchy.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_cauchy_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_chi_squared.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_chi_squared_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_const_mod.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_discrete.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_discrete_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ecuyer1988.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_exponential.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_exponential_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_extreme_value.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_extreme_value_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_fisher_f.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_fisher_f_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_gamma.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_gamma_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_generate_canonical.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_geometric.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_geometric_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_hellekalek1995.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_hyperexponential.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_hyperexponential_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_independent_bits31.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_independent_bits32.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_knuth_b.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_kreutzer1986.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci1279.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci19937.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci2281.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci23209.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci3217.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci4423.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci44497.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci607.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lagged_fibonacci9689.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_laplace.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_laplace_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_linear_feedback_shift.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lognormal.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_lognormal_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_minstd_rand.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_minstd_rand0.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_mt11213b.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_mt19937.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_mt19937_64.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_negative_binomial.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_negative_binomial_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_non_central_chi_squared.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_non_central_chi_squared_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_normal.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_normal_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_old_uniform_int.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_old_uniform_int_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_old_uniform_real.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_old_uniform_real_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_piecewise_constant.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_piecewise_constant_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_piecewise_linear.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_piecewise_linear_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_poisson.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_poisson_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_rand48.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_random_device.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_random_number_generator.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux24.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux24_base.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux3.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux3_01.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux4.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux48.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux48_base.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux4_01.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux64_3.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux64_3_01.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux64_4.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_ranlux64_4_01.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_seed_seq.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_student_t.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_student_t_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_taus88.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_triangle.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_triangle_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_int.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_int_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_on_sphere.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_on_sphere_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_real.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_real_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_smallint.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_uniform_smallint_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_weibull.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_weibull_distribution.cpp
    RUN ${boost_SOURCE_DIR}/libs/random/test/test_zero_seed.cpp
)
