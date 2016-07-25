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


final class state_testRawMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<state_testRawMonitor> {

	state_testRawMonitor_Set(){
		this.size = 0;
		this.elements = new state_testRawMonitor[4];
	}
	final void event_irModChange() {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			state_testRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_irModChange();
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class state_testRawMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			state_testRawMonitor ret = (state_testRawMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	Kicker currMK = null;

	@Override
	public final int getState() {
		return -1;
	}

	final boolean event_irModChange() {
		RVM_lastevent = 0;
		{
		}
		return true;
	}

	final void reset() {
		RVM_lastevent = -1;
	}

	// RVMRef_MK was suppressed to reduce memory overhead

	@Override
	protected final void terminateInternal(int idnum) {
		switch(idnum){
			case 0:
			break;
		}
		switch(RVM_lastevent) {
			case -1:
			return;
			case 0:
			//irModChange
			return;
		}
		return;
	}

}

class state_testRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager state_testMapManager;
	static {
		state_testMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		state_testMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock state_test_RVMLock = new ReentrantLock();
	static final Condition state_test_RVMLock_cond = state_test_RVMLock.newCondition();

	// Declarations for Timestamps
	private static long state_test_timestamp = 1;

	private static boolean state_test_activated = false;

	// Declarations for Indexing Trees
	private static final Tuple2<state_testRawMonitor_Set, state_testRawMonitor> state_test__Map = new Tuple2<state_testRawMonitor_Set, state_testRawMonitor>(new state_testRawMonitor_Set() , null) ;

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

	public static final void irModChangeEvent() {
		state_test_activated = true;
		while (!state_test_RVMLock.tryLock()) {
			Thread.yield();
		}

		Tuple2<state_testRawMonitor_Set, state_testRawMonitor> matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = state_test__Map;
		}
		// D(X) main:1
		state_testRawMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				state_testRawMonitor created = new state_testRawMonitor(state_test_timestamp++) ;
				matchedEntry.setValue2(created) ;
				state_testRawMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			state_testRawMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(state_test_timestamp++) ;
		}
		// D(X) main:8--9
		state_testRawMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_irModChange();

		state_test_RVMLock.unlock();
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

public aspect state_testMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public state_testMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock state_test_MOPLock = new ReentrantLock();
	static Condition state_test_MOPLock_cond = state_test_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut state_test_irModChange() : (set(float SensorControl.ballDirMod)) && MOP_CommonPointCut();
	after () : state_test_irModChange() {
		state_testRuntimeMonitor.irModChangeEvent();
	}

}
