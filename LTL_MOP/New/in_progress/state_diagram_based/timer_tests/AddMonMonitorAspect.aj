import java.io.*;
import java.util.*;
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


final class addMonMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<addMonMonitor> {

	addMonMonitor_Set(){
		this.size = 0;
		this.elements = new addMonMonitor[4];
	}
	final void event_set_vals() {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			addMonMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final addMonMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_set_vals();
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
	final void event_add_vals() {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			addMonMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final addMonMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_add_vals();
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

class addMonMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			addMonMonitor ret = (addMonMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	static final int Prop_1_transition_set_vals[] = {2, 3, 2, 3};;
	static final int Prop_1_transition_add_vals[] = {1, 3, 2, 3};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	addMonMonitor() {
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

	final boolean Prop_1_event_set_vals() {
		{
			System.out.println("Vals Set Event");
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_set_vals) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final boolean Prop_1_event_add_vals() {
		{
			System.out.println("Add Vals Event");
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_add_vals) ;
		this.Prop_1_Category_violation = nextstate == 1;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!SET VALS VIOLATION!!!");
			this.reset();
		}

	}

	final void reset() {
		this.pairValue.set(this.calculatePairValue(-1, 0) ) ;

		Prop_1_Category_violation = false;
	}

	@Override
	protected final void terminateInternal(int idnum) {
		int lastEvent = this.getLastEvent();

		switch(idnum){
		}
		switch(lastEvent) {
			case -1:
			return;
			case 0:
			//set_vals
			return;
			case 1:
			//add_vals
			return;
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

class AddMonRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager AddMonMapManager;
	static {
		AddMonMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		AddMonMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock AddMon_RVMLock = new ReentrantLock();
	static final Condition AddMon_RVMLock_cond = AddMon_RVMLock.newCondition();

	private static boolean addMon_activated = false;

	// Declarations for Indexing Trees
	private static final addMonMonitor addMon__Map = new addMonMonitor() ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
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

	public static final void set_valsEvent() {
		addMon_activated = true;
		while (!AddMon_RVMLock.tryLock()) {
			Thread.yield();
		}

		addMonMonitor matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = addMon__Map;
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			// D(X) main:4
			addMonMonitor created = new addMonMonitor() ;
			matchedEntry = created;
		}
		// D(X) main:8--9
		final addMonMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_set_vals();
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		AddMon_RVMLock.unlock();
	}

	public static final void add_valsEvent() {
		addMon_activated = true;
		while (!AddMon_RVMLock.tryLock()) {
			Thread.yield();
		}

		addMonMonitor matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = addMon__Map;
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			// D(X) main:4
			addMonMonitor created = new addMonMonitor() ;
			matchedEntry = created;
		}
		// D(X) main:8--9
		final addMonMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_add_vals();
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		AddMon_RVMLock.unlock();
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

public aspect AddMonMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public AddMonMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock AddMon_MOPLock = new ReentrantLock();
	static Condition AddMon_MOPLock_cond = AddMon_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut addMon_add_vals() : (call(public static int AddNum())) && MOP_CommonPointCut();
	before () : addMon_add_vals() {
		AddMonRuntimeMonitor.add_valsEvent();
	}

	pointcut addMon_set_vals() : (call(public static void SetNum(int, int))) && MOP_CommonPointCut();
	after () : addMon_set_vals() {
		AddMonRuntimeMonitor.set_valsEvent();
	}

}
