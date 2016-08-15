
import java.io.*;
import java.util.*;
import fullSoccer.*;
import stateTools.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;

import java.lang.ref.*;
import org.aspectj.lang.*;

aspect BaseAspect {
	pointcut notwithin() :
	!within(sun..*) &&
	!within(java..*) &&
	!within(javax..*) &&
	!within(com.sun..*) &&
	!within(org.dacapo.harness..*) &&
	!within(org.apache.commons..*) &&
	!within(org.apache.geronimo..*) &&
	!within(net.sf.cglib..*) &&
	!within(mop..*) &&
	!within(javamoprt..*) &&
	!within(rvmonitorrt..*) &&
	!within(com.runtimeverification..*);
}

public aspect testMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public testMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock test_MOPLock = new ReentrantLock();
	static Condition test_MOPLock_cond = test_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut test_kickballatgoalstate_enter(Kicker MK) : (call(public boolean StateCheck.KickBallAtGoal(Kicker)) && args(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_kickballatgoalstate_enter(MK) {
		testRuntimeMonitor.kickballatgoalstate_enterEvent(MK);
	}

	pointcut test_dribbleballstate_enter(Kicker MK) : (call(public boolean StateCheck.DribbleBallState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_dribbleballstate_enter(MK) {
		testRuntimeMonitor.dribbleballstate_enterEvent(MK);
	}

	pointcut test_gotoballstate_enter(Kicker MK) : (call(public boolean StateCheck.GotoBallState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_gotoballstate_enter(MK) {
		testRuntimeMonitor.gotoballstate_enterEvent(MK);
	}

	pointcut test_wonderstate_enter(Kicker MK) : (call(public boolean StateCheck.WonderState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_wonderstate_enter(MK) {
		testRuntimeMonitor.wonderstate_enterEvent(MK);
	}

	pointcut test_wonderstate_true(Kicker MK) : (call(public boolean StateCheck.WonderState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean wonderCheckRes) : test_wonderstate_true(MK) {
		//test_wonderstate_true
		testRuntimeMonitor.wonderstate_trueEvent(MK, wonderCheckRes);
		//test_wonderstate_false
		testRuntimeMonitor.wonderstate_falseEvent(MK, wonderCheckRes);
	}

	pointcut test_gotoballstate_false(Kicker MK) : (call(public boolean StateCheck.GotoBallState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean gtbCheckRes) : test_gotoballstate_false(MK) {
		testRuntimeMonitor.gotoballstate_falseEvent(MK, gtbCheckRes);
	}

	pointcut test_dribbleballstate_true(Kicker MK) : (call(public boolean StateCheck.DribbleBallState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean dbCheckRes) : test_dribbleballstate_true(MK) {
		//test_dribbleballstate_true
		testRuntimeMonitor.dribbleballstate_trueEvent(MK, dbCheckRes);
		//test_dribbleballstate_false
		testRuntimeMonitor.dribbleballstate_falseEvent(MK, dbCheckRes);
	}

	pointcut test_kickballatgoalstate_true(Kicker MK) : (call(public boolean StateCheck.KickBallAtGoal(Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean kbgCheckRes) : test_kickballatgoalstate_true(MK) {
		//test_kickballatgoalstate_true
		testRuntimeMonitor.kickballatgoalstate_trueEvent(MK, kbgCheckRes);
		//test_kickballatgoalstate_false
		testRuntimeMonitor.kickballatgoalstate_falseEvent(MK, kbgCheckRes);
	}

	pointcut test_ballclose_true(Kicker MK) : (call(public boolean Kicker.ballClose(boolean, float)) && target(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean ballCloseRes) : test_ballclose_true(MK) {
		//test_ballclose_true
		testRuntimeMonitor.ballclose_trueEvent(MK, ballCloseRes);
		//test_ballclose_false
		testRuntimeMonitor.ballclose_falseEvent(MK, ballCloseRes);
	}

}
