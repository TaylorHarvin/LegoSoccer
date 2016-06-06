package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;
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

final class IRSeekerReadMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<IRSeekerReadMonitor> {

	IRSeekerReadMonitor_Set(){
		this.size = 0;
		this.elements = new IRSeekerReadMonitor[4];
	}
	final void event_irsigget(SensorControl SC, boolean irRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			IRSeekerReadMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final IRSeekerReadMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_irsigget(SC, irRes);
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
	final void event_generalRotate(double turnAngle, MotionControl MC) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			IRSeekerReadMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final IRSeekerReadMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_generalRotate(turnAngle, MC);
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

interface IIRSeekerReadMonitor extends IMonitor, IDisableHolder {
}

class IRSeekerReadDisableHolder extends DisableHolder implements IIRSeekerReadMonitor {
	IRSeekerReadDisableHolder(long tau) {
		super(tau);
	}

	@Override
	public final boolean isTerminated() {
		return false;
	}

	@Override
	public int getLastEvent() {
		return -1;
	}

	@Override
	public int getState() {
		return -1;
	}

}

class IRSeekerReadMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject, IIRSeekerReadMonitor {
	protected Object clone() {
		try {
			IRSeekerReadMonitor ret = (IRSeekerReadMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	MotionControl currMC = null;

	WeakReference Ref_sc = null;
	WeakReference Ref_MC = null;
	int Prop_1_state;
	static final int Prop_1_transition_irsigget[] = {1, 1, 3, 3};;
	static final int Prop_1_transition_generalRotate[] = {2, 0, 3, 3};;

	boolean Prop_1_Category_violation = false;

	IRSeekerReadMonitor(long tau) {
		this.tau = tau;
		Prop_1_state = 0;

	}

	@Override
	public final int getState() {
		return Prop_1_state;
	}

	private final long tau;
	private long disable = -1;

	@Override
	public final long getTau() {
		return this.tau;
	}

	@Override
	public final long getDisable() {
		return this.disable;
	}

	@Override
	public final void setDisable(long value) {
		this.disable = value;
	}

	final boolean Prop_1_event_irsigget(SensorControl SC, boolean irRes) {
		MotionControl MC = null;
		if(Ref_MC != null){
			MC = (MotionControl)Ref_MC.get();
		}
		SensorControl sc = null;
		if(Ref_sc != null){
			sc = (SensorControl)Ref_sc.get();
		}
		{
			if ( ! (irRes) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("IR Check Event:\nMod: " + SC.GetLastModIR());
				System.out.println("Un-Mod: " + SC.GetLastUnModIR());
			}
		}
		RVM_lastevent = 0;

		Prop_1_state = Prop_1_transition_irsigget[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 2;
		return true;
	}

	final boolean Prop_1_event_generalRotate(double turnAngle, MotionControl MC) {
		SensorControl sc = null;
		if(Ref_sc != null){
			sc = (SensorControl)Ref_sc.get();
		}
		{
			currMC = MC;
			System.out.println("Turn Angle Event: " + turnAngle);
		}
		if(Ref_MC == null){
			Ref_MC = new WeakReference(MC);
		}
		RVM_lastevent = 1;

		Prop_1_state = Prop_1_transition_generalRotate[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 2;
		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!IRSeekerRead Fail!!!");
			boolean turnRes = currMC.TurnToBall();
			float sonarRead = 99999;
			if (!turnRes) {
				currMC.GotoWaypoint(new Waypoint(currMC.GetRobotX(), currMC.GetRobotY(), currMC.GetRobotHeading() + 360), false);
				while (currMC.RobotMoving() && sonarRead > SoccerGlobals.SONAR_OBJECT_SEEN) {
					sonarRead = currMC.mainSC.fetchSonarVal();
					System.out.println("Sonar: " + sonarRead);
				}
			}
			this.reset();
		}

	}

	final void reset() {
		RVM_lastevent = -1;
		Prop_1_state = 0;
		Prop_1_Category_violation = false;
	}

	// RVMRef_MC was suppressed to reduce memory overhead
	// RVMRef_sc was suppressed to reduce memory overhead

	//alive_parameters_0 = [MotionControl MC]
	boolean alive_parameters_0 = true;

	@Override
	protected final void terminateInternal(int idnum) {
		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
			case 1:
			break;
		}
		switch(RVM_lastevent) {
			case -1:
			return;
			case 0:
			//irsigget
			//alive_MC
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//generalRotate
			//alive_MC
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

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

class IRSeekerReadRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager IRSeekerReadMapManager;
	static {
		IRSeekerReadMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		IRSeekerReadMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock IRSeekerRead_RVMLock = new ReentrantLock();
	static final Condition IRSeekerRead_RVMLock_cond = IRSeekerRead_RVMLock.newCondition();

	// Declarations for Timestamps
	private static long IRSeekerRead_timestamp = 1;

	private static boolean IRSeekerRead_activated = false;

	// Declarations for Indexing Trees
	private static Object IRSeekerRead_MC_Map_cachekey_MC;
	private static Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> IRSeekerRead_MC_Map_cachevalue;
	private static final MapOfSetMonitor<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> IRSeekerRead_MC_Map = new MapOfSetMonitor<IRSeekerReadMonitor_Set, IRSeekerReadMonitor>(0) ;
	private static final Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> IRSeekerRead__Map = new Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor>(new IRSeekerReadMonitor_Set() , null) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += IRSeekerRead_MC_Map.cleanUpUnnecessaryMappings();
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

	public static final void irsiggetEvent(SensorControl SC, boolean irRes) {
		IRSeekerRead_activated = true;
		while (!IRSeekerRead_RVMLock.tryLock()) {
			Thread.yield();
		}

		Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = IRSeekerRead__Map;
		}
		// D(X) main:1
		IRSeekerReadMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				IRSeekerReadMonitor created = new IRSeekerReadMonitor(IRSeekerRead_timestamp++) ;
				matchedEntry.setValue2(created) ;
				IRSeekerReadMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			IRSeekerReadMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(IRSeekerRead_timestamp++) ;
		}
		// D(X) main:8--9
		IRSeekerReadMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_irsigget(SC, irRes);

		IRSeekerRead_RVMLock.unlock();
	}

	public static final void generalRotateEvent(double turnAngle, MotionControl MC) {
		IRSeekerRead_activated = true;
		while (!IRSeekerRead_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MC == IRSeekerRead_MC_Map_cachekey_MC) ) {
			matchedEntry = IRSeekerRead_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> node_MC = IRSeekerRead_MC_Map.getNodeEquivalent(wr_MC) ;
				if ((node_MC == null) ) {
					node_MC = new Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor>() ;
					IRSeekerRead_MC_Map.putNode(wr_MC, node_MC) ;
					node_MC.setValue1(new IRSeekerReadMonitor_Set() ) ;
				}
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		IRSeekerReadMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				IRSeekerReadMonitor sourceLeaf = null;
				{
					// FindCode
					IRSeekerReadMonitor itmdLeaf = IRSeekerRead__Map.getValue2() ;
					sourceLeaf = itmdLeaf;
				}
				if ((sourceLeaf != null) ) {
					boolean definable = true;
					// D(X) defineTo:1--5 for <MC>
					if (definable) {
						// FindCode
						Tuple2<IRSeekerReadMonitor_Set, IRSeekerReadMonitor> node_MC = IRSeekerRead_MC_Map.getNodeEquivalent(wr_MC) ;
						if ((node_MC != null) ) {
							IRSeekerReadMonitor itmdLeaf = node_MC.getValue2() ;
							if ((itmdLeaf != null) ) {
								if (((itmdLeaf.getDisable() > sourceLeaf.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceLeaf.getTau() ) ) ) ) {
									definable = false;
								}
							}
						}
					}
					if (definable) {
						// D(X) defineTo:6
						IRSeekerReadMonitor created = (IRSeekerReadMonitor)sourceLeaf.clone() ;
						matchedEntry.setValue2(created) ;
						matchedLeaf = created;
						IRSeekerReadMonitor_Set enclosingSet = matchedEntry.getValue1() ;
						enclosingSet.add(created) ;
						// D(X) defineTo:7 for <>
						{
							// InsertMonitor
							IRSeekerReadMonitor_Set targetSet = IRSeekerRead__Map.getValue1() ;
							targetSet.add(created) ;
						}
					}
				}
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				IRSeekerReadMonitor created = new IRSeekerReadMonitor(IRSeekerRead_timestamp++) ;
				matchedEntry.setValue2(created) ;
				IRSeekerReadMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
				// D(X) defineNew:5 for <>
				{
					// InsertMonitor
					IRSeekerReadMonitor_Set targetSet = IRSeekerRead__Map.getValue1() ;
					targetSet.add(created) ;
				}
			}
			// D(X) main:6
			IRSeekerReadMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(IRSeekerRead_timestamp++) ;
		}
		// D(X) main:8--9
		IRSeekerReadMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_generalRotate(turnAngle, MC);

		if ((cachehit == false) ) {
			IRSeekerRead_MC_Map_cachekey_MC = MC;
			IRSeekerRead_MC_Map_cachevalue = matchedEntry;
		}

		IRSeekerRead_RVMLock.unlock();
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

public aspect IRSeekerReadMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public IRSeekerReadMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock IRSeekerRead_MOPLock = new ReentrantLock();
	static Condition IRSeekerRead_MOPLock_cond = IRSeekerRead_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut IRSeekerRead_irsigget(SensorControl SC) : (call(public boolean getAllIrSig()) && target(SC)) && MOP_CommonPointCut();
	after (SensorControl SC) returning (boolean irRes) : IRSeekerRead_irsigget(SC) {
		IRSeekerReadRuntimeMonitor.irsiggetEvent(SC, irRes);
	}

	pointcut IRSeekerRead_generalRotate(double turnAngle, MotionControl MC) : (call(public boolean rotateTo(double)) && args(turnAngle) && this(MC)) && MOP_CommonPointCut();
	after (double turnAngle, MotionControl MC) : IRSeekerRead_generalRotate(turnAngle, MC) {
		IRSeekerReadRuntimeMonitor.generalRotateEvent(turnAngle, MC);
	}

}
