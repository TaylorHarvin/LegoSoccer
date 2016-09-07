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
	final void event_gotoball(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotoball(MK);
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
	final void event_ballinfront_true(Kicker MK, boolean bifRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_true(MK, bifRes);
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
	final void event_ballinfront_false(Kicker MK, boolean bifRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_false(MK, bifRes);
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
	final void event_ballclose_true(Kicker MK, boolean bcRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballclose_true(MK, bcRes);
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
	final void event_ballclose_false(Kicker MK, boolean bcRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StopAtBallAfterGotoMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final StopAtBallAfterGotoMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballclose_false(MK, bcRes);
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

	Kicker currMK = null;

	boolean ballInFrontFlag = false;

	boolean ballCloseFlag = false;

	static final int Prop_1_transition_gotoball[] = {1, 2, 2};;
	static final int Prop_1_transition_ballinfront_true[] = {0, 2, 2};;
	static final int Prop_1_transition_ballinfront_false[] = {0, 2, 2};;
	static final int Prop_1_transition_ballclose_true[] = {0, 2, 2};;
	static final int Prop_1_transition_ballclose_false[] = {0, 2, 2};;

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

	final boolean Prop_1_event_gotoball(Kicker MK) {
		{
			currMK = MK;
			System.out.println("Goto Ball EVENT");
			System.out.println("Ball in front:" + MK.ballInFront(false));
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_gotoball) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_true(Kicker MK, boolean bifRes) {
		{
			if ( ! (bifRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball in front TRUE: " + bifRes);
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_ballinfront_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_false(Kicker MK, boolean bifRes) {
		{
			if ( ! (!bifRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball in front FALSE: " + bifRes);
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_ballinfront_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballclose_true(Kicker MK, boolean bcRes) {
		{
			if ( ! (bcRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball close event TRUE: " + bcRes);
			}
		}

		int nextstate = this.handleEvent(3, Prop_1_transition_ballclose_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballclose_false(Kicker MK, boolean bcRes) {
		{
			if ( ! (!bcRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball close event FALSE: " + bcRes);
			}
		}

		int nextstate = this.handleEvent(4, Prop_1_transition_ballclose_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!StopAtBallAfterGoto LTL FAIL!!!");
			System.out.println("!!!STOPPING ROBOT!!!");
			currMK.getMotionControl().stopMotion();
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
			//ballinfront_true
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//ballinfront_false
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 3:
			//ballclose_true
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 4:
			//ballclose_false
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
	private static Object StopAtBallAfterGoto_MK_Map_cachekey_MK;
	private static StopAtBallAfterGotoMonitor StopAtBallAfterGoto_MK_Map_cachevalue;
	private static final MapOfMonitor<StopAtBallAfterGotoMonitor> StopAtBallAfterGoto_MK_Map = new MapOfMonitor<StopAtBallAfterGotoMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += StopAtBallAfterGoto_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void gotoballEvent(Kicker MK) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == StopAtBallAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = StopAtBallAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MK = StopAtBallAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotoball(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MK_Map_cachekey_MK = MK;
			StopAtBallAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
	}

	public static final void ballinfront_trueEvent(Kicker MK, boolean bifRes) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == StopAtBallAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = StopAtBallAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MK = StopAtBallAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront_true(MK, bifRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MK_Map_cachekey_MK = MK;
			StopAtBallAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
	}

	public static final void ballinfront_falseEvent(Kicker MK, boolean bifRes) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == StopAtBallAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = StopAtBallAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MK = StopAtBallAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront_false(MK, bifRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MK_Map_cachekey_MK = MK;
			StopAtBallAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
	}

	public static final void ballclose_trueEvent(Kicker MK, boolean bcRes) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == StopAtBallAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = StopAtBallAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MK = StopAtBallAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballclose_true(MK, bcRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MK_Map_cachekey_MK = MK;
			StopAtBallAfterGoto_MK_Map_cachevalue = matchedEntry;
		}

		StopAtBallAfterGoto_RVMLock.unlock();
	}

	public static final void ballclose_falseEvent(Kicker MK, boolean bcRes) {
		StopAtBallAfterGoto_activated = true;
		while (!StopAtBallAfterGoto_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<StopAtBallAfterGotoMonitor> matchedLastMap = null;
		StopAtBallAfterGotoMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == StopAtBallAfterGoto_MK_Map_cachekey_MK) ) {
			matchedEntry = StopAtBallAfterGoto_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StopAtBallAfterGotoMonitor> itmdMap = StopAtBallAfterGoto_MK_Map;
				matchedLastMap = itmdMap;
				StopAtBallAfterGotoMonitor node_MK = StopAtBallAfterGoto_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			StopAtBallAfterGotoMonitor created = new StopAtBallAfterGotoMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final StopAtBallAfterGotoMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballclose_false(MK, bcRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			StopAtBallAfterGoto_MK_Map_cachekey_MK = MK;
			StopAtBallAfterGoto_MK_Map_cachevalue = matchedEntry;
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
	pointcut StopAtBallAfterGoto_gotoball(Kicker MK) : (call(public boolean Kicker.gotoBall()) && target(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : StopAtBallAfterGoto_gotoball(MK) {
		StopAtBallAfterGotoRuntimeMonitor.gotoballEvent(MK);
	}

	pointcut StopAtBallAfterGoto_ballinfront_true(Kicker MK) : (call(public boolean Kicker.ballInFront(boolean)) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean bifRes) : StopAtBallAfterGoto_ballinfront_true(MK) {
		//StopAtBallAfterGoto_ballinfront_true
		StopAtBallAfterGotoRuntimeMonitor.ballinfront_trueEvent(MK, bifRes);
		//StopAtBallAfterGoto_ballinfront_false
		StopAtBallAfterGotoRuntimeMonitor.ballinfront_falseEvent(MK, bifRes);
	}

	pointcut StopAtBallAfterGoto_ballclose_true(Kicker MK) : (call(public boolean Kicker.ballClose(boolean)) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean bcRes) : StopAtBallAfterGoto_ballclose_true(MK) {
		//StopAtBallAfterGoto_ballclose_true
		StopAtBallAfterGotoRuntimeMonitor.ballclose_trueEvent(MK, bcRes);
		//StopAtBallAfterGoto_ballclose_false
		StopAtBallAfterGotoRuntimeMonitor.ballclose_falseEvent(MK, bcRes);
	}

}
