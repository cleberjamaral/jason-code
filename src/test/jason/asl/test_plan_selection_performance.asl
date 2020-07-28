/**
 * Test plan selection performance
 *
 * This test shows how plan selection process matters on
 * performance. In this simple test we have two similar
 * set of plans (g1(X) and g2(X)) that are triggered
 * differently by this experiment.
 * When triggering g1, we are providing a valid context
 * for the trigger which makes the first g1 relevant.
 * In the case of g2, we are providing a not valid
 * context for the trigger, which makes the second plan
 * be performed immediately. The only extra activity
 * the g1 is performing in this experiment is the
 * simple evaluation of a belief. Anyway, it is enough
 * to show that using specific triggers for different contexts
 * may significantly enhance the performance of the agent.
 * Of course, the performance can be dramatically impacted
 * if the test in the context is not a single
 * belief but something more computationally complex.
 *
 * So, as we can see, g2 is faster than g1.
 *
 * A sample output:
 * [test_plan_selection_performance] check_performance on event 'test_plan_selection_performance' starting at line 30: 2068 microseconds
 * [test_plan_selection_performance] check_performance on event 'test_plan_selection_performance' starting at line 30: 795 microseconds
 * [test_plan_selection_performance] check_performance on event 'test_plan_selection_performance' starting at line 30: 1456 microseconds
 * [test_plan_selection_performance] check_performance on event 'test_plan_selection_performance' starting at line 30: 1252 microseconds
 * [test_plan_selection_performance] check_performance on event 'test_plan_selection_performance' starting at line 30: 1028 microseconds
 * [test_plan_selection_performance] check_performance on event 'test_plan_selection_performance' starting at line 30: 956 microseconds
 * [test_plan_selection_performance] assert_greaterthan on event 'test_plan_selection_performance' PASSED
 */

{ include("$jasonJar/test/jason/inc/tester_agent.asl") }

!execute_test_plans.

//@[test] //uncomment this to run again
+!test_plan_selection_performance
    <-
     /**
      * Execute some batch of tests, get the average
      * nano_time, discard the first ones since the
      * first is usually harmed
      */
    !check_performance(g1(a),50,R1);
    !check_performance(g2(b),50,R2);

    !check_performance(g1(a),200,R3);
    !check_performance(g2(b),200,R4);

    !check_performance(g1(a),200,R5);
    !check_performance(g2(b),200,R6);

    /**
     * g1 should takes longer then g2
     */
    !assert_greaterthan(R3+R5,R4+R6);
.

+!g1(a) : is_true.
+!g1(X).

+!g2(a) : is_true.
+!g2(X).
