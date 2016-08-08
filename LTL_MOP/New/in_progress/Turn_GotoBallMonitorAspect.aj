import java.io.*;
import java.util.*;
import fullSoccer.*;
import stateTools.*;
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
	final void event_wonderstate_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_wonderstate_enter(MK);
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
	final void event_wonderstate_true(Kicker MK, boolean wonderCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_wonderstate_true(MK, wonderCheckRes);
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
	final void event_wonderstate_false(Kicker MK, boolean wonderCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_wonderstate_false(MK, wonderCheckRes);
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
	final void event_ballinfront_true(Kicker MK, boolean ballinfrontRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_true(MK, ballinfrontRes);
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
	final void event_ballinfront_false(Kicker MK, boolean ballinfrontRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront_false(MK, ballinfrontRes);
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
	final void event_ballclose_true(Kicker MK, boolean ballCloseRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballclose_true(MK, ballCloseRes);
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
	final void event_ballclose_false(Kicker MK, boolean ballCloseRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final testMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballclose_false(MK, ballCloseRes);
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

	static final int Prop_1_transition_wonderstate_enter[] = {1, 3, 2, 3};;
	static final int Prop_1_transition_wonderstate_true[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_wonderstate_false[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_gotoballstate_enter[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_ballinfront_true[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_ballinfront_false[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_ballclose_true[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_ballclose_false[] = {2, 3, 2, 3};;

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

	final boolean Prop_1_event_wonderstate_enter(Kicker MK) {
		{
			System.out.println("Wonder Event ENTER");
			StateCheck.PrintState(State.WONDER);
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_wonderstate_enter) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_wonderstate_true(Kicker MK, boolean wonderCheckRes) {
		{
			if ( ! (wonderCheckRes) ) {
				return false;
			}
			{
				System.out.println("Wonder Event TEST TRUE");
				StateCheck.PrintState(State.WONDER);
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_wonderstate_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_wonderstate_false(Kicker MK, boolean wonderCheckRes) {
		{
			if ( ! (!wonderCheckRes) ) {
				return false;
			}
			{
				System.out.println("Wonder Event TEST FALSE");
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_wonderstate_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_gotoballstate_enter(Kicker MK) {
		{
			System.out.println("GTB Event ENTER");
			StateCheck.PrintState(State.GOTO_BALL);
		}

		int nextstate = this.handleEvent(3, Prop_1_transition_gotoballstate_enter) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_true(Kicker MK, boolean ballinfrontRes) {
		{
			if ( ! (ballinfrontRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball in front TRUE: " + ballinfrontRes);
			}
		}

		int nextstate = this.handleEvent(4, Prop_1_transition_ballinfront_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballinfront_false(Kicker MK, boolean ballinfrontRes) {
		{
			if ( ! (!ballinfrontRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball in front FALSE: " + ballinfrontRes);
			}
		}

		int nextstate = this.handleEvent(5, Prop_1_transition_ballinfront_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballclose_true(Kicker MK, boolean ballCloseRes) {
		{
			if ( ! (ballCloseRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball Close TRUE: " + ballCloseRes);
			}
		}

		int nextstate = this.handleEvent(6, Prop_1_transition_ballclose_true) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_ballclose_false(Kicker MK, boolean ballCloseRes) {
		{
			if ( ! (!ballCloseRes) ) {
				return false;
			}
			{
				currMK = MK;
				System.out.println("Ball Close FALSE: " + ballCloseRes);
			}
		}

		int nextstate = this.handleEvent(7, Prop_1_transition_ballclose_false) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!WONDER TO GTB FAIL!!!");
			this.reset();
		}

	}

	final void reset() {
		this.pairValue.set(this.calculatePairValue(-1, 0) ) ;

		Prop_1_Category_violation = false;
	}

	// RVMRef_MK was suppressed to reduce memory overhead

	@Override
	protected final void terminateInternal(int idnum) {
		int lastEvent = this.getLastEvent();

		switch(idnum){
			case 0:
			break;
		}
		switch(lastEvent) {
			case -1:
			return;
			case 0:
			//wonderstate_enter
			return;
			case 1:
			//wonderstate_true
			return;
			case 2:
			//wonderstate_false
			return;
			case 3:
			//gotoballstate_enter
			return;
			case 4:
			//ballinfront_true
			return;
			case 5:
			//ballinfront_false
			return;
			case 6:
			//ballclose_true
			return;
			case 7:
			//ballclose_false
			return;
		}
		return;
	}

	public static int getNumberOfEvents() {
		return 8;
	}

	public static int getNumberOfStates() {
		return 4;
	}

}

class Turn_GotoBallRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager Turn_GotoBallMapManager;
	static {
		Turn_GotoBallMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		Turn_GotoBallMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock Turn_GotoBall_RVMLock = new ReentrantLock();
	static final Condition Turn_GotoBall_RVMLock_cond = Turn_GotoBall_RVMLock.newCondition();

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

	public static final void wonderstate_enterEvent(Kicker MK) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_wonderstate_enter(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void wonderstate_trueEvent(Kicker MK, boolean wonderCheckRes) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_wonderstate_true(MK, wonderCheckRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void wonderstate_falseEvent(Kicker MK, boolean wonderCheckRes) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_wonderstate_false(MK, wonderCheckRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void gotoballstate_enterEvent(Kicker MK) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void ballinfront_trueEvent(Kicker MK, boolean ballinfrontRes) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_ballinfront_true(MK, ballinfrontRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void ballinfront_falseEvent(Kicker MK, boolean ballinfrontRes) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_ballinfront_false(MK, ballinfrontRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void ballclose_trueEvent(Kicker MK, boolean ballCloseRes) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_ballclose_true(MK, ballCloseRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
	}

	public static final void ballclose_falseEvent(Kicker MK, boolean ballCloseRes) {
		test_activated = true;
		while (!Turn_GotoBall_RVMLock.tryLock()) {
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
		matchedEntry.Prop_1_event_ballclose_false(MK, ballCloseRes);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			test_MK_Map_cachekey_MK = MK;
			test_MK_Map_cachevalue = matchedEntry;
		}

		Turn_GotoBall_RVMLock.unlock();
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

public aspect Turn_GotoBallMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public Turn_GotoBallMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock Turn_GotoBall_MOPLock = new ReentrantLock();
	static Condition Turn_GotoBall_MOPLock_cond = Turn_GotoBall_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut test_gotoballstate_enter(Kicker MK) : (call(public boolean StateCheck.GotoBallState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_gotoballstate_enter(MK) {
		Turn_GotoBallRuntimeMonitor.gotoballstate_enterEvent(MK);
	}

	pointcut test_wonderstate_enter(Kicker MK) : (call(public boolean StateCheck.WonderState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : test_wonderstate_enter(MK) {
		Turn_GotoBallRuntimeMonitor.wonderstate_enterEvent(MK);
	}

	pointcut test_wonderstate_true(Kicker MK) : (call(public boolean StateCheck.WonderState(Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean wonderCheckRes) : test_wonderstate_true(MK) {
		//test_wonderstate_true
		Turn_GotoBallRuntimeMonitor.wonderstate_trueEvent(MK, wonderCheckRes);
		//test_wonderstate_false
		Turn_GotoBallRuntimeMonitor.wonderstate_falseEvent(MK, wonderCheckRes);
	}

	pointcut test_ballinfront_true(Kicker MK) : (call(public boolean Kicker.ballInFront(boolean, float[])) && !within(StateCheck) && target(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean ballinfrontRes) : test_ballinfront_true(MK) {
		//test_ballinfront_true
		Turn_GotoBallRuntimeMonitor.ballinfront_trueEvent(MK, ballinfrontRes);
		//test_ballinfront_false
		Turn_GotoBallRuntimeMonitor.ballinfront_falseEvent(MK, ballinfrontRes);
	}

	pointcut test_ballclose_true(Kicker MK) : (call(public boolean Kicker.ballClose(boolean, float)) && target(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean ballCloseRes) : test_ballclose_true(MK) {
		//test_ballclose_true
		Turn_GotoBallRuntimeMonitor.ballclose_trueEvent(MK, ballCloseRes);
		//test_ballclose_false
		Turn_GotoBallRuntimeMonitor.ballclose_falseEvent(MK, ballCloseRes);
	}

}
