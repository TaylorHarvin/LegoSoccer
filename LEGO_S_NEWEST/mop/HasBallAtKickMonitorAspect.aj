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

final class HasBallAtKickMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<HasBallAtKickMonitor> {

	HasBallAtKickMonitor_Set(){
		this.size = 0;
		this.elements = new HasBallAtKickMonitor[4];
	}
	final void event_kicking(MotionControl MC) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_kicking(MC);
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
	final void event_ballkickable(MotionControl MC, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballkickable(MC, res);
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

class HasBallAtKickMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			HasBallAtKickMonitor ret = (HasBallAtKickMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	float sonarVal = 9999;

	boolean ballClose = false;

	MotionControl currMC = null;

	static final int Prop_1_transition_kicking[] = {2, 0, 3, 3};;
	static final int Prop_1_transition_ballkickable[] = {1, 1, 3, 3};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	HasBallAtKickMonitor() {
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

	final boolean Prop_1_event_kicking(MotionControl MC) {
		{
			System.out.println("Kick Ball EVENT");
			currMC = MC;
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_kicking) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_ballkickable(MotionControl MC, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				System.out.println("Ball Kickable: " + res);
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_ballkickable) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			sonarVal = currMC.mainSC.fetchSonarVal();
			if (currMC.mainSC.BallInFront() && currMC.mainSC.BallKickable()) {
				System.out.println("!!!BallKickable LTL FAIL -- But Ball Close!!!");
				System.out.println("!!!Still Kick-Ready!!!");
			} else {
				System.out.println("!!!BallKickable LTL FAIL -- But Ball  NOT Close!!!");
				System.out.println("!!!Turning to ball -- Recovery!!!");
				while (!currMC.FindAndGrabBall()) {
					System.out.println("!!!Turning to ball -- Recovery Try!!!");
				}
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
			//kicking
			//alive_MC
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//ballkickable
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
		return 4;
	}

}

class HasBallAtKickRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager HasBallAtKickMapManager;
	static {
		HasBallAtKickMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		HasBallAtKickMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock HasBallAtKick_RVMLock = new ReentrantLock();
	static final Condition HasBallAtKick_RVMLock_cond = HasBallAtKick_RVMLock.newCondition();

	private static boolean HasBallAtKick_activated = false;

	// Declarations for Indexing Trees
	private static Object HasBallAtKick_MC_Map_cachekey_MC;
	private static HasBallAtKickMonitor HasBallAtKick_MC_Map_cachevalue;
	private static final MapOfMonitor<HasBallAtKickMonitor> HasBallAtKick_MC_Map = new MapOfMonitor<HasBallAtKickMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += HasBallAtKick_MC_Map.cleanUpUnnecessaryMappings();
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

	public static final void kickingEvent(MotionControl MC) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == HasBallAtKick_MC_Map_cachekey_MC) ) {
			matchedEntry = HasBallAtKick_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MC_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MC = HasBallAtKick_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_kicking(MC);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MC_Map_cachekey_MC = MC;
			HasBallAtKick_MC_Map_cachevalue = matchedEntry;
		}

		HasBallAtKick_RVMLock.unlock();
	}

	public static final void ballkickableEvent(MotionControl MC, boolean res) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MC == HasBallAtKick_MC_Map_cachekey_MC) ) {
			matchedEntry = HasBallAtKick_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MC_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MC = HasBallAtKick_MC_Map.getNodeEquivalent(wr_MC) ;
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MC, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballkickable(MC, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MC_Map_cachekey_MC = MC;
			HasBallAtKick_MC_Map_cachevalue = matchedEntry;
		}

		HasBallAtKick_RVMLock.unlock();
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

public aspect HasBallAtKickMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public HasBallAtKickMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock HasBallAtKick_MOPLock = new ReentrantLock();
	static Condition HasBallAtKick_MOPLock_cond = HasBallAtKick_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut HasBallAtKick_kicking(MotionControl MC) : (call(public void KickBall(int, int, int, int, int, int)) && target(MC)) && MOP_CommonPointCut();
	before (MotionControl MC) : HasBallAtKick_kicking(MC) {
		HasBallAtKickRuntimeMonitor.kickingEvent(MC);
	}

	pointcut HasBallAtKick_ballkickable(MotionControl MC) : (call(public boolean BallKickable()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : HasBallAtKick_ballkickable(MC) {
		HasBallAtKickRuntimeMonitor.ballkickableEvent(MC, res);
	}

}
