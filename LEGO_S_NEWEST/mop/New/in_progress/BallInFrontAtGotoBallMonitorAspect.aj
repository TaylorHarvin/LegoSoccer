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
	final void event_gotoball(Kicker MK, boolean gotoRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotoball(MK, gotoRes);
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
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
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

	Kicker currMK = null;

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

	final boolean Prop_1_event_gotoball(Kicker MK, boolean gotoRes) {
		{
			if ( ! (gotoRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Goto Ball EVENT: " + gotoRes);
			}
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_gotoball) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront(Kicker MK, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMK = MK;
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
			currMK.turnToBall();
			this.reset();
		}

	}

	final void reset() {
		this.pairValue.set(this.calculatePairValue(-1, 0) ) ;

		Prop_1_Category_violation = false;
	}

	// RVMRef_MK was suppressed to reduce memory overhead

	//alive_parameters_0 = [Kicker MK]
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
	private static Object BallInFrontAtGotoBall_MK_Map_cachekey_MK;
	private static BallInFrontAtGotoBallMonitor BallInFrontAtGotoBall_MK_Map_cachevalue;
	private static final MapOfMonitor<BallInFrontAtGotoBallMonitor> BallInFrontAtGotoBall_MK_Map = new MapOfMonitor<BallInFrontAtGotoBallMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += BallInFrontAtGotoBall_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void gotoballEvent(Kicker MK, boolean gotoRes) {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<BallInFrontAtGotoBallMonitor> matchedLastMap = null;
		BallInFrontAtGotoBallMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == BallInFrontAtGotoBall_MK_Map_cachekey_MK) ) {
			matchedEntry = BallInFrontAtGotoBall_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<BallInFrontAtGotoBallMonitor> itmdMap = BallInFrontAtGotoBall_MK_Map;
				matchedLastMap = itmdMap;
				BallInFrontAtGotoBallMonitor node_MK = BallInFrontAtGotoBall_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotoball(MK, gotoRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			BallInFrontAtGotoBall_MK_Map_cachekey_MK = MK;
			BallInFrontAtGotoBall_MK_Map_cachevalue = matchedEntry;
		}

		BallInFrontAtGotoBall_RVMLock.unlock();
	}

	public static final void ballinfrontEvent(Kicker MK, boolean res) {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<BallInFrontAtGotoBallMonitor> matchedLastMap = null;
		BallInFrontAtGotoBallMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == BallInFrontAtGotoBall_MK_Map_cachekey_MK) ) {
			matchedEntry = BallInFrontAtGotoBall_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<BallInFrontAtGotoBallMonitor> itmdMap = BallInFrontAtGotoBall_MK_Map;
				matchedLastMap = itmdMap;
				BallInFrontAtGotoBallMonitor node_MK = BallInFrontAtGotoBall_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront(MK, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			BallInFrontAtGotoBall_MK_Map_cachekey_MK = MK;
			BallInFrontAtGotoBall_MK_Map_cachevalue = matchedEntry;
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
	pointcut BallInFrontAtGotoBall_gotoball(Kicker MK) : (call(public boolean gotoBall()) && target(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean gotoRes) : BallInFrontAtGotoBall_gotoball(MK) {
		BallInFrontAtGotoBallRuntimeMonitor.gotoballEvent(MK, gotoRes);
	}

	pointcut BallInFrontAtGotoBall_ballinfront(Kicker MK) : (call(public boolean ballInFront(boolean)) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean res) : BallInFrontAtGotoBall_ballinfront(MK) {
		BallInFrontAtGotoBallRuntimeMonitor.ballinfrontEvent(MK, res);
	}

}
