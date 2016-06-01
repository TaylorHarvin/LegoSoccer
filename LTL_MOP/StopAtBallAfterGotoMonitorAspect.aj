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

final class StopAtBallAfterGotoMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<StopAtBallAfterGotoMonitor> {

	StopAtBallAfterGotoMonitor_Set(){
		this.size = 0;
		this.elements = new StopAtBallAfterGotoMonitor[4];
	}
	final void event_gotoball(MotionControl MC, boolean gotoRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
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
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
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
	final void event_ballclose(MotionControl MC, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballclose(MC, res);
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

class StopAtBallAfterGotoMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			StopAtBallAfterGotoMonitor ret = (StopAtBallAfterGotoMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	MotionControl currMC = null;

	boolean ballInFrontFlag = false;

	boolean ballCloseFlag = false;

	static final int Prop_1_transition_gotoball[] = {0, 2, 2};;
	static final int Prop_1_transition_ballinfront[] = {1, 2, 2};;
	static final int Prop_1_transition_ballclose[] = {1, 2, 2};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	StopAtBallAfterGotoMonitor() {
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

	final boolean Prop_1_event_ballclose(MotionControl MC, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Ball close event: " + res);
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_ballclose) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!StopAtBallAfterGoto LTL FAIL!!!");
			System.out.println("!!!STOPPING ROBOT!!!");
			currMC.FindAndGrabBall();
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
			//alive_MC
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//ballinfront
			return;
			case 2:
			//ballclose
			return;
		}
		return;
	}

	public static int getNumberOfEvents() {
		return 3;
	}

	public static int getNumberOfStates() {
		return 3;
	}

}

class StopAtBallAfterGotoRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager StopAtBallAfterGotoMapManager;
	static {
		StopAtBallAfterGotoMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		StopAtBallAfterGotoMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock StopAtBallAfterGoto_RVMLock = new ReentrantLock();
	static final Condition StopAtBallAfterGoto_RVMLock_cond = StopAtBallAfterGoto_RVMLock.newCondition();

	private static boolean StopAtBallAfterGoto_activated = false;

	// Declarations for Indexing Trees
	private static Object StopAtBallAfterGoto_MC_Map_cachekey_MC;
	private static StopAtBallAfterGotoMonitor StopAtBallAfterGoto_MC_Map_cachevalue;
	private static final MapOfMonitor<StopAtBallAfterGotoMonitor> StopAtBallAfterGoto_MC_Map = new MapOfMonitor<StopAtBallAfterGotoMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += StopAtBallAfterGoto_MC_Map.cleanUpUnnecessaryMappings();
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
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == StopAtBallAfterGoto_MC_Map_cachekey_MC) ) {
			matchedEntry = StopAtBallAfterGoto_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MC_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MC = StopAtBallAfterGoto_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotoball(MC, gotoRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MC_Map_cachekey_MC = MC;
			StopAtBallAfterGoto_MC_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
	}

	public static final void ballinfrontEvent(MotionControl MC, boolean res) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == StopAtBallAfterGoto_MC_Map_cachekey_MC) ) {
			matchedEntry = StopAtBallAfterGoto_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MC_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MC = StopAtBallAfterGoto_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront(MC, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MC_Map_cachekey_MC = MC;
			StopAtBallAfterGoto_MC_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
	}

	public static final void ballcloseEvent(MotionControl MC, boolean res) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == StopAtBallAfterGoto_MC_Map_cachekey_MC) ) {
			matchedEntry = StopAtBallAfterGoto_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MC_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MC = StopAtBallAfterGoto_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballclose(MC, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MC_Map_cachekey_MC = MC;
			StopAtBallAfterGoto_MC_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
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

public aspect StopAtBallAfterGotoMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public StopAtBallAfterGotoMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock StopAtBallAfterGoto_MOPLock = new ReentrantLock();
	static Condition StopAtBallAfterGoto_MOPLock_cond = StopAtBallAfterGoto_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut StopAtBallAfterGoto_gotoball(MotionControl MC) : (call(public boolean GotoBall()) && target(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean gotoRes) : StopAtBallAfterGoto_gotoball(MC) {
		StopAtBallAfterGotoRuntimeMonitor.gotoballEvent(MC, gotoRes);
	}

	pointcut StopAtBallAfterGoto_ballinfront(MotionControl MC) : (call(public boolean BallInFront()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : StopAtBallAfterGoto_ballinfront(MC) {
		StopAtBallAfterGotoRuntimeMonitor.ballinfrontEvent(MC, res);
	}

	pointcut StopAtBallAfterGoto_ballclose(MotionControl MC) : (call(public boolean BallClose()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : StopAtBallAfterGoto_ballclose(MC) {
		StopAtBallAfterGotoRuntimeMonitor.ballcloseEvent(MC, res);
	}

}
