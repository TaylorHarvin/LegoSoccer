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

final class TurnToGoalAfterGotoMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<TurnToGoalAfterGotoMonitor> {

	TurnToGoalAfterGotoMonitor_Set(){
		this.size = 0;
		this.elements = new TurnToGoalAfterGotoMonitor[4];
	}
	final void event_gotogoal(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			TurnToGoalAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final TurnToGoalAfterGotoMonitor monitorfinalMonitor = monitor;
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
	final void event_wonder_success(Kicker MK, boolean wonderRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			TurnToGoalAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final TurnToGoalAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_wonder_success(MK, wonderRes);
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
	final void event_wonder_fail(Kicker MK, boolean wonderRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			TurnToGoalAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final TurnToGoalAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_wonder_fail(MK, wonderRes);
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

class TurnToGoalAfterGotoMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			TurnToGoalAfterGotoMonitor ret = (TurnToGoalAfterGotoMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	Kicker currMK = null;

	static final int Prop_1_transition_gotogoal[] = {0, 0, 3, 3};;
	static final int Prop_1_transition_wonder_success[] = {1, 2, 3, 3};;
	static final int Prop_1_transition_wonder_fail[] = {0, 2, 3, 3};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	TurnToGoalAfterGotoMonitor() {
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

	final boolean Prop_1_event_gotogoal(Kicker MK) {
		{
			System.out.println("GotoGoal EVENT");
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_gotogoal) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_wonder_success(Kicker MK, boolean wonderRes) {
		{
			if ( ! (wonderRes) ) {
				return false;
			}
			{
				System.out.println("Wonder success: " + wonderRes);
				currMK = MK;
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_wonder_success) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_wonder_fail(Kicker MK, boolean wonderRes) {
		{
			if ( ! (!wonderRes) ) {
				return false;
			}
			{
				System.out.println("Wonder fail: " + wonderRes);
				currMK = MK;
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_wonder_fail) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!GOTO_GOAL LTL FAIL!!!");
			System.out.println("Applying Recovery Goto");
			currMK.gotoGoal(true);
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
			//gotogoal
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//wonder_success
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//wonder_fail
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
		return 3;
	}

	public static int getNumberOfStates() {
		return 4;
	}

}

class TurnToGoalAfterGotoRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager TurnToGoalAfterGotoMapManager;
	static {
		TurnToGoalAfterGotoMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		TurnToGoalAfterGotoMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock TurnToGoalAfterGoto_RVMLock = new ReentrantLock();
	static final Condition TurnToGoalAfterGoto_RVMLock_cond = TurnToGoalAfterGoto_RVMLock.newCondition();

	private static boolean TurnToGoalAfterGoto_activated = false;

	// Declarations for Indexing Trees
	private static Object TurnToGoalAfterGoto_MK_Map_cachekey_MK;
	private static TurnToGoalAfterGotoMonitor TurnToGoalAfterGoto_MK_Map_cachevalue;
	private static final MapOfMonitor<TurnToGoalAfterGotoMonitor> TurnToGoalAfterGoto_MK_Map = new MapOfMonitor<TurnToGoalAfterGotoMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += TurnToGoalAfterGoto_MK_Map.cleanUpUnnecessaryMappings();
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
		TurnToGoalAfterGoto_activated = true;
		while (!TurnToGoalAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<TurnToGoalAfterGotoMonitor> matchedLastMap = null;
		TurnToGoalAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == TurnToGoalAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = TurnToGoalAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<TurnToGoalAfterGotoMonitor> itmdMap = TurnToGoalAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				TurnToGoalAfterGotoMonitor node_MK = TurnToGoalAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			TurnToGoalAfterGotoMonitor created = new TurnToGoalAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final TurnToGoalAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotogoal(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			TurnToGoalAfterGoto_MK_Map_cachekey_MK = MK;
			TurnToGoalAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		TurnToGoalAfterGoto_RVMLock.unlock();
	}

	public static final void wonder_successEvent(Kicker MK, boolean wonderRes) {
		TurnToGoalAfterGoto_activated = true;
		while (!TurnToGoalAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<TurnToGoalAfterGotoMonitor> matchedLastMap = null;
		TurnToGoalAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == TurnToGoalAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = TurnToGoalAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<TurnToGoalAfterGotoMonitor> itmdMap = TurnToGoalAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				TurnToGoalAfterGotoMonitor node_MK = TurnToGoalAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			TurnToGoalAfterGotoMonitor created = new TurnToGoalAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final TurnToGoalAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_wonder_success(MK, wonderRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			TurnToGoalAfterGoto_MK_Map_cachekey_MK = MK;
			TurnToGoalAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		TurnToGoalAfterGoto_RVMLock.unlock();
	}

	public static final void wonder_failEvent(Kicker MK, boolean wonderRes) {
		TurnToGoalAfterGoto_activated = true;
		while (!TurnToGoalAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<TurnToGoalAfterGotoMonitor> matchedLastMap = null;
		TurnToGoalAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == TurnToGoalAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = TurnToGoalAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<TurnToGoalAfterGotoMonitor> itmdMap = TurnToGoalAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				TurnToGoalAfterGotoMonitor node_MK = TurnToGoalAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			TurnToGoalAfterGotoMonitor created = new TurnToGoalAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final TurnToGoalAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_wonder_fail(MK, wonderRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			TurnToGoalAfterGoto_MK_Map_cachekey_MK = MK;
			TurnToGoalAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		TurnToGoalAfterGoto_RVMLock.unlock();
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

public aspect TurnToGoalAfterGotoMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public TurnToGoalAfterGotoMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock TurnToGoalAfterGoto_MOPLock = new ReentrantLock();
	static Condition TurnToGoalAfterGoto_MOPLock_cond = TurnToGoalAfterGoto_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut TurnToGoalAfterGoto_gotogoal(Kicker MK) : (call(public boolean gotoGoal(boolean)) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : TurnToGoalAfterGoto_gotogoal(MK) {
		TurnToGoalAfterGotoRuntimeMonitor.gotogoalEvent(MK);
	}

	pointcut TurnToGoalAfterGoto_wonder_success(Kicker MK) : (call(public boolean wonder()) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean wonderRes) : TurnToGoalAfterGoto_wonder_success(MK) {
		//TurnToGoalAfterGoto_wonder_success
		TurnToGoalAfterGotoRuntimeMonitor.wonder_successEvent(MK, wonderRes);
		//TurnToGoalAfterGoto_wonder_fail
		TurnToGoalAfterGotoRuntimeMonitor.wonder_failEvent(MK, wonderRes);
	}

}
