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

final class BallInFrontAtGotoBallMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<BallInFrontAtGotoBallMonitor> {

	BallInFrontAtGotoBallMonitor_Set(){
		this.size = 0;
		this.elements = new BallInFrontAtGotoBallMonitor[4];
	}
	final void event_gotoball(MotionControl MC, boolean gotoRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotoball(MC, gotoRes);
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
	final void event_ballinfront(MotionControl MC, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront(MC, res);
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

class BallInFrontAtGotoBallMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			BallInFrontAtGotoBallMonitor ret = (BallInFrontAtGotoBallMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	MotionControl currMC = null;

	static final int Prop_1_transition_gotoball[] = {1, 2, 2};;
	static final int Prop_1_transition_ballinfront[] = {0, 2, 2};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	BallInFrontAtGotoBallMonitor() {
		this.pairValue = new AtomicInteger(this.calculatePairValue(-1, 0) ) ;

	}

	@Override public final int getState() {
		return this.getState(this.pairValue.get() ) ;
	}
	@Override public final int getLastEvent() {
		return this.getLastEvent(this.pairValue.get() ) ;
	}
	private final int getState(int pairValue) {
		return (pairValue & 3) ;
	}
	private final int getLastEvent(int pairValue) {
		return (pairValue >> 2) ;
	}
	private final int calculatePairValue(int lastEvent, int state) {
		return (((lastEvent + 1) << 2) | state) ;
	}

	private final int handleEvent(int eventId, int[] table) {
		int nextstate;
		while (true) {
			int oldpairvalue = this.pairValue.get() ;
			int oldstate = this.getState(oldpairvalue) ;
			nextstate = table [ oldstate ];
			int nextpairvalue = this.calculatePairValue(eventId, nextstate) ;
			if (this.pairValue.compareAndSet(oldpairvalue, nextpairvalue) ) {
				break;
			}
		}
		return nextstate;
	}

	final boolean Prop_1_event_gotoball(MotionControl MC, boolean gotoRes) {
		{
			if ( ! (gotoRes) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Goto Ball EVENT: " + gotoRes);
				System.out.println("Ball in front:" + MC.mainSC.BallInFront());
			}
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_gotoball) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront(MotionControl MC, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Ball in front: " + res);
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_ballinfront) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!BallInFrontAtGoto LTL FAIL!!!");
			System.out.println("Re-Attempting FindAndGrabBall");
			currMC.TurnToBall();
			this.reset();
		}

	}

	final void reset() {
		this.pairValue.set(this.calculatePairValue(-1, 0) ) ;

		Prop_1_Category_violation = false;
	}

	// RVMRef_MC was suppressed to reduce memory overhead

	//alive_parameters_0 = [MotionControl MC]
	boolean alive_parameters_0 = true;

	@Override
	protected final void terminateInternal(int idnum) {
		int lastEvent = this.getLastEvent();

		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
		}
		switch(lastEvent) {
			case -1:
			return;
			case 0:
			//gotoball
			return;
			case 1:
			//ballinfront
			//alive_MC
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

class BallInFrontAtGotoBallRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager BallInFrontAtGotoBallMapManager;
	static {
		BallInFrontAtGotoBallMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		BallInFrontAtGotoBallMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock BallInFrontAtGotoBall_RVMLock = new ReentrantLock();
	static final Condition BallInFrontAtGotoBall_RVMLock_cond = BallInFrontAtGotoBall_RVMLock.newCondition();

	private static boolean BallInFrontAtGotoBall_activated = false;

	// Declarations for Indexing Trees
	private static Object BallInFrontAtGotoBall_MC_Map_cachekey_MC;
	private static BallInFrontAtGotoBallMonitor BallInFrontAtGotoBall_MC_Map_cachevalue;
	private static final MapOfMonitor<BallInFrontAtGotoBallMonitor> BallInFrontAtGotoBall_MC_Map = new MapOfMonitor<BallInFrontAtGotoBallMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += BallInFrontAtGotoBall_MC_Map.cleanUpUnnecessaryMappings();
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

	public static final void gotoballEvent(MotionControl MC, boolean gotoRes) {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<BallInFrontAtGotoBallMonitor> matchedLastMap = null;
		BallInFrontAtGotoBallMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == BallInFrontAtGotoBall_MC_Map_cachekey_MC) ) {
			matchedEntry = BallInFrontAtGotoBall_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<BallInFrontAtGotoBallMonitor> itmdMap = BallInFrontAtGotoBall_MC_Map;
				matchedLastMap = itmdMap;
				BallInFrontAtGotoBallMonitor node_MC = BallInFrontAtGotoBall_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotoball(MC, gotoRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			BallInFrontAtGotoBall_MC_Map_cachekey_MC = MC;
			BallInFrontAtGotoBall_MC_Map_cachevalue = matchedEntry;
		}

		BallInFrontAtGotoBall_RVMLock.unlock();
	}

	public static final void ballinfrontEvent(MotionControl MC, boolean res) {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<BallInFrontAtGotoBallMonitor> matchedLastMap = null;
		BallInFrontAtGotoBallMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == BallInFrontAtGotoBall_MC_Map_cachekey_MC) ) {
			matchedEntry = BallInFrontAtGotoBall_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<BallInFrontAtGotoBallMonitor> itmdMap = BallInFrontAtGotoBall_MC_Map;
				matchedLastMap = itmdMap;
				BallInFrontAtGotoBallMonitor node_MC = BallInFrontAtGotoBall_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront(MC, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			BallInFrontAtGotoBall_MC_Map_cachekey_MC = MC;
			BallInFrontAtGotoBall_MC_Map_cachevalue = matchedEntry;
		}

		BallInFrontAtGotoBall_RVMLock.unlock();
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

public aspect BallInFrontAtGotoBallMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public BallInFrontAtGotoBallMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock BallInFrontAtGotoBall_MOPLock = new ReentrantLock();
	static Condition BallInFrontAtGotoBall_MOPLock_cond = BallInFrontAtGotoBall_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut BallInFrontAtGotoBall_gotoball(MotionControl MC) : (call(public boolean GotoBall()) && target(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean gotoRes) : BallInFrontAtGotoBall_gotoball(MC) {
		BallInFrontAtGotoBallRuntimeMonitor.gotoballEvent(MC, gotoRes);
	}

	pointcut BallInFrontAtGotoBall_ballinfront(MotionControl MC) : (call(public boolean BallInFront()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : BallInFrontAtGotoBall_ballinfront(MC) {
		BallInFrontAtGotoBallRuntimeMonitor.ballinfrontEvent(MC, res);
	}

}
