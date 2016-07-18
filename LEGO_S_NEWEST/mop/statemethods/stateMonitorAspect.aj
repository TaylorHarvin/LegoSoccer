package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;
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

final class stateRawMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<stateRawMonitor> {

	stateRawMonitor_Set(){
		this.size = 0;
		this.elements = new stateRawMonitor[4];
	}
	final void event_test1(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			stateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_test1(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class stateRawMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			stateRawMonitor ret = (stateRawMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	MotionControl currMC;

	@Override
	public final int getState() {
		return -1;
	}

	final boolean event_test1(Kicker MK) {
		RVM_lastevent = 0;
		{
			System.out.println("Test Event");
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
			//test1
			return;
		}
		return;
	}

}

class stateRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager stateMapManager;
	static {
		stateMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		stateMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock state_RVMLock = new ReentrantLock();
	static final Condition state_RVMLock_cond = state_RVMLock.newCondition();

	private static boolean state_activated = false;

	// Declarations for Indexing Trees
	private static Object state_MK_Map_cachekey_MK;
	private static stateRawMonitor state_MK_Map_cachevalue;
	private static final MapOfMonitor<stateRawMonitor> state_MK_Map = new MapOfMonitor<stateRawMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += state_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void test1Event(Kicker MK) {
		state_activated = true;
		while (!state_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<stateRawMonitor> matchedLastMap = null;
		stateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == state_MK_Map_cachekey_MK) ) {
			matchedEntry = state_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<stateRawMonitor> itmdMap = state_MK_Map;
				matchedLastMap = itmdMap;
				stateRawMonitor node_MK = state_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			stateRawMonitor created = new stateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_test1(MK);

		if ((cachehit == false) ) {
			state_MK_Map_cachekey_MK = MK;
			state_MK_Map_cachevalue = matchedEntry;
		}

		state_RVMLock.unlock();
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

public aspect stateMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public stateMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock state_MOPLock = new ReentrantLock();
	static Condition state_MOPLock_cond = state_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut state_test1(Kicker MK) : (set(float SensorControl.ballDirMod) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : state_test1(MK) {
		stateRuntimeMonitor.test1Event(MK);
	}

}
