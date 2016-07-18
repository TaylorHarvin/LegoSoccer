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

final class StateChangeRawMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<StateChangeRawMonitor> {

	StateChangeRawMonitor_Set(){
		this.size = 0;
		this.elements = new StateChangeRawMonitor[4];
	}
	final void event_irModChange(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			StateChangeRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_irModChange(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class StateChangeRawMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			StateChangeRawMonitor ret = (StateChangeRawMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	@Override
	public final int getState() {
		return -1;
	}

	final boolean event_irModChange(Kicker MK) {
		RVM_lastevent = 0;
		{
			System.out.println("GENERAL TEST");
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

class StateChangeRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager StateChangeMapManager;
	static {
		StateChangeMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		StateChangeMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock StateChange_RVMLock = new ReentrantLock();
	static final Condition StateChange_RVMLock_cond = StateChange_RVMLock.newCondition();

	private static boolean StateChange_activated = false;

	// Declarations for Indexing Trees
	private static Object StateChange_MK_Map_cachekey_MK;
	private static StateChangeRawMonitor StateChange_MK_Map_cachevalue;
	private static final MapOfMonitor<StateChangeRawMonitor> StateChange_MK_Map = new MapOfMonitor<StateChangeRawMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += StateChange_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void irModChangeEvent(Kicker MK) {
		StateChange_activated = true;
		while (!StateChange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<StateChangeRawMonitor> matchedLastMap = null;
		StateChangeRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == StateChange_MK_Map_cachekey_MK) ) {
			matchedEntry = StateChange_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<StateChangeRawMonitor> itmdMap = StateChange_MK_Map;
				matchedLastMap = itmdMap;
				StateChangeRawMonitor node_MK = StateChange_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			StateChangeRawMonitor created = new StateChangeRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_irModChange(MK);

		if ((cachehit == false) ) {
			StateChange_MK_Map_cachekey_MK = MK;
			StateChange_MK_Map_cachevalue = matchedEntry;
		}

		StateChange_RVMLock.unlock();
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

public aspect StateChangeMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public StateChangeMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock StateChange_MOPLock = new ReentrantLock();
	static Condition StateChange_MOPLock_cond = StateChange_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut StateChange_irModChange(Kicker MK) : (cflow(ballinfront()) && set(float SensorControl.ballDirMod)) && MOP_CommonPointCut();
	after (Kicker MK) : StateChange_irModChange(MK) {
		StateChangeRuntimeMonitor.irModChangeEvent(MK);
	}

}
