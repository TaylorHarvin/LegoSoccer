package mop;
import java.io.*;
import java.util.*;
import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;
import lejos.robotics.RegulatedMotor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.robotics.navigation.Navigator;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;
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

final class RobotStateRawMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<RobotStateRawMonitor> {

	RobotStateRawMonitor_Set(){
		this.size = 0;
		this.elements = new RobotStateRawMonitor[4];
	}
	final void event_irModChange(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
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
	final void event_irUnModChange(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_irUnModChange(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_sonarChange(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_sonarChange(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_irSeekModeModSetup(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_irSeekModeModSetup(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_irSeekModeUnModSetup(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_irSeekModeUnModSetup(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_armSetup(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_armSetup(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_leftMotorSetup(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			RobotStateRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_leftMotorSetup(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class RobotStateRawMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			RobotStateRawMonitor ret = (RobotStateRawMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	Kicker currMK;

	@Override
	public final int getState() {
		return -1;
	}

	final boolean event_irModChange(Kicker MK) {
		RVM_lastevent = 0;
		{
			System.out.println("!!!IR Changed!!!");
			MK.GetState();
		}
		return true;
	}

	final boolean event_irUnModChange(Kicker MK) {
		RVM_lastevent = 1;
		{
			System.out.println("!!!IR Changed!!!");
			MK.GetState();
		}
		return true;
	}

	final boolean event_sonarChange(Kicker MK) {
		RVM_lastevent = 2;
		{
			System.out.println("!!!Sonar Changed!!!");
			MK.GetState();
		}
		return true;
	}

	final boolean event_irSeekModeModSetup(Kicker MK) {
		RVM_lastevent = 3;
		{
			System.out.println("!!!IR SampleProvider - MOD!!!");
			MK.GetState();
		}
		return true;
	}

	final boolean event_irSeekModeUnModSetup(Kicker MK) {
		RVM_lastevent = 4;
		{
			System.out.println("!!!IR SampleProvider - UN_MOD!!!");
			MK.GetState();
		}
		return true;
	}

	final boolean event_armSetup(Kicker MK) {
		RVM_lastevent = 5;
		{
			System.out.println("!!!ARM Setup!!!");
			MK.GetState();
		}
		return true;
	}

	final boolean event_leftMotorSetup(Kicker MK) {
		RVM_lastevent = 6;
		{
			System.out.println("!!!LEFT MOTOR!!!");
			MK.GetState();
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
			case 1:
			//irUnModChange
			return;
			case 2:
			//sonarChange
			return;
			case 3:
			//irSeekModeModSetup
			return;
			case 4:
			//irSeekModeUnModSetup
			return;
			case 5:
			//armSetup
			return;
			case 6:
			//leftMotorSetup
			return;
		}
		return;
	}

}

class RobotStateRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager RobotStateMapManager;
	static {
		RobotStateMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		RobotStateMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock RobotState_RVMLock = new ReentrantLock();
	static final Condition RobotState_RVMLock_cond = RobotState_RVMLock.newCondition();

	private static boolean RobotState_activated = false;

	// Declarations for Indexing Trees
	private static Object RobotState_MK_Map_cachekey_MK;
	private static RobotStateRawMonitor RobotState_MK_Map_cachevalue;
	private static final MapOfMonitor<RobotStateRawMonitor> RobotState_MK_Map = new MapOfMonitor<RobotStateRawMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += RobotState_MK_Map.cleanUpUnnecessaryMappings();
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
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_irModChange(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
	}

	public static final void irUnModChangeEvent(Kicker MK) {
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_irUnModChange(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
	}

	public static final void sonarChangeEvent(Kicker MK) {
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_sonarChange(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
	}

	public static final void irSeekModeModSetupEvent(Kicker MK) {
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_irSeekModeModSetup(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
	}

	public static final void irSeekModeUnModSetupEvent(Kicker MK) {
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_irSeekModeUnModSetup(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
	}

	public static final void armSetupEvent(Kicker MK) {
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_armSetup(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
	}

	public static final void leftMotorSetupEvent(Kicker MK) {
		RobotState_activated = true;
		while (!RobotState_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<RobotStateRawMonitor> matchedLastMap = null;
		RobotStateRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == RobotState_MK_Map_cachekey_MK) ) {
			matchedEntry = RobotState_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<RobotStateRawMonitor> itmdMap = RobotState_MK_Map;
				matchedLastMap = itmdMap;
				RobotStateRawMonitor node_MK = RobotState_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			RobotStateRawMonitor created = new RobotStateRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_leftMotorSetup(MK);

		if ((cachehit == false) ) {
			RobotState_MK_Map_cachekey_MK = MK;
			RobotState_MK_Map_cachevalue = matchedEntry;
		}

		RobotState_RVMLock.unlock();
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

public aspect RobotStateMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public RobotStateMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock RobotState_MOPLock = new ReentrantLock();
	static Condition RobotState_MOPLock_cond = RobotState_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut RobotState_irModChange(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(float SensorControl.ballDirMod)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_irModChange(MK) {
		RobotStateRuntimeMonitor.irModChangeEvent(MK);
	}

	pointcut RobotState_irUnModChange(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(float SensorControl.ballDirUnMod)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_irUnModChange(MK) {
		RobotStateRuntimeMonitor.irUnModChangeEvent(MK);
	}

	pointcut RobotState_sonarChange(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(float[] SensorControl.distanceSample)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_sonarChange(MK) {
		RobotStateRuntimeMonitor.sonarChangeEvent(MK);
	}

	pointcut RobotState_irSeekModeModSetup(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(SampleProvider SensorControl.irSeekModeMod)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_irSeekModeModSetup(MK) {
		RobotStateRuntimeMonitor.irSeekModeModSetupEvent(MK);
	}

	pointcut RobotState_irSeekModeUnModSetup(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(SampleProvider SensorControl.irSeekModeUnMod)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_irSeekModeUnModSetup(MK) {
		RobotStateRuntimeMonitor.irSeekModeUnModSetupEvent(MK);
	}

	pointcut RobotState_armSetup(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(UnregulatedMotor MotionControl.arm)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_armSetup(MK) {
		RobotStateRuntimeMonitor.armSetupEvent(MK);
	}

	pointcut RobotState_leftMotorSetup(Kicker MK) : (cflowbelow(call(public void Kicker.play()) && target(MK)) && set(RegulatedMotor MotionControl.leftMotor)) && MOP_CommonPointCut();
	after (Kicker MK) : RobotState_leftMotorSetup(MK) {
		RobotStateRuntimeMonitor.leftMotorSetupEvent(MK);
	}

}
