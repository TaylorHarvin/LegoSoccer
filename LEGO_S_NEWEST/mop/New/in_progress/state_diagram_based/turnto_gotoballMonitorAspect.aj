import java.io.*;
import java.util.*;
import fullSoccer.*;
import stateTools.*;
import loggingTools.*;
import lejos.utility.Delay;
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


final class testMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<testMonitor> {

	testMonitor_Set(){
		this.size = 0;
		this.elements = new testMonitor[4];
	}
	final void event_turnto_ball_state_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_turnto_ball_state_enter(MK);
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
	final void event_turnto_ball_state_true(Kicker MK, boolean TurnCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_turnto_ball_state_true(MK, TurnCheckRes);
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
	final void event_gotoballstate_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotoballstate_enter(MK);
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
	final void event_goto_ball_state_true(Kicker MK, boolean gtbCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_goto_ball_state_true(MK, gtbCheckRes);
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
	final void event_ballinfront_true(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_true(MK);
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

class testMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			testMonitor ret = (testMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	Kicker currMK;

	boolean failTried = false;

	static final int Prop_1_transition_turnto_ball_state_enter[] = {2, 5, 1, 1, 4, 5};;
	static final int Prop_1_transition_turnto_ball_state_true[] = {4, 5, 2, 1, 4, 5};;
	static final int Prop_1_transition_gotoballstate_enter[] = {4, 5, 1, 4, 4, 5};;
	static final int Prop_1_transition_goto_ball_state_true[] = {4, 5, 1, 1, 4, 5};;
	static final int Prop_1_transition_ballinfront_true[] = {4, 5, 3, 1, 4, 5};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	testMonitor() {
		this.pairValue = new AtomicInteger(this.calculatePairValue(-1, 0) ) ;

	}

	@Override public final int getState() {
		return this.getState(this.pairValue.get() ) ;
	}
	@Override public final int getLastEvent() {
		return this.getLastEvent(this.pairValue.get() ) ;
	}
	private final int getState(int pairValue) {
		return (pairValue & 7) ;
	}
	private final int getLastEvent(int pairValue) {
		return (pairValue >> 3) ;
	}
	private final int calculatePairValue(int lastEvent, int state) {
		return (((lastEvent + 1) << 3) | state) ;
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

	final boolean Prop_1_event_turnto_ball_state_enter(Kicker MK) {
		{
			System.out.println("Turn_To_Ball Event ENTER");
			Logger.log(LogFile.TURN_GTB, "turnto_ball_state_enter");
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_turnto_ball_state_enter) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_turnto_ball_state_true(Kicker MK, boolean TurnCheckRes) {
		{
			if ( ! (TurnCheckRes) ) {
				return false;
			}
			{
				System.out.println("TURN_TO_BALL Event TEST TRUE");
				Logger.log(LogFile.TURN_GTB, "turnto_ball_state_true");
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_turnto_ball_state_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_gotoballstate_enter(Kicker MK) {
		{
			System.out.println("GTB Event ENTER");
			Logger.log(LogFile.TURN_GTB, "gotoballstate_enter");
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_gotoballstate_enter) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_goto_ball_state_true(Kicker MK, boolean gtbCheckRes) {
		{
			if ( ! (gtbCheckRes) ) {
				return false;
			}
			{
				System.out.println("GTB Event TEST TRUE");
				Logger.log(LogFile.TURN_GTB, "goto_ball_state_true");
			}
		}

		int nextstate = this.handleEvent(3, Prop_1_transition_goto_ball_state_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_true(Kicker MK) {
		{
			currMK = MK;
			System.out.println("Ball in front TRUE");
			Logger.log(LogFile.TURN_GTB, "ballinfront_true");
		}

		int nextstate = this.handleEvent(4, Prop_1_transition_ballinfront_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!TURN TO GTB FAIL!!!");
			Logger.log(LogFile.TURN_GTB, "!!!TURN_TO_BALL TO GTB FAIL!!!");
			Delay.msDelay(5000);
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
			//turnto_ball_state_enter
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//turnto_ball_state_true
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//gotoballstate_enter
			return;
			case 3:
			//goto_ball_state_true
			return;
			case 4:
			//ballinfront_true
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
		return 5;
	}

	public static int getNumberOfStates() {
		return 6;
	}

}

class turnto_gotoballRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager turnto_gotoballMapManager;
	static {
		turnto_gotoballMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		turnto_gotoballMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock turnto_gotoball_RVMLock = new ReentrantLock();
	static final Condition turnto_gotoball_RVMLock_cond = turnto_gotoball_RVMLock.newCondition();

	private static boolean test_activated = false;

	// Declarations for Indexing Trees
	private static Object test_MK_Map_cachekey_MK;
	private static testMonitor test_MK_Map_cachevalue;
	private static final MapOfMonitor<testMonitor> test_MK_Map = new MapOfMonitor<testMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += test_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void turnto_ball_state_enterEvent(Kicker MK) {
		test_activated = true;
		while (!turnto_gotoball_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<testMonitor> matchedLastMap = null;
		testMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == test_MK_Map_cachekey_MK) ) {
			matchedEntry = test_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<testMonitor> itmdMap = test_MK_Map;
				matchedLastMap = itmdMap;
				testMonitor node_MK = test_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			testMonitor created = new testMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final testMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_turnto_ball_state_enter(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		turnto_gotoball_RVMLock.unlock();
	}

	public static final void turnto_ball_state_trueEvent(Kicker MK, boolean TurnCheckRes) {
		test_activated = true;
		while (!turnto_gotoball_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<testMonitor> matchedLastMap = null;
		testMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == test_MK_Map_cachekey_MK) ) {
			matchedEntry = test_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<testMonitor> itmdMap = test_MK_Map;
				matchedLastMap = itmdMap;
				testMonitor node_MK = test_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			testMonitor created = new testMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final testMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_turnto_ball_state_true(MK, TurnCheckRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		turnto_gotoball_RVMLock.unlock();
	}

	public static final void gotoballstate_enterEvent(Kicker MK) {
		test_activated = true;
		while (!turnto_gotoball_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<testMonitor> matchedLastMap = null;
		testMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == test_MK_Map_cachekey_MK) ) {
			matchedEntry = test_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<testMonitor> itmdMap = test_MK_Map;
				matchedLastMap = itmdMap;
				testMonitor node_MK = test_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			testMonitor created = new testMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final testMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotoballstate_enter(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		turnto_gotoball_RVMLock.unlock();
	}

	public static final void goto_ball_state_trueEvent(Kicker MK, boolean gtbCheckRes) {
		test_activated = true;
		while (!turnto_gotoball_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<testMonitor> matchedLastMap = null;
		testMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == test_MK_Map_cachekey_MK) ) {
			matchedEntry = test_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<testMonitor> itmdMap = test_MK_Map;
				matchedLastMap = itmdMap;
				testMonitor node_MK = test_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			testMonitor created = new testMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final testMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_goto_ball_state_true(MK, gtbCheckRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		turnto_gotoball_RVMLock.unlock();
	}

	public static final void ballinfront_trueEvent(Kicker MK) {
		test_activated = true;
		while (!turnto_gotoball_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<testMonitor> matchedLastMap = null;
		testMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == test_MK_Map_cachekey_MK) ) {
			matchedEntry = test_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<testMonitor> itmdMap = test_MK_Map;
				matchedLastMap = itmdMap;
				testMonitor node_MK = test_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			testMonitor created = new testMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final testMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront_true(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		turnto_gotoball_RVMLock.unlock();
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

public aspect turnto_gotoballMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public turnto_gotoballMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock turnto_gotoball_MOPLock = new ReentrantLock();
	static Condition turnto_gotoball_MOPLock_cond = turnto_gotoball_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut test_gotoballstate_enter(Kicker MK) : (call(public boolean Kicker.gotoBall()) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_gotoballstate_enter(MK) {
		turnto_gotoballRuntimeMonitor.gotoballstate_enterEvent(MK);
	}

	pointcut test_turnto_ball_state_enter(Kicker MK) : (call(public boolean Kicker.turnToBall()) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_turnto_ball_state_enter(MK) {
		turnto_gotoballRuntimeMonitor.turnto_ball_state_enterEvent(MK);
	}

	pointcut test_turnto_ball_state_true(Kicker MK) : (call(public boolean StateCheck.TurnToBallState(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean TurnCheckRes) : test_turnto_ball_state_true(MK) {
		turnto_gotoballRuntimeMonitor.turnto_ball_state_trueEvent(MK, TurnCheckRes);
	}

	pointcut test_goto_ball_state_true(Kicker MK) : (call(public boolean StateCheck.GotoBallState(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean gtbCheckRes) : test_goto_ball_state_true(MK) {
		turnto_gotoballRuntimeMonitor.goto_ball_state_trueEvent(MK, gtbCheckRes);
	}

	pointcut test_ballinfront_true(Kicker MK) : (call(public void Kicker.generateBallInFrontState()) && target(MK)) && MOP_CommonPointCut();
	after (Kicker MK) : test_ballinfront_true(MK) {
		turnto_gotoballRuntimeMonitor.ballinfront_trueEvent(MK);
	}

}
