import java.io.*;
import java.util.*;
import lejos.hardware.port.SensorPort;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.Port;
import lejos.robotics.RegulatedMotor;
import lejos.hardware.DeviceException;
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


final class MotorSensorInitMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<MotorSensorInitMonitor> {

	MotorSensorInitMonitor_Set(){
		this.size = 0;
		this.elements = new MotorSensorInitMonitor[4];
	}
	final void event_kickerplay(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorSensorInitMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorSensorInitMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_kickerplay(MK);
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
	final void event_scconstruct(Kicker MK, Port sonarP, Port irP, Port cp, boolean sim) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorSensorInitMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorSensorInitMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_scconstruct(MK, sonarP, irP, cp, sim);
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
	final void event_mcconstruct(Kicker MK, Port lMotorPort, Port rMotorPort, Port armPort, boolean sim) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorSensorInitMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorSensorInitMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_mcconstruct(MK, lMotorPort, rMotorPort, armPort, sim);
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

class MotorSensorInitMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			MotorSensorInitMonitor ret = (MotorSensorInitMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	Kicker currMK = null;

	boolean playCalled = false;

	boolean sensorConstructCalled = false;

	boolean motionConstructCalled = false;

	static final int Prop_1_transition_kickerplay[] = {2, 2, 5, 2, 4, 5};;
	static final int Prop_1_transition_scconstruct[] = {3, 4, 5, 3, 4, 5};;
	static final int Prop_1_transition_mcconstruct[] = {1, 1, 5, 4, 4, 5};;

	volatile boolean Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	MotorSensorInitMonitor() {
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

	final boolean Prop_1_event_kickerplay(Kicker MK) {
		{
			System.out.println("After : Kicker Constructor");
			playCalled = true;
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_kickerplay) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_scconstruct(Kicker MK, Port sonarP, Port irP, Port cp, boolean sim) {
		{
			currMK = MK;
			System.out.println("Sensor Port Check:");
			if (sonarP != SensorPort.S2) {
				System.out.println("Sonar port was: " + sonarP);
				sonarP = SensorPort.S2;
				System.out.println("Sonar port corrected: " + sonarP);
			} else {
				System.out.println("Sonar port correct");
			}
			if (irP != SensorPort.S3) {
				System.out.println("IR port was: " + irP);
				irP = SensorPort.S3;
				System.out.println("IR port corrected: " + irP);
			} else {
				System.out.println("IR port correct");
			}
			if (cp != SensorPort.S4) {
				System.out.println("Compass port was: " + cp);
				cp = SensorPort.S4;
				System.out.println("Compass port corrected: " + cp);
			} else {
				System.out.println("Compass port correct");
			}
			sensorConstructCalled = true;
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_scconstruct) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_mcconstruct(Kicker MK, Port lMotorPort, Port rMotorPort, Port armPort, boolean sim) {
		{
			currMK = MK;
			System.out.println("Motor Port Check:");
			if (lMotorPort != MotorPort.A) {
				System.out.println("Left motor port was: " + lMotorPort);
				lMotorPort = MotorPort.A;
				System.out.println("Left motor port corrected: " + lMotorPort);
			} else {
				System.out.println("Left motor port correct");
			}
			if (rMotorPort != MotorPort.D) {
				System.out.println("Right motor port was: " + rMotorPort);
				rMotorPort = MotorPort.D;
				System.out.println("Right motor port corrected: " + rMotorPort);
			} else {
				System.out.println("Right motor port correct");
			}
			if (armPort != MotorPort.C) {
				System.out.println("Arm motor port was: " + armPort);
				armPort = MotorPort.C;
				System.out.println("Arm motor port corrected: " + armPort);
			} else {
				System.out.println("Arm motor port correct");
			}
			motionConstructCalled = true;
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_mcconstruct) ;
		this.Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("!!!Motor/Sensor Init LTL FAIL!!!");
			if (!motionConstructCalled) {
				System.out.println("!!!MotionControl Setup -- In LTL!!!");
				currMK.setMotionControl(new MotionControl(MotorPort.A, MotorPort.D, MotorPort.C, false));
				System.out.println("!!!MotionControl Setup -- SUCCESS!!!");
			} else {
				System.out.println("!!!MotionControl Already Setup!!!");
			}
			if (!sensorConstructCalled) {
				System.out.println("!!!SensorControl Setup -- In LTL!!!");
				currMK.setSensorControl(new SensorControl(SensorPort.S2, SensorPort.S3, SensorPort.S4, false));
				System.out.println("!!!SensorControl Setup -- SUCCESS!!!");
			} else {
				System.out.println("!!!MotionControl Already Setup!!!");
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
			//kickerplay
			return;
			case 1:
			//scconstruct
			//alive_MK
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//mcconstruct
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
		return 3;
	}

	public static int getNumberOfStates() {
		return 6;
	}

}

class MotorSensorInitRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager MotorSensorInitMapManager;
	static {
		MotorSensorInitMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		MotorSensorInitMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock MotorSensorInit_RVMLock = new ReentrantLock();
	static final Condition MotorSensorInit_RVMLock_cond = MotorSensorInit_RVMLock.newCondition();

	private static boolean MotorSensorInit_activated = false;

	// Declarations for Indexing Trees
	private static Object MotorSensorInit_MK_Map_cachekey_MK;
	private static MotorSensorInitMonitor MotorSensorInit_MK_Map_cachevalue;
	private static final MapOfMonitor<MotorSensorInitMonitor> MotorSensorInit_MK_Map = new MapOfMonitor<MotorSensorInitMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += MotorSensorInit_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void kickerplayEvent(Kicker MK) {
		MotorSensorInit_activated = true;
		while (!MotorSensorInit_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<MotorSensorInitMonitor> matchedLastMap = null;
		MotorSensorInitMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == MotorSensorInit_MK_Map_cachekey_MK) ) {
			matchedEntry = MotorSensorInit_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<MotorSensorInitMonitor> itmdMap = MotorSensorInit_MK_Map;
				matchedLastMap = itmdMap;
				MotorSensorInitMonitor node_MK = MotorSensorInit_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			MotorSensorInitMonitor created = new MotorSensorInitMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final MotorSensorInitMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_kickerplay(MK);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			MotorSensorInit_MK_Map_cachekey_MK = MK;
			MotorSensorInit_MK_Map_cachevalue = matchedEntry;
		}

		MotorSensorInit_RVMLock.unlock();
	}

	public static final void scconstructEvent(Kicker MK, Port sonarP, Port irP, Port cp, boolean sim) {
		MotorSensorInit_activated = true;
		while (!MotorSensorInit_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<MotorSensorInitMonitor> matchedLastMap = null;
		MotorSensorInitMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == MotorSensorInit_MK_Map_cachekey_MK) ) {
			matchedEntry = MotorSensorInit_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<MotorSensorInitMonitor> itmdMap = MotorSensorInit_MK_Map;
				matchedLastMap = itmdMap;
				MotorSensorInitMonitor node_MK = MotorSensorInit_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			MotorSensorInitMonitor created = new MotorSensorInitMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final MotorSensorInitMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_scconstruct(MK, sonarP, irP, cp, sim);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			MotorSensorInit_MK_Map_cachekey_MK = MK;
			MotorSensorInit_MK_Map_cachevalue = matchedEntry;
		}

		MotorSensorInit_RVMLock.unlock();
	}

	public static final void mcconstructEvent(Kicker MK, Port lMotorPort, Port rMotorPort, Port armPort, boolean sim) {
		MotorSensorInit_activated = true;
		while (!MotorSensorInit_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<MotorSensorInitMonitor> matchedLastMap = null;
		MotorSensorInitMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == MotorSensorInit_MK_Map_cachekey_MK) ) {
			matchedEntry = MotorSensorInit_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<MotorSensorInitMonitor> itmdMap = MotorSensorInit_MK_Map;
				matchedLastMap = itmdMap;
				MotorSensorInitMonitor node_MK = MotorSensorInit_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			MotorSensorInitMonitor created = new MotorSensorInitMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		final MotorSensorInitMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_mcconstruct(MK, lMotorPort, rMotorPort, armPort, sim);
		if(matchedEntryfinalMonitor.Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			MotorSensorInit_MK_Map_cachekey_MK = MK;
			MotorSensorInit_MK_Map_cachevalue = matchedEntry;
		}

		MotorSensorInit_RVMLock.unlock();
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

public aspect MotorSensorInitMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public MotorSensorInitMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock MotorSensorInit_MOPLock = new ReentrantLock();
	static Condition MotorSensorInit_MOPLock_cond = MotorSensorInit_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut MotorSensorInit_mcconstruct(Kicker MK, Port lMotorPort, Port rMotorPort, Port armPort, boolean sim) : (call(MotionControl.new(Port, Port, Port, boolean)) && args(lMotorPort, rMotorPort, armPort, sim) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK, Port lMotorPort, Port rMotorPort, Port armPort, boolean sim) : MotorSensorInit_mcconstruct(MK, lMotorPort, rMotorPort, armPort, sim) {
		MotorSensorInitRuntimeMonitor.mcconstructEvent(MK, lMotorPort, rMotorPort, armPort, sim);
	}

	pointcut MotorSensorInit_scconstruct(Kicker MK, Port sonarP, Port irP, Port cp, boolean sim) : (call(SensorControl.new(Port, Port, Port, boolean)) && args(sonarP, irP, cp, sim) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK, Port sonarP, Port irP, Port cp, boolean sim) : MotorSensorInit_scconstruct(MK, sonarP, irP, cp, sim) {
		MotorSensorInitRuntimeMonitor.scconstructEvent(MK, sonarP, irP, cp, sim);
	}

	pointcut MotorSensorInit_kickerplay(Kicker MK) : (call(public void play()) && target(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : MotorSensorInit_kickerplay(MK) {
		MotorSensorInitRuntimeMonitor.kickerplayEvent(MK);
	}

}
