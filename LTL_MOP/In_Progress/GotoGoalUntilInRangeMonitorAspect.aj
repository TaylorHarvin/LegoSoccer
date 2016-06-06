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

final class GotoGoalUntilInRangeMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<GotoGoalUntilInRangeMonitor> {

	GotoGoalUntilInRangeMonitor_Set(){
		this.size = 0;
		this.elements = new GotoGoalUntilInRangeMonitor[4];
	}
	final void event_gotogoal(boolean withBall, Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_gotogoal(withBall, MK);
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
	final void event_generalGoto(Waypoint dest) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_generalGoto(dest);
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
	final void event_ingoalrange(MotionControl MC, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ingoalrange(MC, res);
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
	final void event_robotmoving(MotionControl MC, boolean res) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_robotmoving(MC, res);
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
	final void event_ballinfront(MotionControl MC, boolean ballinfrontRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			GotoGoalUntilInRangeMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final GotoGoalUntilInRangeMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_ballinfront(MC, ballinfrontRes);
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

interface IGotoGoalUntilInRangeMonitor extends IMonitor, IDisableHolder {
}

class GotoGoalUntilInRangeDisableHolder extends DisableHolder implements IGotoGoalUntilInRangeMonitor {
	GotoGoalUntilInRangeDisableHolder(long tau) {
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

class GotoGoalUntilInRangeMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject, IGotoGoalUntilInRangeMonitor {
	protected Object clone() {
		try {
			GotoGoalUntilInRangeMonitor ret = (GotoGoalUntilInRangeMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	boolean isGotoGoal = false;

	boolean goalRangeFlag = true;

	MotionControl currMC;

	boolean ballInFrontFlag = false;

	WeakReference Ref_MC = null;
	WeakReference Ref_MK = null;
	int Prop_1_state;
	static final int Prop_1_transition_gotogoal[] = {0, 2, 2};;
	static final int Prop_1_transition_generalGoto[] = {1, 2, 2};;
	static final int Prop_1_transition_ingoalrange[] = {0, 2, 2};;
	static final int Prop_1_transition_robotmoving[] = {0, 2, 2};;
	static final int Prop_1_transition_ballinfront[] = {0, 2, 2};;

	boolean Prop_1_Category_violation = false;

	GotoGoalUntilInRangeMonitor(long tau, CachedWeakReference RVMRef_MK, CachedWeakReference RVMRef_MC) {
		this.tau = tau;
		Prop_1_state = 0;

		this.RVMRef_MK = RVMRef_MK;
		this.RVMRef_MC = RVMRef_MC;
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

	final boolean Prop_1_event_gotogoal(boolean withBall, Kicker MK) {
		MotionControl MC = null;
		if(Ref_MC != null){
			MC = (MotionControl)Ref_MC.get();
		}
		{
			System.out.println("Goto Goal Event");
			currMC = MK.GetMotionControl();
			isGotoGoal = withBall;
		}
		if(Ref_MK == null){
			Ref_MK = new WeakReference(MK);
		}
		RVM_lastevent = 0;

		Prop_1_state = Prop_1_transition_gotogoal[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final boolean Prop_1_event_generalGoto(Waypoint dest) {
		Kicker MK = null;
		if(Ref_MK != null){
			MK = (Kicker)Ref_MK.get();
		}
		MotionControl MC = null;
		if(Ref_MC != null){
			MC = (MotionControl)Ref_MC.get();
		}
		{
			if (dest.x == SoccerGlobals.GOAL_LOCATION.x && dest.y == SoccerGlobals.GOAL_LOCATION.y) {
				isGotoGoal = true;
			} else {
				isGotoGoal = false;
			}
		}
		RVM_lastevent = 1;

		Prop_1_state = Prop_1_transition_generalGoto[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final boolean Prop_1_event_ingoalrange(MotionControl MC, boolean res) {
		Kicker MK = null;
		if(Ref_MK != null){
			MK = (Kicker)Ref_MK.get();
		}
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Goal Range Check: " + res);
			}
		}
		if(Ref_MC == null){
			Ref_MC = new WeakReference(MC);
		}
		RVM_lastevent = 2;

		Prop_1_state = Prop_1_transition_ingoalrange[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final boolean Prop_1_event_robotmoving(MotionControl MC, boolean res) {
		Kicker MK = null;
		if(Ref_MK != null){
			MK = (Kicker)Ref_MK.get();
		}
		{
			if ( ! (res) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Movement Check: " + res);
			}
		}
		if(Ref_MC == null){
			Ref_MC = new WeakReference(MC);
		}
		RVM_lastevent = 3;

		Prop_1_state = Prop_1_transition_robotmoving[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final boolean Prop_1_event_ballinfront(MotionControl MC, boolean ballinfrontRes) {
		Kicker MK = null;
		if(Ref_MK != null){
			MK = (Kicker)Ref_MK.get();
		}
		{
			if ( ! (ballinfrontRes) ) {
				return false;
			}
			{
				currMC = MC;
				System.out.println("Ball in front: " + ballinfrontRes);
				ballInFrontFlag = ballinfrontRes;
			}
		}
		if(Ref_MC == null){
			Ref_MC = new WeakReference(MC);
		}
		RVM_lastevent = 4;

		Prop_1_state = Prop_1_transition_ballinfront[Prop_1_state];
		Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final void Prop_1_handler_violation (){
		{
			if (isGotoGoal) {
				System.out.println("!!!GotoGoalUntilInRange FAIL!!!");
				Delay.msDelay(10000);
			}
			this.reset();
		}

	}

	final void reset() {
		RVM_lastevent = -1;
		Prop_1_state = 0;
		Prop_1_Category_violation = false;
	}

	CachedWeakReference RVMRef_MK;
	CachedWeakReference RVMRef_MC;

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
			//gotogoal
			return;
			case 1:
			//generalGoto
			return;
			case 2:
			//ingoalrange
			return;
			case 3:
			//robotmoving
			return;
			case 4:
			//ballinfront
			return;
		}
		return;
	}

	public static int getNumberOfEvents() {
		return 5;
	}

	public static int getNumberOfStates() {
		return 3;
	}

}

class GotoGoalUntilInRangeRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager GotoGoalUntilInRangeMapManager;
	static {
		GotoGoalUntilInRangeMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		GotoGoalUntilInRangeMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock GotoGoalUntilInRange_RVMLock = new ReentrantLock();
	static final Condition GotoGoalUntilInRange_RVMLock_cond = GotoGoalUntilInRange_RVMLock.newCondition();

	// Declarations for Timestamps
	private static long GotoGoalUntilInRange_timestamp = 1;

	private static boolean GotoGoalUntilInRange_activated = false;

	// Declarations for Indexing Trees
	private static Object GotoGoalUntilInRange_MC_Map_cachekey_MC;
	private static Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange_MC_Map_cachevalue;
	private static Object GotoGoalUntilInRange_MK_Map_cachekey_MK;
	private static Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange_MK_Map_cachevalue;
	private static Object GotoGoalUntilInRange_MK_MC_Map_cachekey_MC;
	private static Object GotoGoalUntilInRange_MK_MC_Map_cachekey_MK;
	private static IGotoGoalUntilInRangeMonitor GotoGoalUntilInRange_MK_MC_Map_cachevalue;
	private static final MapOfAll<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange_MK_MC_Map = new MapOfAll<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>(0) ;
	private static final MapOfSetMonitor<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange_MC_Map = new MapOfSetMonitor<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>(1) ;
	private static final Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange__Map = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>(new GotoGoalUntilInRangeMonitor_Set() , null) ;
	private static final Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange___To__MC_Map = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>(new GotoGoalUntilInRangeMonitor_Set() , null) ;
	private static final Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> GotoGoalUntilInRange___To__MK_Map = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>(new GotoGoalUntilInRangeMonitor_Set() , null) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += GotoGoalUntilInRange_MK_MC_Map.cleanUpUnnecessaryMappings();
		collected += GotoGoalUntilInRange_MC_Map.cleanUpUnnecessaryMappings();
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

	public static final void gotogoalEvent(boolean withBall, Kicker MK) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MK == GotoGoalUntilInRange_MK_Map_cachekey_MK) ) {
			matchedEntry = GotoGoalUntilInRange_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
				if ((node_MK == null) ) {
					node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
					GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
					node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
					node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
				}
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		GotoGoalUntilInRangeMonitor matchedLeaf = matchedEntry.getValue3() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor_Set sourceSet = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor_Set itmdSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
					sourceSet = itmdSet;
				}
				if ((sourceSet != null) ) {
					int numalive = 0;
					int setlen = sourceSet.getSize() ;
					for (int ielem = 0; (ielem < setlen) ;++ielem) {
						GotoGoalUntilInRangeMonitor sourceMonitor = sourceSet.get(ielem) ;
						if ((!sourceMonitor.isTerminated() && (sourceMonitor.RVMRef_MC.get() != null) ) ) {
							sourceSet.set(numalive++, sourceMonitor) ;
							CachedWeakReference wr_MC = sourceMonitor.RVMRef_MC;
							MapOfMonitor<IGotoGoalUntilInRangeMonitor> destLastMap = null;
							IGotoGoalUntilInRangeMonitor destLeaf = null;
							{
								// FindOrCreate
								Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
								if ((node_MK == null) ) {
									node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
									GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
									node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
									node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
								}
								MapOfMonitor<IGotoGoalUntilInRangeMonitor> itmdMap = node_MK.getValue1() ;
								destLastMap = itmdMap;
								IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
								destLeaf = node_MK_MC;
							}
							if (((destLeaf == null) || destLeaf instanceof GotoGoalUntilInRangeDisableHolder) ) {
								boolean definable = true;
								// D(X) defineTo:1--5 for <MK>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
									if ((node_MK != null) ) {
										GotoGoalUntilInRangeMonitor itmdLeaf = node_MK.getValue3() ;
										if ((itmdLeaf != null) ) {
											if (((itmdLeaf.getDisable() > sourceMonitor.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								// D(X) defineTo:1--5 for <MK, MC>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
									if ((node_MK != null) ) {
										IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
										if ((node_MK_MC != null) ) {
											if (((node_MK_MC.getDisable() > sourceMonitor.getTau() ) || ((node_MK_MC.getTau() > 0) && (node_MK_MC.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								if (definable) {
									// D(X) defineTo:6
									GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceMonitor.clone() ;
									created.RVMRef_MK = wr_MK;
									destLastMap.putNode(wr_MC, created) ;
									// D(X) defineTo:7 for <>
									{
										// InsertMonitor
										GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MC>
									{
										// InsertMonitor
										Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
										if ((node_MC == null) ) {
											node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
											node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MC.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MK>
									{
										// InsertMonitor
										Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
										if ((node_MK == null) ) {
											node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
											node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
											node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MK.getValue2() ;
										targetSet.add(created) ;
									}
								}
							}
						}
					}
					sourceSet.eraseRange(numalive) ;
				}
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor sourceLeaf = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor itmdLeaf = GotoGoalUntilInRange__Map.getValue2() ;
					sourceLeaf = itmdLeaf;
				}
				if ((sourceLeaf != null) ) {
					boolean definable = true;
					// D(X) defineTo:1--5 for <MK>
					if (definable) {
						// FindCode
						Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
						if ((node_MK != null) ) {
							GotoGoalUntilInRangeMonitor itmdLeaf = node_MK.getValue3() ;
							if ((itmdLeaf != null) ) {
								if (((itmdLeaf.getDisable() > sourceLeaf.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceLeaf.getTau() ) ) ) ) {
									definable = false;
								}
							}
						}
					}
					if (definable) {
						// D(X) defineTo:6
						GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceLeaf.clone() ;
						created.RVMRef_MK = wr_MK;
						matchedEntry.setValue3(created) ;
						matchedLeaf = created;
						GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue2() ;
						enclosingSet.add(created) ;
						// D(X) defineTo:7 for <>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
							targetSet.add(created) ;
						}
						// D(X) defineTo:7 for <-MK>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MK_Map.getValue1() ;
							targetSet.add(created) ;
						}
					}
				}
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor(GotoGoalUntilInRange_timestamp++, wr_MK, null) ;
				matchedEntry.setValue3(created) ;
				GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue2() ;
				enclosingSet.add(created) ;
				// D(X) defineNew:5 for <>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
					targetSet.add(created) ;
				}
				// D(X) defineNew:5 for <-MK>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MK_Map.getValue1() ;
					targetSet.add(created) ;
				}
			}
			// D(X) main:6
			GotoGoalUntilInRangeMonitor disableUpdatedLeaf = matchedEntry.getValue3() ;
			disableUpdatedLeaf.setDisable(GotoGoalUntilInRange_timestamp++) ;
		}
		// D(X) main:8--9
		GotoGoalUntilInRangeMonitor_Set stateTransitionedSet = matchedEntry.getValue2() ;
		stateTransitionedSet.event_gotogoal(withBall, MK);

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MK_Map_cachekey_MK = MK;
			GotoGoalUntilInRange_MK_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
	}

	public static final void generalGotoEvent(Waypoint dest) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = GotoGoalUntilInRange__Map;
		}
		// D(X) main:1
		GotoGoalUntilInRangeMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor(GotoGoalUntilInRange_timestamp++, null, null) ;
				matchedEntry.setValue2(created) ;
				GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			GotoGoalUntilInRangeMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(GotoGoalUntilInRange_timestamp++) ;
		}
		// D(X) main:8--9
		GotoGoalUntilInRangeMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_generalGoto(dest);

		GotoGoalUntilInRange_RVMLock.unlock();
	}

	public static final void ingoalrangeEvent(MotionControl MC, boolean res) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MC == GotoGoalUntilInRange_MC_Map_cachekey_MC) ) {
			matchedEntry = GotoGoalUntilInRange_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
				if ((node_MC == null) ) {
					node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
					GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
					node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
				}
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		GotoGoalUntilInRangeMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor_Set sourceSet = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor_Set itmdSet = GotoGoalUntilInRange___To__MK_Map.getValue1() ;
					sourceSet = itmdSet;
				}
				if ((sourceSet != null) ) {
					int numalive = 0;
					int setlen = sourceSet.getSize() ;
					for (int ielem = 0; (ielem < setlen) ;++ielem) {
						GotoGoalUntilInRangeMonitor sourceMonitor = sourceSet.get(ielem) ;
						if ((!sourceMonitor.isTerminated() && (sourceMonitor.RVMRef_MK.get() != null) ) ) {
							sourceSet.set(numalive++, sourceMonitor) ;
							CachedWeakReference wr_MK = sourceMonitor.RVMRef_MK;
							MapOfMonitor<IGotoGoalUntilInRangeMonitor> destLastMap = null;
							IGotoGoalUntilInRangeMonitor destLeaf = null;
							{
								// FindOrCreate
								Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
								if ((node_MK == null) ) {
									node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
									GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
									node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
									node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
								}
								MapOfMonitor<IGotoGoalUntilInRangeMonitor> itmdMap = node_MK.getValue1() ;
								destLastMap = itmdMap;
								IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
								destLeaf = node_MK_MC;
							}
							if (((destLeaf == null) || destLeaf instanceof GotoGoalUntilInRangeDisableHolder) ) {
								boolean definable = true;
								// D(X) defineTo:1--5 for <MC>
								if (definable) {
									// FindCode
									Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
									if ((node_MC != null) ) {
										GotoGoalUntilInRangeMonitor itmdLeaf = node_MC.getValue2() ;
										if ((itmdLeaf != null) ) {
											if (((itmdLeaf.getDisable() > sourceMonitor.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								// D(X) defineTo:1--5 for <MK, MC>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
									if ((node_MK != null) ) {
										IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
										if ((node_MK_MC != null) ) {
											if (((node_MK_MC.getDisable() > sourceMonitor.getTau() ) || ((node_MK_MC.getTau() > 0) && (node_MK_MC.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								if (definable) {
									// D(X) defineTo:6
									GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceMonitor.clone() ;
									created.RVMRef_MC = wr_MC;
									destLastMap.putNode(wr_MC, created) ;
									// D(X) defineTo:7 for <>
									{
										// InsertMonitor
										GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MC>
									{
										// InsertMonitor
										Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
										if ((node_MC == null) ) {
											node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
											node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MC.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MK>
									{
										// InsertMonitor
										Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
										if ((node_MK == null) ) {
											node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
											node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
											node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MK.getValue2() ;
										targetSet.add(created) ;
									}
								}
							}
						}
					}
					sourceSet.eraseRange(numalive) ;
				}
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor sourceLeaf = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor itmdLeaf = GotoGoalUntilInRange__Map.getValue2() ;
					sourceLeaf = itmdLeaf;
				}
				if ((sourceLeaf != null) ) {
					boolean definable = true;
					// D(X) defineTo:1--5 for <MC>
					if (definable) {
						// FindCode
						Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
						if ((node_MC != null) ) {
							GotoGoalUntilInRangeMonitor itmdLeaf = node_MC.getValue2() ;
							if ((itmdLeaf != null) ) {
								if (((itmdLeaf.getDisable() > sourceLeaf.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceLeaf.getTau() ) ) ) ) {
									definable = false;
								}
							}
						}
					}
					if (definable) {
						// D(X) defineTo:6
						GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceLeaf.clone() ;
						created.RVMRef_MC = wr_MC;
						matchedEntry.setValue2(created) ;
						matchedLeaf = created;
						GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
						enclosingSet.add(created) ;
						// D(X) defineTo:7 for <>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
							targetSet.add(created) ;
						}
						// D(X) defineTo:7 for <-MC>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
							targetSet.add(created) ;
						}
					}
				}
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor(GotoGoalUntilInRange_timestamp++, null, wr_MC) ;
				matchedEntry.setValue2(created) ;
				GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
				// D(X) defineNew:5 for <>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
					targetSet.add(created) ;
				}
				// D(X) defineNew:5 for <-MC>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
					targetSet.add(created) ;
				}
			}
			// D(X) main:6
			GotoGoalUntilInRangeMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(GotoGoalUntilInRange_timestamp++) ;
		}
		// D(X) main:8--9
		GotoGoalUntilInRangeMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_ingoalrange(MC, res);

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MC_Map_cachekey_MC = MC;
			GotoGoalUntilInRange_MC_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
	}

	public static final void robotmovingEvent(MotionControl MC, boolean res) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MC == GotoGoalUntilInRange_MC_Map_cachekey_MC) ) {
			matchedEntry = GotoGoalUntilInRange_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
				if ((node_MC == null) ) {
					node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
					GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
					node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
				}
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		GotoGoalUntilInRangeMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor_Set sourceSet = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor_Set itmdSet = GotoGoalUntilInRange___To__MK_Map.getValue1() ;
					sourceSet = itmdSet;
				}
				if ((sourceSet != null) ) {
					int numalive = 0;
					int setlen = sourceSet.getSize() ;
					for (int ielem = 0; (ielem < setlen) ;++ielem) {
						GotoGoalUntilInRangeMonitor sourceMonitor = sourceSet.get(ielem) ;
						if ((!sourceMonitor.isTerminated() && (sourceMonitor.RVMRef_MK.get() != null) ) ) {
							sourceSet.set(numalive++, sourceMonitor) ;
							CachedWeakReference wr_MK = sourceMonitor.RVMRef_MK;
							MapOfMonitor<IGotoGoalUntilInRangeMonitor> destLastMap = null;
							IGotoGoalUntilInRangeMonitor destLeaf = null;
							{
								// FindOrCreate
								Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
								if ((node_MK == null) ) {
									node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
									GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
									node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
									node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
								}
								MapOfMonitor<IGotoGoalUntilInRangeMonitor> itmdMap = node_MK.getValue1() ;
								destLastMap = itmdMap;
								IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
								destLeaf = node_MK_MC;
							}
							if (((destLeaf == null) || destLeaf instanceof GotoGoalUntilInRangeDisableHolder) ) {
								boolean definable = true;
								// D(X) defineTo:1--5 for <MC>
								if (definable) {
									// FindCode
									Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
									if ((node_MC != null) ) {
										GotoGoalUntilInRangeMonitor itmdLeaf = node_MC.getValue2() ;
										if ((itmdLeaf != null) ) {
											if (((itmdLeaf.getDisable() > sourceMonitor.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								// D(X) defineTo:1--5 for <MK, MC>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
									if ((node_MK != null) ) {
										IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
										if ((node_MK_MC != null) ) {
											if (((node_MK_MC.getDisable() > sourceMonitor.getTau() ) || ((node_MK_MC.getTau() > 0) && (node_MK_MC.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								if (definable) {
									// D(X) defineTo:6
									GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceMonitor.clone() ;
									created.RVMRef_MC = wr_MC;
									destLastMap.putNode(wr_MC, created) ;
									// D(X) defineTo:7 for <>
									{
										// InsertMonitor
										GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MC>
									{
										// InsertMonitor
										Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
										if ((node_MC == null) ) {
											node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
											node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MC.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MK>
									{
										// InsertMonitor
										Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
										if ((node_MK == null) ) {
											node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
											node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
											node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MK.getValue2() ;
										targetSet.add(created) ;
									}
								}
							}
						}
					}
					sourceSet.eraseRange(numalive) ;
				}
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor sourceLeaf = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor itmdLeaf = GotoGoalUntilInRange__Map.getValue2() ;
					sourceLeaf = itmdLeaf;
				}
				if ((sourceLeaf != null) ) {
					boolean definable = true;
					// D(X) defineTo:1--5 for <MC>
					if (definable) {
						// FindCode
						Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
						if ((node_MC != null) ) {
							GotoGoalUntilInRangeMonitor itmdLeaf = node_MC.getValue2() ;
							if ((itmdLeaf != null) ) {
								if (((itmdLeaf.getDisable() > sourceLeaf.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceLeaf.getTau() ) ) ) ) {
									definable = false;
								}
							}
						}
					}
					if (definable) {
						// D(X) defineTo:6
						GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceLeaf.clone() ;
						created.RVMRef_MC = wr_MC;
						matchedEntry.setValue2(created) ;
						matchedLeaf = created;
						GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
						enclosingSet.add(created) ;
						// D(X) defineTo:7 for <>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
							targetSet.add(created) ;
						}
						// D(X) defineTo:7 for <-MC>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
							targetSet.add(created) ;
						}
					}
				}
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor(GotoGoalUntilInRange_timestamp++, null, wr_MC) ;
				matchedEntry.setValue2(created) ;
				GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
				// D(X) defineNew:5 for <>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
					targetSet.add(created) ;
				}
				// D(X) defineNew:5 for <-MC>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
					targetSet.add(created) ;
				}
			}
			// D(X) main:6
			GotoGoalUntilInRangeMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(GotoGoalUntilInRange_timestamp++) ;
		}
		// D(X) main:8--9
		GotoGoalUntilInRangeMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_robotmoving(MC, res);

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MC_Map_cachekey_MC = MC;
			GotoGoalUntilInRange_MC_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
	}

	public static final void ballinfrontEvent(MotionControl MC, boolean ballinfrontRes) {
		GotoGoalUntilInRange_activated = true;
		while (!GotoGoalUntilInRange_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MC = null;
		Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> matchedEntry = null;
		boolean cachehit = false;
		if ((MC == GotoGoalUntilInRange_MC_Map_cachekey_MC) ) {
			matchedEntry = GotoGoalUntilInRange_MC_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MC = new CachedWeakReference(MC) ;
			{
				// FindOrCreateEntry
				Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
				if ((node_MC == null) ) {
					node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
					GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
					node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
				}
				matchedEntry = node_MC;
			}
		}
		// D(X) main:1
		GotoGoalUntilInRangeMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((wr_MC == null) ) {
				wr_MC = new CachedWeakReference(MC) ;
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor_Set sourceSet = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor_Set itmdSet = GotoGoalUntilInRange___To__MK_Map.getValue1() ;
					sourceSet = itmdSet;
				}
				if ((sourceSet != null) ) {
					int numalive = 0;
					int setlen = sourceSet.getSize() ;
					for (int ielem = 0; (ielem < setlen) ;++ielem) {
						GotoGoalUntilInRangeMonitor sourceMonitor = sourceSet.get(ielem) ;
						if ((!sourceMonitor.isTerminated() && (sourceMonitor.RVMRef_MK.get() != null) ) ) {
							sourceSet.set(numalive++, sourceMonitor) ;
							CachedWeakReference wr_MK = sourceMonitor.RVMRef_MK;
							MapOfMonitor<IGotoGoalUntilInRangeMonitor> destLastMap = null;
							IGotoGoalUntilInRangeMonitor destLeaf = null;
							{
								// FindOrCreate
								Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
								if ((node_MK == null) ) {
									node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
									GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
									node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
									node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
								}
								MapOfMonitor<IGotoGoalUntilInRangeMonitor> itmdMap = node_MK.getValue1() ;
								destLastMap = itmdMap;
								IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
								destLeaf = node_MK_MC;
							}
							if (((destLeaf == null) || destLeaf instanceof GotoGoalUntilInRangeDisableHolder) ) {
								boolean definable = true;
								// D(X) defineTo:1--5 for <MC>
								if (definable) {
									// FindCode
									Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
									if ((node_MC != null) ) {
										GotoGoalUntilInRangeMonitor itmdLeaf = node_MC.getValue2() ;
										if ((itmdLeaf != null) ) {
											if (((itmdLeaf.getDisable() > sourceMonitor.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								// D(X) defineTo:1--5 for <MK, MC>
								if (definable) {
									// FindCode
									Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
									if ((node_MK != null) ) {
										IGotoGoalUntilInRangeMonitor node_MK_MC = node_MK.getValue1() .getNodeEquivalent(wr_MC) ;
										if ((node_MK_MC != null) ) {
											if (((node_MK_MC.getDisable() > sourceMonitor.getTau() ) || ((node_MK_MC.getTau() > 0) && (node_MK_MC.getTau() < sourceMonitor.getTau() ) ) ) ) {
												definable = false;
											}
										}
									}
								}
								if (definable) {
									// D(X) defineTo:6
									GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceMonitor.clone() ;
									created.RVMRef_MC = wr_MC;
									destLastMap.putNode(wr_MC, created) ;
									// D(X) defineTo:7 for <>
									{
										// InsertMonitor
										GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MC>
									{
										// InsertMonitor
										Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
										if ((node_MC == null) ) {
											node_MC = new Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MC_Map.putNode(wr_MC, node_MC) ;
											node_MC.setValue1(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MC.getValue1() ;
										targetSet.add(created) ;
									}
									// D(X) defineTo:7 for <MK>
									{
										// InsertMonitor
										Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MK = GotoGoalUntilInRange_MK_MC_Map.getNodeEquivalent(wr_MK) ;
										if ((node_MK == null) ) {
											node_MK = new Tuple3<MapOfMonitor<IGotoGoalUntilInRangeMonitor>, GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor>() ;
											GotoGoalUntilInRange_MK_MC_Map.putNode(wr_MK, node_MK) ;
											node_MK.setValue1(new MapOfMonitor<IGotoGoalUntilInRangeMonitor>(1) ) ;
											node_MK.setValue2(new GotoGoalUntilInRangeMonitor_Set() ) ;
										}
										GotoGoalUntilInRangeMonitor_Set targetSet = node_MK.getValue2() ;
										targetSet.add(created) ;
									}
								}
							}
						}
					}
					sourceSet.eraseRange(numalive) ;
				}
			}
			{
				// D(X) createNewMonitorStates:4 when Dom(theta'') = <>
				GotoGoalUntilInRangeMonitor sourceLeaf = null;
				{
					// FindCode
					GotoGoalUntilInRangeMonitor itmdLeaf = GotoGoalUntilInRange__Map.getValue2() ;
					sourceLeaf = itmdLeaf;
				}
				if ((sourceLeaf != null) ) {
					boolean definable = true;
					// D(X) defineTo:1--5 for <MC>
					if (definable) {
						// FindCode
						Tuple2<GotoGoalUntilInRangeMonitor_Set, GotoGoalUntilInRangeMonitor> node_MC = GotoGoalUntilInRange_MC_Map.getNodeEquivalent(wr_MC) ;
						if ((node_MC != null) ) {
							GotoGoalUntilInRangeMonitor itmdLeaf = node_MC.getValue2() ;
							if ((itmdLeaf != null) ) {
								if (((itmdLeaf.getDisable() > sourceLeaf.getTau() ) || ((itmdLeaf.getTau() > 0) && (itmdLeaf.getTau() < sourceLeaf.getTau() ) ) ) ) {
									definable = false;
								}
							}
						}
					}
					if (definable) {
						// D(X) defineTo:6
						GotoGoalUntilInRangeMonitor created = (GotoGoalUntilInRangeMonitor)sourceLeaf.clone() ;
						created.RVMRef_MC = wr_MC;
						matchedEntry.setValue2(created) ;
						matchedLeaf = created;
						GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
						enclosingSet.add(created) ;
						// D(X) defineTo:7 for <>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
							targetSet.add(created) ;
						}
						// D(X) defineTo:7 for <-MC>
						{
							// InsertMonitor
							GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
							targetSet.add(created) ;
						}
					}
				}
			}
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				GotoGoalUntilInRangeMonitor created = new GotoGoalUntilInRangeMonitor(GotoGoalUntilInRange_timestamp++, null, wr_MC) ;
				matchedEntry.setValue2(created) ;
				GotoGoalUntilInRangeMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
				// D(X) defineNew:5 for <>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange__Map.getValue1() ;
					targetSet.add(created) ;
				}
				// D(X) defineNew:5 for <-MC>
				{
					// InsertMonitor
					GotoGoalUntilInRangeMonitor_Set targetSet = GotoGoalUntilInRange___To__MC_Map.getValue1() ;
					targetSet.add(created) ;
				}
			}
			// D(X) main:6
			GotoGoalUntilInRangeMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(GotoGoalUntilInRange_timestamp++) ;
		}
		// D(X) main:8--9
		GotoGoalUntilInRangeMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_ballinfront(MC, ballinfrontRes);

		if ((cachehit == false) ) {
			GotoGoalUntilInRange_MC_Map_cachekey_MC = MC;
			GotoGoalUntilInRange_MC_Map_cachevalue = matchedEntry;
		}

		GotoGoalUntilInRange_RVMLock.unlock();
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

public aspect GotoGoalUntilInRangeMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public GotoGoalUntilInRangeMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock GotoGoalUntilInRange_MOPLock = new ReentrantLock();
	static Condition GotoGoalUntilInRange_MOPLock_cond = GotoGoalUntilInRange_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut GotoGoalUntilInRange_gotogoal(boolean withBall, Kicker MK) : (call(public boolean GotoGoal(boolean)) && args(withBall) && target(MK)) && MOP_CommonPointCut();
	before (boolean withBall, Kicker MK) : GotoGoalUntilInRange_gotogoal(withBall, MK) {
		GotoGoalUntilInRangeRuntimeMonitor.gotogoalEvent(withBall, MK);
	}

	pointcut GotoGoalUntilInRange_generalGoto(Waypoint dest) : (call(public void goTo(Waypoint)) && args(dest)) && MOP_CommonPointCut();
	after (Waypoint dest) : GotoGoalUntilInRange_generalGoto(dest) {
		GotoGoalUntilInRangeRuntimeMonitor.generalGotoEvent(dest);
	}

	pointcut GotoGoalUntilInRange_ingoalrange(MotionControl MC) : (call(public boolean InGoalRange()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : GotoGoalUntilInRange_ingoalrange(MC) {
		GotoGoalUntilInRangeRuntimeMonitor.ingoalrangeEvent(MC, res);
	}

	pointcut GotoGoalUntilInRange_robotmoving(MotionControl MC) : (call(public boolean RobotMoving()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean res) : GotoGoalUntilInRange_robotmoving(MC) {
		GotoGoalUntilInRangeRuntimeMonitor.robotmovingEvent(MC, res);
	}

	pointcut GotoGoalUntilInRange_ballinfront(MotionControl MC) : (call(public boolean BallInFront()) && this(MC)) && MOP_CommonPointCut();
	after (MotionControl MC) returning (boolean ballinfrontRes) : GotoGoalUntilInRange_ballinfront(MC) {
		GotoGoalUntilInRangeRuntimeMonitor.ballinfrontEvent(MC, ballinfrontRes);
	}

}
