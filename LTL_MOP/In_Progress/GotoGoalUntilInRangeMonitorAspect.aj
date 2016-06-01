package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;
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

final class GotoGoalUntilInRangeMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<GotoGoalUntilInRangeMonitor> {

	GotoGoalUntilInRangeMonitor_Set(){
		this.size = 0;
		this.elements = new GotoGoalUntilInRangeMonitor[4];
	}
	final void event_gotogoal(Waypoint dest, boolean withBall, MotionControl MC, boolean gotoRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotogoal(dest, withBall, MC, gotoRes);
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
	final void event_ingoalrange(MotionControl MC, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ingoalrange(MC, res);
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
	final void event_ballinfront(MotionControl MC, boolean ballinfrontRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront(MC, ballinfrontRes);
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

class GotoGoalUntilInRangeMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			GotoGoalUntilInRangeMonitor ret = (GotoGoalUntilInRangeMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	boolean isGotoGoal = false;

	boolean goalRangeFlag = true;

	MotionControl currMC;

	boolean ballInFrontFlag = false;

	static final int Prop_1_transition_gotogoal[] = {0, 2, 2};;
	static final int Prop_1_transition_ingoalrange[] = {0, 2, 2};;
	static final int Prop_1_transition_ballinfront[] = {1, 2, 2};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	GotoGoalUntilInRangeMonitor() {
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

	final boolean Prop_1_event_gotogoal(Waypoint dest, boolean withBall, MotionControl MC, boolean gotoRes) {
		{
			if ( ! (gotoRes) ) {
				return false;
			}
			{
				System.out.println("Goto Goal Event");
				currMC = MC;
				isGotoGoal = withBall;
				if (isGotoGoal) {
					goalRangeFlag = MC.InGoalRange();
				}
			}
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_gotogoal) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ingoalrange(MotionControl MC, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Ball in front true");
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_ingoalrange) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront(MotionControl MC, boolean ballinfrontRes) {
		{
			if ( ! (ballinfrontRes) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Ball in front: " + ballinfrontRes);
				ballInFrontFlag = ballinfrontRes;
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_ballinfront) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			if (isGotoGoal) {
				System.out.println("!!!GotoGoalUntilInRange FAIL!!!");
				if (!ballInFrontFlag) {
					System.out.println("!!!ATTEMPTING FIND BALL!!!");
					currMC.FindAndGrabBall();
				}
				System.out.println("!!!GOING TO CORRECT GOAL!!!");
				currMC.GotoWaypoint(new Waypoint(SoccerGlobals.GOAL_LOCATION.getX(), SoccerGlobals.GOAL_LOCATION.getY()), isGotoGoal);
			}
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
			//gotogoal
			//alive_MC
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//ingoalrange
			//alive_MC
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//ballinfront
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

class GotoGoalUntilInRangeRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager GotoGoalUntilInRangeMapManager;
	static {
		GotoGoalUntilInRangeMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		GotoGoalUntilInRangeMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock GotoGoalUntilInRange_RVMLock = new ReentrantLock();
	static final Condition GotoGoalUntilInRange_RVMLock_cond = GotoGoalUntilInRange_RVMLock.newCondition();

	private static boolean GotoGoalUntilInRange_activated = false;

	// Declarations for Indexing Trees
	private static Object GotoGoalUntilInRange_MC_Map_cachekey_MC;
	private static GotoGoalUntilInRangeMonitor GotoGoalUntilInRange_MC_Map_cachevalue;
	private static final MapOfMonitor<GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange_MC_Map = new MapOfMonitor<GotoGoalUntilInRangeMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += GotoGoalUntilInRange_MC_Map.cleanUpUnnecessaryMappings();
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

	public static final void gotogoalEvent(Waypoint dest, boolean withBall, MotionControl MC, boolean gotoRes) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<GotoGoalUntilInRangeMonitor> matchedLastMap = null;
		GotoGoalUntilInRangeMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == GotoGoalUntilInRange_MC_Map_cachekey_MC) ) {
			matchedEntry = GotoGoalUntilInRange_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<GotoGoalUntilInRangeMonitor> itmdMap = GotoGoalUntilInRange_MC_Map;
				matchedLastMap = itmdMap;
				GotoGoalUntilInRangeMonitor node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final GotoGoalUntilInRangeMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotogoal(dest, withBall, MC, gotoRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MC_Map_cachekey_MC = MC;
			GotoGoalUntilInRange_MC_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
	}

	public static final void ingoalrangeEvent(MotionControl MC, boolean res) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<GotoGoalUntilInRangeMonitor> matchedLastMap = null;
		GotoGoalUntilInRangeMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == GotoGoalUntilInRange_MC_Map_cachekey_MC) ) {
			matchedEntry = GotoGoalUntilInRange_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<GotoGoalUntilInRangeMonitor> itmdMap = GotoGoalUntilInRange_MC_Map;
				matchedLastMap = itmdMap;
				GotoGoalUntilInRangeMonitor node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final GotoGoalUntilInRangeMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ingoalrange(MC, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MC_Map_cachekey_MC = MC;
			GotoGoalUntilInRange_MC_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
	}

	public static final void ballinfrontEvent(MotionControl MC, boolean ballinfrontRes) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<GotoGoalUntilInRangeMonitor> matchedLastMap = null;
		GotoGoalUntilInRangeMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == GotoGoalUntilInRange_MC_Map_cachekey_MC) ) {
			matchedEntry = GotoGoalUntilInRange_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<GotoGoalUntilInRangeMonitor> itmdMap = GotoGoalUntilInRange_MC_Map;
				matchedLastMap = itmdMap;
				GotoGoalUntilInRangeMonitor node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final GotoGoalUntilInRangeMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront(MC, ballinfrontRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MC_Map_cachekey_MC = MC;
			GotoGoalUntilInRange_MC_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
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

public aspect GotoGoalUntilInRangeMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public GotoGoalUntilInRangeMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock GotoGoalUntilInRange_MOPLock = new ReentrantLock();
	static Condition GotoGoalUntilInRange_MOPLock_cond = GotoGoalUntilInRange_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut GotoGoalUntilInRange_gotogoal(Waypoint dest, boolean withBall, MotionControl MC) : (call(public boolean GotoWaypoint(Waypoint, boolean)) && args(dest, withBall) && target(MC)) && MOP_CommonPointCut();
	after (Waypoint dest, boolean withBall, MotionControl MC) returning (boolean gotoRes) : GotoGoalUntilInRange_gotogoal(dest, withBall, MC) {
		GotoGoalUntilInRangeRuntimeMonitor.gotogoalEvent(dest, withBall, MC, gotoRes);
	}

	pointcut GotoGoalUntilInRange_ingoalrange(MotionControl MC) : (call(public boolean InGoalRange()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : GotoGoalUntilInRange_ingoalrange(MC) {
		GotoGoalUntilInRangeRuntimeMonitor.ingoalrangeEvent(MC, res);
	}

	pointcut GotoGoalUntilInRange_ballinfront(MotionControl MC) : (call(public boolean BallInFront()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean ballinfrontRes) : GotoGoalUntilInRange_ballinfront(MC) {
		GotoGoalUntilInRangeRuntimeMonitor.ballinfrontEvent(MC, ballinfrontRes);
	}

}
