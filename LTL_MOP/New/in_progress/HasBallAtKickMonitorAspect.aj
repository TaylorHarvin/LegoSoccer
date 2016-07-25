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
	final void event_kicking(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_kicking(MK);
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
	final void event_ballkickable_true(Kicker MK, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballkickable_true(MK, res);
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
	final void event_ballkickable_false(Kicker MK, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballkickable_false(MK, res);
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
	final void event_ballinfront_true(Kicker MK, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_true(MK, res);
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
	final void event_ballinfront_false(Kicker MK, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			HasBallAtKickMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final HasBallAtKickMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_false(MK, res);
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

	Kicker currMK = null;

	static final int Prop_1_transition_kicking[] = {1, 2, 2};;
	static final int Prop_1_transition_ballkickable_true[] = {0, 2, 2};;
	static final int Prop_1_transition_ballkickable_false[] = {0, 2, 2};;
	static final int Prop_1_transition_ballinfront_true[] = {0, 2, 2};;
	static final int Prop_1_transition_ballinfront_false[] = {0, 2, 2};;

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

	final boolean Prop_1_event_kicking(Kicker MK) {
		{
			System.out.println("Kick Ball EVENT");
			currMK = MK;
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_kicking) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballkickable_true(Kicker MK, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				System.out.println("Ball Kickable TRUE: " + res);
				currMK = MK;
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_ballkickable_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballkickable_false(Kicker MK, boolean res) {
		{
			if ( ! (!res) ) {
				return false;
			}
			{
				System.out.println("Ball Kickable FALSE: " + res);
				currMK = MK;
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_ballkickable_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_true(Kicker MK, boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("EVENT Ball in front TRUE: " + res);
			}
		}

		int nextstate = this.handleEvent(3, Prop_1_transition_ballinfront_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_false(Kicker MK, boolean res) {
		{
			if ( ! (!res) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("EVENT Ball in front FALSE: " + res);
			}
		}

		int nextstate = this.handleEvent(4, Prop_1_transition_ballinfront_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			if (currMK.ballInFront(true) && currMK.ballKickable(true)) {
				System.out.println("!!!BallKickable LTL FAIL -- But Ball Close!!!");
				System.out.println("!!!Still Kick-Ready!!!");
			} else {
				System.out.println("!!!BallKickable LTL FAIL -- But Ball  NOT Close!!!");
				System.out.println("!!!Turning to ball -- Recovery!!!");
				while (!currMK.wonder()) {
					System.out.println("!!!Turning to ball -- Recovery Try!!!");
				}
			}
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
			//kicking
			return;
			case 1:
			//ballkickable_true
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//ballkickable_false
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 3:
			//ballinfront_true
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 4:
			//ballinfront_false
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
	private static Object HasBallAtKick_MK_Map_cachekey_MK;
	private static HasBallAtKickMonitor HasBallAtKick_MK_Map_cachevalue;
	private static final MapOfMonitor<HasBallAtKickMonitor> HasBallAtKick_MK_Map = new MapOfMonitor<HasBallAtKickMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += HasBallAtKick_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void kickingEvent(Kicker MK) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == HasBallAtKick_MK_Map_cachekey_MK) ) {
			matchedEntry = HasBallAtKick_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MK_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MK = HasBallAtKick_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_kicking(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MK_Map_cachekey_MK = MK;
			HasBallAtKick_MK_Map_cachevalue = matchedEntry;
		}

		HasBallAtKick_RVMLock.unlock();
	}

	public static final void ballkickable_trueEvent(Kicker MK, boolean res) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == HasBallAtKick_MK_Map_cachekey_MK) ) {
			matchedEntry = HasBallAtKick_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MK_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MK = HasBallAtKick_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballkickable_true(MK, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MK_Map_cachekey_MK = MK;
			HasBallAtKick_MK_Map_cachevalue = matchedEntry;
		}

		HasBallAtKick_RVMLock.unlock();
	}

	public static final void ballkickable_falseEvent(Kicker MK, boolean res) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == HasBallAtKick_MK_Map_cachekey_MK) ) {
			matchedEntry = HasBallAtKick_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MK_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MK = HasBallAtKick_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballkickable_false(MK, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MK_Map_cachekey_MK = MK;
			HasBallAtKick_MK_Map_cachevalue = matchedEntry;
		}

		HasBallAtKick_RVMLock.unlock();
	}

	public static final void ballinfront_trueEvent(Kicker MK, boolean res) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == HasBallAtKick_MK_Map_cachekey_MK) ) {
			matchedEntry = HasBallAtKick_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MK_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MK = HasBallAtKick_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront_true(MK, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MK_Map_cachekey_MK = MK;
			HasBallAtKick_MK_Map_cachevalue = matchedEntry;
		}

		HasBallAtKick_RVMLock.unlock();
	}

	public static final void ballinfront_falseEvent(Kicker MK, boolean res) {
		HasBallAtKick_activated = true;
		while (!HasBallAtKick_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<HasBallAtKickMonitor> matchedLastMap = null;
		HasBallAtKickMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == HasBallAtKick_MK_Map_cachekey_MK) ) {
			matchedEntry = HasBallAtKick_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<HasBallAtKickMonitor> itmdMap = HasBallAtKick_MK_Map;
				matchedLastMap = itmdMap;
				HasBallAtKickMonitor node_MK = HasBallAtKick_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			HasBallAtKickMonitor created = new HasBallAtKickMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final HasBallAtKickMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfront_false(MK, res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			HasBallAtKick_MK_Map_cachekey_MK = MK;
			HasBallAtKick_MK_Map_cachevalue = matchedEntry;
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
	pointcut HasBallAtKick_kicking(Kicker MK) : (call(public void kickBall(int, int, int, int, int, int)) && target(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : HasBallAtKick_kicking(MK) {
		HasBallAtKickRuntimeMonitor.kickingEvent(MK);
	}

	pointcut HasBallAtKick_ballkickable_true(Kicker MK) : (call(public boolean ballKickable(boolean)) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean res) : HasBallAtKick_ballkickable_true(MK) {
		//HasBallAtKick_ballkickable_true
		HasBallAtKickRuntimeMonitor.ballkickable_trueEvent(MK, res);
		//HasBallAtKick_ballkickable_false
		HasBallAtKickRuntimeMonitor.ballkickable_falseEvent(MK, res);
	}

	pointcut HasBallAtKick_ballinfront_true(Kicker MK) : (call(public boolean Kicker.ballInFront(boolean)) && this(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean res) : HasBallAtKick_ballinfront_true(MK) {
		//HasBallAtKick_ballinfront_true
		HasBallAtKickRuntimeMonitor.ballinfront_trueEvent(MK, res);
		//HasBallAtKick_ballinfront_false
		HasBallAtKickRuntimeMonitor.ballinfront_falseEvent(MK, res);
	}

}
