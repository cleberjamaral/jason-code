{ include("$jasonJar/test/jason/inc/tester_agent.asl") }

@[test]
+!test_pattern_queue
   <- !e;
      .wait(500);
      !assert_equals( 6, .count(run(_)))
.

// the pattern

+!e
    <- for ( .range(I,0,5) ) {
        .log(warning,I);
        !!g(I);
    }
.

+!g(I) :
    //not .intend( g(_) )
    not .intention(_,running,[im(_,{+!g(_)[_]},_,_)],_)
   <- +bel(I);
      //.findall(N,.intention(ID,running,[im(_,{+!g(N)[_]},_,_)],_),L1_1);
      //.log(warning,g(I)," ",L1_1);
      //.wait(50);
      !assert_equals( 1, .count(bel(_)));
      -bel(I);
      !assert_equals( 0, .count(bel(_)));
      +run(I);
      !!resume(g(_)).
+!g(I)
   <-
     //.findall(N,.intention(ID,running,[im(_,{+!g(N)[_]},_,_)],_),L1_1);
     //.log(warning,g(I)," - ",L1_1);
     .suspend;
      !!g(I).
+!resume(G)
   <-
   .wait(50);
   .resume(G).
