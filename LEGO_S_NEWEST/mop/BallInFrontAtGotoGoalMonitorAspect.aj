package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.lang.ref.*;
import com.runtimeverification.rvmonitor.java.rt.*;
import com.runtimeverification.rvmonitor.java.rt.ref.*;
import com.runtimeverification.rvmonitor.java.rt.table.*;
import com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractIndexingTree;
import com.runtimeverification.rvmonitor.java.rt.tablebase.SetEventDelegator;
import com.runtimeverification.rvmonitor.java.rt.tablebase.TableAdopter.Tuple2;
import com.runtimeverification.rvmonitor.java.rt.tablebase.TableAdopter.Tuple3;
import com.runtimeverification.rvmonitor.java.rt.tablebase.IDisableHolder;
import com.runtimeverification.rvmonitor.java.rt.tablebase.IMonitor;
import com.runtimeverification.rvmonitor.java.rt.tablebase.DisableHolder;
import com.runtimeverification.rvmonitor.java.rt.tablebase.TerminatedMonitorCleaner;
import java.util.concurrent.atomic.AtomicInteger;
import org.aspectj.lang.*;

final class BallInFrontAtGotoGoalMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<BallInFrontAtGotoGoalMonitor> {

	BallInFrontAtGotoGoalMonitor_Set(){
		this.size = 0;
		this.elements = new BallInFrontAtGotoGoalMonitor[4];
	}
	final void event_gotogoal(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoGoalMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoGoalMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotogoal(MK);
				if(monitorfinalMonitor.Prop_1_Category_violation) {
					monitorfinalMonitor.Prop_1_handler_violation();
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_ballinfront(Kicker MK, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoGoalMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoGoalMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront(MK, res);
				if(monitorfinalMonitor.Prop_1_Category_violation) {
					monitorfinalMonitor.Prop_1_handler_violation();
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

interface IBallInFrontAtGotoGoalMonitor extends IMonitor, IDisableHolder {
}

class BallInFrontAtGotoGoalDisableHolder extends DisableHolder implements IBallInFrontAtGotoGoalMonitor {
	BallInFrontAtGotoGoalDisableHolder(long tau) {
		super(tau);
	}

	@Override
	public final boolean isTerminated() {
		return false;
	}

	@Override
	public int getLastEvent() {
		return -1;
	}

	@Override
	public int getState() {
		return -1;
	}

}

class BallInFrontAtGotoGoalMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject, IBallInFrontAtGotoGoalMonitor {
	protected Object clone() {
		try {
			BallInFrontAtGotoGoalMonitor ret = (BallInFrontAtGotoGoalMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	WeakReference Ref_MC = null;
	int Prop_1_state;
	static final int Prop_1_transition_gotogoal[] = {1, 2, 2};;
	static final int Prop_1_transition_ballinfront[] = {0, 2, 2};;

	boolean Prop_1_Category_violation = false;

	BallInFrontAtGotoGoalMonitor(long tau) {
		this.tau = tau;
		Prop_1_state = 0;

	}

	@Override
	public final int getState() {
		return Prop_1_state;
	}

	private final long tau;
	private long disable = -1;

	@Override
	public final long getTau() {
		return this.tau;
	}

	@Override
	public final long getDisable() {
		return this.disable;
	}

	@Override
	public final void setDisable(long value) {
		this.disable = value;
	}

	final boolean Prop_1_event_gotogoal(Kicker MK) {
		MotionControl MC = null;
		if(Ref_MC != null){
			MC = (MotionControl)Ref_MC.get();
		}
		{
			System.out.println("Ball in front true");
		}
		RVM_lastevent = 0;

		Prop_1_state = Prop_1_transition_gotogoal[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final boolean Prop_1_event_ballinfront(Kicker MK, boolean res) {
		MotionControl MC = null;
		if(Ref_MC != null){
			MC = (MotionControl)Ref_MC.get();
		}
		{
			if ( ! (res) ) {
				return false;
			}
			{
				System.out.println("Ball in front true");
			}
		}
		RVM_lastevent = 1;

		Prop_1_state = Prop_1_transition_ballinfront[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!BallInFrontAtGotoGoal FAIL!!!");
		}

	}

	final void reset() {
		RVM_lastevent = -1;
		Prop_1_state = 0;
		Prop_1_Category_violation = false;
	}

	// RVMRef_MK was suppressed to reduce memory overhead
	// RVMRef_MC was suppressed to reduce memory overhead

	//alive_parameters_0 = [Kicker MK]
	boolean alive_parameters_0 = true;

	@Override
	protected final void terminateInternal(int idnum) {
		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
			case 1:
			break;
		}
		switch(RVM_lastevent) {
			case -1:
			return;
			case 0:
			//gotogoal
			return;
			case 1:
			//ballinfront
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

		}
		return;
	}

	public static int getNumberOfEvents() {
		return 2;
	}

	public static int getNumberOfStates() {
		return 3;
	}

}

class BallInFrontAtGotoGoalRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager BallInFrontAtGotoGoalMapManager;
	static {
		BallInFrontAtGotoGoalMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		BallInFrontAtGotoGoalMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock BallInFrontAtGotoGoal_RVMLock = new ReentrantLock();
	static final Condition BallInFrontAtGotoGoal_RVMLock_cond = BallInFrontAtGotoGoal_RVMLock.newCondition();

	// Declarations for Timestamps
	private static long BallInFrontAtGotoGoal_timestamp = 1;

	private static boolean BallInFrontAtGotoGoal_activated = false;

	// Declarations for Indexing Trees
	private static Object BallInFrontAtGotoGoal_MK_Map_cachekey_MK;
	private static Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor> BallInFrontAtGotoGoal_MK_Map_cachevalue;
	private static final MapOfSetMonitor<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor> BallInFrontAtGotoGoal_MK_Map = new MapOfSetMonitor<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += BallInFrontAtGotoGoal_MK_Map.cleanUpUnnecessaryMappings();
		return collected;
	}

	// Removing terminated monitors from partitioned sets
	static {
		TerminatedMonitorCleaner.start() ;
	}
	// Setting the behavior of the runtime library according to the compile-time option
	static {
		RuntimeOption.enableFineGrainedLock(false) ;
	}

	public static final void gotogoalEvent(Kicker MK) {
		BallInFrontAtGotoGoal_activated = true;
		while (!BallInFrontAtGotoGoal_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MK == BallInFrontAtGotoGoal_MK_Map_cachekey_MK) ) {
			matchedEntry = BallInFrontAtGotoGoal_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor> node_MK = BallInFrontAtGotoGoal_MK_Map.getNodeEquivalent(wr_MK) ;
				if ((node_MK == null) ) {
					node_MK = new Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor>() ;
					BallInFrontAtGotoGoal_MK_Map.putNode(wr_MK, node_MK) ;
					node_MK.setValue1(new BallInFrontAtGotoGoalMonitor_Set() ) ;
				}
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		BallInFrontAtGotoGoalMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				BallInFrontAtGotoGoalMonitor created = new BallInFrontAtGotoGoalMonitor(BallInFrontAtGotoGoal_timestamp++) ;
				matchedEntry.setValue2(created) ;
				BallInFrontAtGotoGoalMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			BallInFrontAtGotoGoalMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(BallInFrontAtGotoGoal_timestamp++) ;
		}
		// D(X) main:8--9
		BallInFrontAtGotoGoalMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_gotogoal(MK);

		if ((cachehit == false) ) {
			BallInFrontAtGotoGoal_MK_Map_cachekey_MK = MK;
			BallInFrontAtGotoGoal_MK_Map_cachevalue = matchedEntry;
		}

		BallInFrontAtGotoGoal_RVMLock.unlock();
	}

	public static final void ballinfrontEvent(Kicker MK, boolean res) {
		BallInFrontAtGotoGoal_activated = true;
		while (!BallInFrontAtGotoGoal_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MK == BallInFrontAtGotoGoal_MK_Map_cachekey_MK) ) {
			matchedEntry = BallInFrontAtGotoGoal_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor> node_MK = BallInFrontAtGotoGoal_MK_Map.getNodeEquivalent(wr_MK) ;
				if ((node_MK == null) ) {
					node_MK = new Tuple2<BallInFrontAtGotoGoalMonitor_Set, BallInFrontAtGotoGoalMonitor>() ;
					BallInFrontAtGotoGoal_MK_Map.putNode(wr_MK, node_MK) ;
					node_MK.setValue1(new BallInFrontAtGotoGoalMonitor_Set() ) ;
				}
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		BallInFrontAtGotoGoalMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				BallInFrontAtGotoGoalMonitor created = new BallInFrontAtGotoGoalMonitor(BallInFrontAtGotoGoal_timestamp++) ;
				matchedEntry.setValue2(created) ;
				BallInFrontAtGotoGoalMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			BallInFrontAtGotoGoalMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(BallInFrontAtGotoGoal_timestamp++) ;
		}
		// D(X) main:8--9
		BallInFrontAtGotoGoalMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_ballinfront(MK, res);

		if ((cachehit == false) ) {
			BallInFrontAtGotoGoal_MK_Map_cachekey_MK = MK;
			BallInFrontAtGotoGoal_MK_Map_cachevalue = matchedEntry;
		}

		BallInFrontAtGotoGoal_RVMLock.unlock();
	}

}


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

	pointcut BallInFrontAtGotoGoal_ballinfront(Kicker MK) : (call(public boolean BallInFront()) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean res) : BallInFrontAtGotoGoal_ballinfront(MK) {
		BallInFrontAtGotoGoalRuntimeMonitor.ballinfrontEvent(MK, res);
	}

}
