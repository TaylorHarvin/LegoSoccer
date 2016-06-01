import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.util.*;
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


final class SafeHashSetMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<SafeHashSetMonitor> {

	SafeHashSetMonitor_Set(){
		this.size = 0;
		this.elements = new SafeHashSetMonitor[4];
	}
	final void event_add(HashSet t, Object o) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			SafeHashSetMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final SafeHashSetMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_add(t, o);
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
	final void event_bad_use(HashSet t, Object o) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			SafeHashSetMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final SafeHashSetMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_bad_use(t, o);
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
	final void event_remove(HashSet t, Object o) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			SafeHashSetMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final SafeHashSetMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_remove(t, o);
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

class SafeHashSetMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			SafeHashSetMonitor ret = (SafeHashSetMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	int hashcode;

	static final int Prop_1_transition_add[] = {3, 1, 4, 3, 4};;
	static final int Prop_1_transition_bad_use[] = {1, 1, 4, 2, 4};;
	static final int Prop_1_transition_remove[] = {1, 1, 4, 1, 4};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	SafeHashSetMonitor() {
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

	final boolean Prop_1_event_add(HashSet t, Object o) {
		{
			hashcode = o.hashCode();
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_add) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_bad_use(HashSet t, Object o) {
		{
			if ( ! (hashcode != o.hashCode()) ) {
				return false;
			}
			{
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_bad_use) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_remove(HashSet t, Object o) {
		{
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_remove) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.err.println("HashCode changed for Object " + o + " while being in a Hashtable!");
			System.exit(1);
		}

	}

	final void reset() {
		this.pairValue.set(this.calculatePairValue(-1, 0) ) ;

		Prop_1_Category_violation = false;
	}

	// RVMRef_t was suppressed to reduce memory overhead
	// RVMRef_o was suppressed to reduce memory overhead

	//alive_parameters_0 = [HashSet t, Object o]
	boolean alive_parameters_0 = true;

	@Override
	protected final void terminateInternal(int idnum) {
		int lastEvent = this.getLastEvent();

		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
			case 1:
			alive_parameters_0 = false;
			break;
		}
		switch(lastEvent) {
			case -1:
			return;
			case 0:
			//add
			//alive_t && alive_o
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//bad_use
			return;
			case 2:
			//remove
			return;
		}
		return;
	}

	public static int getNumberOfEvents() {
		return 3;
	}

	public static int getNumberOfStates() {
		return 5;
	}

}

class SafeHashSetRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager SafeHashSetMapManager;
	static {
		SafeHashSetMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		SafeHashSetMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock SafeHashSet_RVMLock = new ReentrantLock();
	static final Condition SafeHashSet_RVMLock_cond = SafeHashSet_RVMLock.newCondition();

	private static boolean SafeHashSet_activated = false;

	// Declarations for Indexing Trees
	private static Object SafeHashSet_t_o_Map_cachekey_o;
	private static Object SafeHashSet_t_o_Map_cachekey_t;
	private static SafeHashSetMonitor SafeHashSet_t_o_Map_cachevalue;
	private static final MapOfMap<MapOfMonitor<SafeHashSetMonitor>> SafeHashSet_t_o_Map = new MapOfMap<MapOfMonitor<SafeHashSetMonitor>>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += SafeHashSet_t_o_Map.cleanUpUnnecessaryMappings();
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

	public static final void addEvent(HashSet t, Object o) {
		SafeHashSet_activated = true;
		while (!SafeHashSet_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_t = null;
		CachedWeakReference wr_o = null;
		MapOfMonitor<SafeHashSetMonitor> matchedLastMap = null;
		SafeHashSetMonitor matchedEntry = null;
		boolean cachehit = false;
		if (((o == SafeHashSet_t_o_Map_cachekey_o) && (t == SafeHashSet_t_o_Map_cachekey_t) ) ) {
			matchedEntry = SafeHashSet_t_o_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_t = new CachedWeakReference(t) ;
			wr_o = new CachedWeakReference(o) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<SafeHashSetMonitor> node_t = SafeHashSet_t_o_Map.getNodeEquivalent(wr_t) ;
				if ((node_t == null) ) {
					node_t = new MapOfMonitor<SafeHashSetMonitor>(1) ;
					SafeHashSet_t_o_Map.putNode(wr_t, node_t) ;
				}
				matchedLastMap = node_t;
				SafeHashSetMonitor node_t_o = node_t.getNodeEquivalent(wr_o) ;
				matchedEntry = node_t_o;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_t == null) ) {
				wr_t = new CachedWeakReference(t) ;
			}
			if ((wr_o == null) ) {
				wr_o = new CachedWeakReference(o) ;
			}
			// D(X) main:4
			SafeHashSetMonitor created = new SafeHashSetMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_o, created) ;
		}
		// D(X) main:8--9
		final SafeHashSetMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_add(t, o);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			SafeHashSet_t_o_Map_cachekey_o = o;
			SafeHashSet_t_o_Map_cachekey_t = t;
			SafeHashSet_t_o_Map_cachevalue = matchedEntry;
		}

		SafeHashSet_RVMLock.unlock();
	}

	public static final void bad_useEvent(HashSet t, Object o) {
		SafeHashSet_activated = true;
		while (!SafeHashSet_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_t = null;
		CachedWeakReference wr_o = null;
		MapOfMonitor<SafeHashSetMonitor> matchedLastMap = null;
		SafeHashSetMonitor matchedEntry = null;
		boolean cachehit = false;
		if (((o == SafeHashSet_t_o_Map_cachekey_o) && (t == SafeHashSet_t_o_Map_cachekey_t) ) ) {
			matchedEntry = SafeHashSet_t_o_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_t = new CachedWeakReference(t) ;
			wr_o = new CachedWeakReference(o) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<SafeHashSetMonitor> node_t = SafeHashSet_t_o_Map.getNodeEquivalent(wr_t) ;
				if ((node_t == null) ) {
					node_t = new MapOfMonitor<SafeHashSetMonitor>(1) ;
					SafeHashSet_t_o_Map.putNode(wr_t, node_t) ;
				}
				matchedLastMap = node_t;
				SafeHashSetMonitor node_t_o = node_t.getNodeEquivalent(wr_o) ;
				matchedEntry = node_t_o;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_t == null) ) {
				wr_t = new CachedWeakReference(t) ;
			}
			if ((wr_o == null) ) {
				wr_o = new CachedWeakReference(o) ;
			}
			// D(X) main:4
			SafeHashSetMonitor created = new SafeHashSetMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_o, created) ;
		}
		// D(X) main:8--9
		final SafeHashSetMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_bad_use(t, o);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			SafeHashSet_t_o_Map_cachekey_o = o;
			SafeHashSet_t_o_Map_cachekey_t = t;
			SafeHashSet_t_o_Map_cachevalue = matchedEntry;
		}

		SafeHashSet_RVMLock.unlock();
	}

	public static final void removeEvent(HashSet t, Object o) {
		SafeHashSet_activated = true;
		while (!SafeHashSet_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_t = null;
		CachedWeakReference wr_o = null;
		MapOfMonitor<SafeHashSetMonitor> matchedLastMap = null;
		SafeHashSetMonitor matchedEntry = null;
		boolean cachehit = false;
		if (((o == SafeHashSet_t_o_Map_cachekey_o) && (t == SafeHashSet_t_o_Map_cachekey_t) ) ) {
			matchedEntry = SafeHashSet_t_o_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_t = new CachedWeakReference(t) ;
			wr_o = new CachedWeakReference(o) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<SafeHashSetMonitor> node_t = SafeHashSet_t_o_Map.getNodeEquivalent(wr_t) ;
				if ((node_t == null) ) {
					node_t = new MapOfMonitor<SafeHashSetMonitor>(1) ;
					SafeHashSet_t_o_Map.putNode(wr_t, node_t) ;
				}
				matchedLastMap = node_t;
				SafeHashSetMonitor node_t_o = node_t.getNodeEquivalent(wr_o) ;
				matchedEntry = node_t_o;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_t == null) ) {
				wr_t = new CachedWeakReference(t) ;
			}
			if ((wr_o == null) ) {
				wr_o = new CachedWeakReference(o) ;
			}
			// D(X) main:4
			SafeHashSetMonitor created = new SafeHashSetMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_o, created) ;
		}
		// D(X) main:8--9
		final SafeHashSetMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_remove(t, o);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			SafeHashSet_t_o_Map_cachekey_o = o;
			SafeHashSet_t_o_Map_cachekey_t = t;
			SafeHashSet_t_o_Map_cachevalue = matchedEntry;
		}

		SafeHashSet_RVMLock.unlock();
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

public aspect SafeHashSetMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public SafeHashSetMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock SafeHashSet_MOPLock = new ReentrantLock();
	static Condition SafeHashSet_MOPLock_cond = SafeHashSet_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut SafeHashSet_bad_use(HashSet t, Object o) : (call(* Collection+.contains(Object)) && target(t) && args(o)) && MOP_CommonPointCut();
	before (HashSet t, Object o) : SafeHashSet_bad_use(t, o) {
		SafeHashSetRuntimeMonitor.bad_useEvent(t, o);
	}

	pointcut SafeHashSet_add(HashSet t, Object o) : (call(* Collection+.add(Object)) && target(t) && args(o)) && MOP_CommonPointCut();
	after (HashSet t, Object o) : SafeHashSet_add(t, o) {
		SafeHashSetRuntimeMonitor.addEvent(t, o);
	}

	pointcut SafeHashSet_remove(HashSet t, Object o) : (call(* Collection+.remove(Object)) && target(t) && args(o)) && MOP_CommonPointCut();
	after (HashSet t, Object o) : SafeHashSet_remove(t, o) {
		SafeHashSetRuntimeMonitor.removeEvent(t, o);
	}

}
