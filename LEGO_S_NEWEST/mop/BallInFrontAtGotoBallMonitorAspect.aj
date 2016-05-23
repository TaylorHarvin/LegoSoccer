package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
import fullSoccer.Kicker;
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

final class BallInFrontAtGotoBallMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<BallInFrontAtGotoBallMonitor> {

	BallInFrontAtGotoBallMonitor_Set(){
		this.size = 0;
		this.elements = new BallInFrontAtGotoBallMonitor[4];
	}
	final void event_gotoball() {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotoball();
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
	final void event_ballinfronttrue(boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfronttrue(res);
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
	final void event_ballinfrontfalse(boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			BallInFrontAtGotoBallMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final BallInFrontAtGotoBallMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfrontfalse(res);
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

class BallInFrontAtGotoBallMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			BallInFrontAtGotoBallMonitor ret = (BallInFrontAtGotoBallMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	static final int Prop_1_transition_gotoball[] = {2, 0, 3, 3};;
	static final int Prop_1_transition_ballinfronttrue[] = {1, 1, 3, 3};;
	static final int Prop_1_transition_ballinfrontfalse[] = {0, 0, 3, 3};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	BallInFrontAtGotoBallMonitor() {
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

	final boolean Prop_1_event_gotoball() {
		{
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_gotoball) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_ballinfronttrue(boolean res) {
		{
			if ( ! (res) ) {
				return false;
			}
			{
				System.out.println("Ball in front true");
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_ballinfronttrue) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_ballinfrontfalse(boolean res) {
		{
			if ( ! (!res) ) {
				return false;
			}
			{
				System.out.println("Ball in front false");
			}
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_ballinfrontfalse) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!BallInFrontAtGoto FAIL!!!");
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
			//gotoball
			return;
			case 1:
			//ballinfronttrue
			return;
			case 2:
			//ballinfrontfalse
			return;
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

class BallInFrontAtGotoBallRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager BallInFrontAtGotoBallMapManager;
	static {
		BallInFrontAtGotoBallMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		BallInFrontAtGotoBallMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock BallInFrontAtGotoBall_RVMLock = new ReentrantLock();
	static final Condition BallInFrontAtGotoBall_RVMLock_cond = BallInFrontAtGotoBall_RVMLock.newCondition();

	private static boolean BallInFrontAtGotoBall_activated = false;

	// Declarations for Indexing Trees
	private static final BallInFrontAtGotoBallMonitor BallInFrontAtGotoBall__Map = new BallInFrontAtGotoBallMonitor() ;

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

	public static final void gotoballEvent() {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		BallInFrontAtGotoBallMonitor matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = BallInFrontAtGotoBall__Map;
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_gotoball();
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		BallInFrontAtGotoBall_RVMLock.unlock();
	}

	public static final void ballinfronttrueEvent(boolean res) {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		BallInFrontAtGotoBallMonitor matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = BallInFrontAtGotoBall__Map;
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfronttrue(res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		BallInFrontAtGotoBall_RVMLock.unlock();
	}

	public static final void ballinfrontfalseEvent(boolean res) {
		BallInFrontAtGotoBall_activated = true;
		while (!BallInFrontAtGotoBall_RVMLock.tryLock()) {
			Thread.yield();
		}

		BallInFrontAtGotoBallMonitor matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = BallInFrontAtGotoBall__Map;
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			// D(X) main:4
			BallInFrontAtGotoBallMonitor created = new BallInFrontAtGotoBallMonitor() ;
			matchedEntry = created;
		}
		// D(X) main:8--9
		final BallInFrontAtGotoBallMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_ballinfrontfalse(res);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		BallInFrontAtGotoBall_RVMLock.unlock();
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

public aspect BallInFrontAtGotoBallMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public BallInFrontAtGotoBallMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock BallInFrontAtGotoBall_MOPLock = new ReentrantLock();
	static Condition BallInFrontAtGotoBall_MOPLock_cond = BallInFrontAtGotoBall_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut BallInFrontAtGotoBall_gotoball() : (call(public ** GotoBall())) && MOP_CommonPointCut();
	before () : BallInFrontAtGotoBall_gotoball() {
		BallInFrontAtGotoBallRuntimeMonitor.gotoballEvent();
	}

	pointcut BallInFrontAtGotoBall_ballinfronttrue() : (call(public boolean BallInFront())) && MOP_CommonPointCut();
	after () returning (boolean res) : BallInFrontAtGotoBall_ballinfronttrue() {
		//BallInFrontAtGotoBall_ballinfronttrue
		BallInFrontAtGotoBallRuntimeMonitor.ballinfronttrueEvent(res);
		//BallInFrontAtGotoBall_ballinfrontfalse
		BallInFrontAtGotoBallRuntimeMonitor.ballinfrontfalseEvent(res);
	}

}
