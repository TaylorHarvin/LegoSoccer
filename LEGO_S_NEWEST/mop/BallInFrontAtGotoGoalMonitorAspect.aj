package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
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

public aspect BallInFrontAtGotoGoalMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public BallInFrontAtGotoGoalMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock BallInFrontAtGotoGoal_MOPLock = new ReentrantLock();
	static Condition BallInFrontAtGotoGoal_MOPLock_cond = BallInFrontAtGotoGoal_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut BallInFrontAtGotoGoal_gotogoal(Kicker MK) : (call(private boolean GotoGoal(boolean)) && target(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : BallInFrontAtGotoGoal_gotogoal(MK) {
		BallInFrontAtGotoGoalRuntimeMonitor.gotogoalEvent(MK);
	}

	pointcut BallInFrontAtGotoGoal_ballinfront(MotionControl MC) : (call(public boolean MotionControl.BallInFront()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : BallInFrontAtGotoGoal_ballinfront(MC) {
		BallInFrontAtGotoGoalRuntimeMonitor.ballinfrontEvent(MC, res);
	}

}
