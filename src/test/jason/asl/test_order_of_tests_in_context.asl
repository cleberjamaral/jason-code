/**
 * Test how the order of tests in a context matters
 *
 * This test shows how the order of the tests in a context
 * matters. The test of the belief 'is_true' is done very
 * quickly, on the other hand, the test of a .sort() of a few
 * thousand of numeric elements can be slow due to the
 * computation complexity of a sorting process.
 * Notice that the belief 'is_true' is actually not defined,
 * i.e., in both contexts 'is_true' is evaluated as false which
 * turn the first plans g1 and g2 not relevant. In this sense,
 * the performed plans were the empty plans.
 *
 * So, as we can see, g2 is faster than g1.
 *
 * A sample output:
 * [test_order_of_tests_in_context] check_performance on event 'test_order_of_tests_in_context' starting at line 16: 8117 microseconds
 * [test_order_of_tests_in_context] check_performance on event 'test_order_of_tests_in_context' starting at line 16: 1002 microseconds
 * [test_order_of_tests_in_context] check_performance on event 'test_order_of_tests_in_context' starting at line 16: 3022 microseconds
 * [test_order_of_tests_in_context] check_performance on event 'test_order_of_tests_in_context' starting at line 16: 1114 microseconds
 * [test_order_of_tests_in_context] check_performance on event 'test_order_of_tests_in_context' starting at line 16: 2635 microseconds
 * [test_order_of_tests_in_context] check_performance on event 'test_order_of_tests_in_context' starting at line 16: 1033 microseconds
 * [test_order_of_tests_in_context] assert_greaterthan on event 'test_order_of_tests_in_context' PASSED
 */

{ include("$jasonJar/test/jason/inc/tester_agent.asl") }

!execute_test_plans.


//@[test] //uncomment this to run again
+!test_order_of_tests_in_context
    <-
    .findall(X, .random(X,3000), L);
    -+a_list(L);

     /**
      * Execute some batch of tests, get the average
      * nano_time, discard the first ones since the
      * first is usually harmed
      */
    !check_performance(g1,50,R1);
    !check_performance(g2,50,R2);

    !check_performance(g1,200,R3);
    !check_performance(g2,200,R4);

    !check_performance(g1,200,R5);
    !check_performance(g2,200,R6);

    /**
     * g1 should takes longer then g2
     */
    !assert_greaterthan(R3+R5,R4+R6);
.

+!g1 :
    a_list(L0) & .sort(L0, L1) & .min(L1, Mi) & .max(L1,Ma) &
    is_true
.
+!g1.

+!g2 :
    is_true &
    a_list(L0) & .sort(L0, L1) & .min(L1, Mi) & .max(L1,Ma)
.
+!g2.
