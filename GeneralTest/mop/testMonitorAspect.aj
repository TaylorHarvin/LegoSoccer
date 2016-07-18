package mop;
import java.io.*;
import java.util.*;
import base.ChildTest;
import base.TestParent;
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

final class testmopRawMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<testmopRawMonitor> {

	testmopRawMonitor_Set(){
		this.size = 0;
		this.elements = new testmopRawMonitor[4];
	}
	final void event_genEvent(ChildTest baseChild) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			testmopRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_genEvent(baseChild);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class testmopRawMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			testmopRawMonitor ret = (testmopRawMonitor) super.clone();
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

	final boolean event_genEvent(ChildTest baseChild) {
		RVM_lastevent = 0;
		{
		}
		return true;
	}

	final void reset() {
		RVM_lastevent = -1;
	}

	CachedWeakReference RVMRef_baseChild;
	CachedWeakReference RVMRef_baseParent;

	@Override
	protected final void terminateInternal(int idnum) {
		switch(idnum){
			case 0:
			break;
			case 1:
			break;
		}
		switch(RVM_lastevent) {
			case -1:
			return;
			case 0:
			//genEvent
			return;
		}
		return;
	}

}

class testRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager testMapManager;
	static {
		testMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		testMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock test_RVMLock = new ReentrantLock();
	static final Condition test_RVMLock_cond = test_RVMLock.newCondition();

	// Declarations for Timestamps
	private static long testmop_timestamp = 1;

	private static boolean testmop_activated = false;

	// Declarations for Indexing Trees
	private static Object testmop_baseChild_Map_cachekey_baseChild;
	private static Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> testmop_baseChild_Map_cachevalue;
	private static Object testmop_baseChild_baseParent_Map_cachekey_baseChild;
	private static Object testmop_baseChild_baseParent_Map_cachekey_baseParent;
	private static ItestmopRawMonitor testmop_baseChild_baseParent_Map_cachevalue;
	private static final MapOfAll<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> testmop_baseChild_baseParent_Map = new MapOfAll<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor>(0) ;
	private static final Tuple2<testmopRawMonitor_Set, testmopRawMonitor> testmop___To__baseParent_Map = new Tuple2<testmopRawMonitor_Set, testmopRawMonitor>(new testmopRawMonitor_Set() , null) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += testmop_baseChild_baseParent_Map.cleanUpUnnecessaryMappings();
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

	public static final void genEventEvent(ChildTest baseChild) {
		testmop_activated = true;
		while (!test_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_baseChild = null;
		Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((baseChild == testmop_baseChild_Map_cachekey_baseChild) ) {
			matchedEntry = testmop_baseChild_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_baseChild = new CachedWeakReference(baseChild) ;
			{
				// FindOrCreateEntry
				Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> node_baseChild = testmop_baseChild_baseParent_Map.getNodeEquivalent(wr_baseChild) ;
				if ((node_baseChild == null) ) {
					node_baseChild = new Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor>() ;
					testmop_baseChild_baseParent_Map.putNode(wr_baseChild, node_baseChild) ;
					node_baseChild.setValue1(new MapOfMonitor<ItestmopRawMonitor>(1) ) ;
					node_baseChild.setValue2(new testmopRawMonitor_Set() ) ;
				}
				matchedEntry = node_baseChild;
			}
		}
		// D(X) main:1
		testmopRawMonitor matchedLeaf = matchedEntry.getValue3() ;
		if ((matchedLeaf == null) ) {
			if ((wr_baseChild == null) ) {
				wr_baseChild = new CachedWeakReference(baseChild) ;
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				testmopRawMonitor_Set sourceSet = null;
				{
					// FindCode
					testmopRawMonitor_Set itmdSet = testmop___To__baseParent_Map.getValue1() ;
					sourceSet = itmdSet;
				}
				if ((sourceSet != null) ) {
					int numalive = 0;
					int setlen = sourceSet.getSize() ;
					for (int ielem = 0; (ielem < setlen) ;++ielem) {
						testmopRawMonitor sourceMonitor = sourceSet.get(ielem) ;
						if ((!sourceMonitor.isTerminated() && (sourceMonitor.RVMRef_baseParent.get() != null) ) ) {
							sourceSet.set(numalive++, sourceMonitor) ;
							CachedWeakReference wr_baseParent = sourceMonitor.RVMRef_baseParent;
							MapOfMonitor<ItestmopRawMonitor> destLastMap = null;
							ItestmopRawMonitor destLeaf = null;
							{
								// FindOrCreate
								Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> node_baseChild = testmop_baseChild_baseParent_Map.getNodeEquivalent(wr_baseChild) ;
								if ((node_baseChild == null) ) {
									node_baseChild = new Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor>() ;
									testmop_baseChild_baseParent_Map.putNode(wr_baseChild, node_baseChild) ;
									node_baseChild.setValue1(new MapOfMonitor<ItestmopRawMonitor>(1) ) ;
									node_baseChild.setValue2(new testmopRawMonitor_Set() ) ;
								}
								MapOfMonitor<ItestmopRawMonitor> itmdMap = node_baseChild.getValue1() ;
								destLastMap = itmdMap;
								ItestmopRawMonitor node_baseChild_baseParent = node_baseChild.getValue1() .getNodeEquivalent(wr_baseParent) ;
								destLeaf = node_baseChild_baseParent;
							}
							if (((destLeaf == null) || destLeaf instanceof testmopRawDisableHolder) ) {
								boolean definable = true;
								// D(X) defineTo:1--5 for <baseChild>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> node_baseChild = testmop_baseChild_baseParent_Map.getNodeEquivalent(wr_baseChild) ;
									if ((node_baseChild != null) ) {
										testmopRawMonitor itmdLeaf = node_baseChild.getValue3() ;
										if ((itmdLeaf != null) ) {
											if (((itmdLeaf.getDisable() > sourceMonitor.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								// D(X) defineTo:1--5 for <baseChild, baseParent>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> node_baseChild = testmop_baseChild_baseParent_Map.getNodeEquivalent(wr_baseChild) ;
									if ((node_baseChild != null) ) {
										ItestmopRawMonitor node_baseChild_baseParent = node_baseChild.getValue1() .getNodeEquivalent(wr_baseParent) ;
										if ((node_baseChild_baseParent != null) ) {
											if (((node_baseChild_baseParent.getDisable() > sourceMonitor.getTau() ) || ((node_baseChild_baseParent.getTau() > 0) && (node_baseChild_baseParent.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								if (definable) {
									// D(X) defineTo:6
									testmopRawMonitor created = (testmopRawMonitor)sourceMonitor.clone() ;
									created.RVMRef_baseChild = wr_baseChild;
									destLastMap.putNode(wr_baseParent, created) ;
									// D(X) defineTo:7 for <baseChild>
									{
										// InsertMonitor
										Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor> node_baseChild = testmop_baseChild_baseParent_Map.getNodeEquivalent(wr_baseChild) ;
										if ((node_baseChild == null) ) {
											node_baseChild = new Tuple3<MapOfMonitor<ItestmopRawMonitor>, testmopRawMonitor_Set, testmopRawMonitor>() ;
											testmop_baseChild_baseParent_Map.putNode(wr_baseChild, node_baseChild) ;
											node_baseChild.setValue1(new MapOfMonitor<ItestmopRawMonitor>(1) ) ;
											node_baseChild.setValue2(new testmopRawMonitor_Set() ) ;
										}
										testmopRawMonitor_Set targetSet = node_baseChild.getValue2() ;
										targetSet.add(created) ;
									}
								}
							}
						}
					}
					sourceSet.eraseRange(numalive) ;
				}
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				testmopRawMonitor created = new testmopRawMonitor(testmop_timestamp++, wr_baseChild, null) ;
				matchedEntry.setValue3(created) ;
				testmopRawMonitor_Set enclosingSet = matchedEntry.getValue2() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			testmopRawMonitor disableUpdatedLeaf = matchedEntry.getValue3() ;
			disableUpdatedLeaf.setDisable(testmop_timestamp++) ;
		}
		// D(X) main:8--9
		testmopRawMonitor_Set stateTransitionedSet = matchedEntry.getValue2() ;
		stateTransitionedSet.event_genEvent(baseChild);

		if ((cachehit == false) ) {
			testmop_baseChild_Map_cachekey_baseChild = baseChild;
			testmop_baseChild_Map_cachevalue = matchedEntry;
		}

		test_RVMLock.unlock();
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

public aspect testMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public testMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock test_MOPLock = new ReentrantLock();
	static Condition test_MOPLock_cond = test_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut testmop_genEvent(ChildTest baseChild) : (set(float ChildTest.val) && this(baseChild)) && MOP_CommonPointCut();
	after (ChildTest baseChild) : testmop_genEvent(baseChild) {
		testRuntimeMonitor.genEventEvent(baseChild);
	}

}
