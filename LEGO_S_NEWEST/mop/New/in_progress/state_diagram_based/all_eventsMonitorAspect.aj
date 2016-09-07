import java.io.*;
import java.util.*;
import fullSoccer.*;
import stateTools.*;
import loggingTools.*;
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


final class AllEventsRawMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<AllEventsRawMonitor> {

	AllEventsRawMonitor_Set(){
		this.size = 0;
		this.elements = new AllEventsRawMonitor[4];
	}
	final void event_turnto_ball_state_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_turnto_ball_state_enter(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_turnto_ball_state_true(Kicker MK, boolean wonderCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_turnto_ball_state_true(MK, wonderCheckRes);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_gotoballstate_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_gotoballstate_enter(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_goto_ball_state_true(Kicker MK, boolean gtbCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_goto_ball_state_true(MK, gtbCheckRes);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_goto_goal_state_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_goto_goal_state_enter(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_turnto_goal_state_true(Kicker MK, boolean ttgCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_turnto_goal_state_true(MK, ttgCheckRes);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_dribble_to_goal_state_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_dribble_to_goal_state_enter(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_dribble_to_goal_state_true(Kicker MK, boolean dribbleCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_dribble_to_goal_state_true(MK, dribbleCheckRes);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_kick_at_goal_state_enter(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_kick_at_goal_state_enter(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_kick_ball_state_true(Kicker MK, boolean dribbleCheckRes) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_kick_ball_state_true(MK, dribbleCheckRes);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_ballinfront_true(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_ballinfront_true(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_ball_close_true(Kicker MK) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			AllEventsRawMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				monitor.event_ball_close_true(MK);
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class AllEventsRawMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			AllEventsRawMonitor ret = (AllEventsRawMonitor) super.clone();
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

	final boolean event_turnto_ball_state_enter(Kicker MK) {
		RVM_lastevent = 0;
		{
			System.out.println("Wonder Event ENTER");
			Logger.log(LogFile.ALL_EVENTS, "turnto_ball_state_enter");
		}
		return true;
	}

	final boolean event_turnto_ball_state_true(Kicker MK, boolean wonderCheckRes) {
		RVM_lastevent = 1;
		{
			if ( ! (wonderCheckRes) ) {
				return false;
			}
			{
				System.out.println("Wonder Event TEST TRUE");
				Logger.log(LogFile.ALL_EVENTS, "turnto_ball_state_true");
			}
		}
		return true;
	}

	final boolean event_gotoballstate_enter(Kicker MK) {
		RVM_lastevent = 2;
		{
			System.out.println("GTB Event ENTER");
			Logger.log(LogFile.ALL_EVENTS, "gotoballstate_enter");
		}
		return true;
	}

	final boolean event_goto_ball_state_true(Kicker MK, boolean gtbCheckRes) {
		RVM_lastevent = 3;
		{
			if ( ! (gtbCheckRes) ) {
				return false;
			}
			{
				System.out.println("GTB Event TEST TRUE");
				Logger.log(LogFile.ALL_EVENTS, "goto_ball_state_true");
			}
		}
		return true;
	}

	final boolean event_goto_goal_state_enter(Kicker MK) {
		RVM_lastevent = 4;
		{
			System.out.println("Wonder Event ENTER");
			Logger.log(LogFile.ALL_EVENTS, "goto_goal_state_enter");
		}
		return true;
	}

	final boolean event_turnto_goal_state_true(Kicker MK, boolean ttgCheckRes) {
		RVM_lastevent = 5;
		{
			if ( ! (ttgCheckRes) ) {
				return false;
			}
			{
				System.out.println("TTG Event TEST TRUE");
				Logger.log(LogFile.ALL_EVENTS, "turnto_goal_state_true");
			}
		}
		return true;
	}

	final boolean event_dribble_to_goal_state_enter(Kicker MK) {
		RVM_lastevent = 6;
		{
			System.out.println("Dribble Event Event ENTER");
			Logger.log(LogFile.ALL_EVENTS, "Dribble_state_enter");
		}
		return true;
	}

	final boolean event_dribble_to_goal_state_true(Kicker MK, boolean dribbleCheckRes) {
		RVM_lastevent = 7;
		{
			if ( ! (dribbleCheckRes) ) {
				return false;
			}
			{
				System.out.println("Dribble Event TEST TRUE");
				Logger.log(LogFile.ALL_EVENTS, "dribble_to_goal_state_true");
			}
		}
		return true;
	}

	final boolean event_kick_at_goal_state_enter(Kicker MK) {
		RVM_lastevent = 8;
		{
			System.out.println("Kick ball Event Event ENTER");
			Logger.log(LogFile.ALL_EVENTS, "Kick_ball_state_enter");
		}
		return true;
	}

	final boolean event_kick_ball_state_true(Kicker MK, boolean dribbleCheckRes) {
		RVM_lastevent = 9;
		{
			if ( ! (dribbleCheckRes) ) {
				return false;
			}
			{
				System.out.println("Kick Event TEST TRUE");
				Logger.log(LogFile.ALL_EVENTS, "kick_ball_state_true");
			}
		}
		return true;
	}

	final boolean event_ballinfront_true(Kicker MK) {
		RVM_lastevent = 10;
		{
			currMK = MK;
			System.out.println("Ball in front TRUE");
			Logger.log(LogFile.ALL_EVENTS, "ballinfront_true");
		}
		return true;
	}

	final boolean event_ball_close_true(Kicker MK) {
		RVM_lastevent = 11;
		{
			System.out.println("Ball Close TRUE");
			Logger.log(LogFile.ALL_EVENTS, "ballclose_true");
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
			//turnto_ball_state_enter
			return;
			case 1:
			//turnto_ball_state_true
			return;
			case 2:
			//gotoballstate_enter
			return;
			case 3:
			//goto_ball_state_true
			return;
			case 4:
			//goto_goal_state_enter
			return;
			case 5:
			//turnto_goal_state_true
			return;
			case 6:
			//dribble_to_goal_state_enter
			return;
			case 7:
			//dribble_to_goal_state_true
			return;
			case 8:
			//kick_at_goal_state_enter
			return;
			case 9:
			//kick_ball_state_true
			return;
			case 10:
			//ballinfront_true
			return;
			case 11:
			//ball_close_true
			return;
		}
		return;
	}

}

class all_eventsRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager all_eventsMapManager;
	static {
		all_eventsMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		all_eventsMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock all_events_RVMLock = new ReentrantLock();
	static final Condition all_events_RVMLock_cond = all_events_RVMLock.newCondition();

	private static boolean AllEvents_activated = false;

	// Declarations for Indexing Trees
	private static Object AllEvents_MK_Map_cachekey_MK;
	private static AllEventsRawMonitor AllEvents_MK_Map_cachevalue;
	private static final MapOfMonitor<AllEventsRawMonitor> AllEvents_MK_Map = new MapOfMonitor<AllEventsRawMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += AllEvents_MK_Map.cleanUpUnnecessaryMappings();
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

	public static final void turnto_ball_state_enterEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_turnto_ball_state_enter(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void turnto_ball_state_trueEvent(Kicker MK, boolean wonderCheckRes) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_turnto_ball_state_true(MK, wonderCheckRes);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void gotoballstate_enterEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_gotoballstate_enter(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void goto_ball_state_trueEvent(Kicker MK, boolean gtbCheckRes) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_goto_ball_state_true(MK, gtbCheckRes);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void goto_goal_state_enterEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_goto_goal_state_enter(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void turnto_goal_state_trueEvent(Kicker MK, boolean ttgCheckRes) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_turnto_goal_state_true(MK, ttgCheckRes);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void dribble_to_goal_state_enterEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_dribble_to_goal_state_enter(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void dribble_to_goal_state_trueEvent(Kicker MK, boolean dribbleCheckRes) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_dribble_to_goal_state_true(MK, dribbleCheckRes);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void kick_at_goal_state_enterEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_kick_at_goal_state_enter(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void kick_ball_state_trueEvent(Kicker MK, boolean dribbleCheckRes) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_kick_ball_state_true(MK, dribbleCheckRes);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void ballinfront_trueEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_ballinfront_true(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
	}

	public static final void ball_close_trueEvent(Kicker MK) {
		AllEvents_activated = true;
		while (!all_events_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_MK = null;
		MapOfMonitor<AllEventsRawMonitor> matchedLastMap = null;
		AllEventsRawMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((MK == AllEvents_MK_Map_cachekey_MK) ) {
			matchedEntry = AllEvents_MK_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_MK = new CachedWeakReference(MK) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<AllEventsRawMonitor> itmdMap = AllEvents_MK_Map;
				matchedLastMap = itmdMap;
				AllEventsRawMonitor node_MK = AllEvents_MK_Map.getNodeEquivalent(wr_MK) ;
				matchedEntry = node_MK;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_MK == null) ) {
				wr_MK = new CachedWeakReference(MK) ;
			}
			// D(X) main:4
			AllEventsRawMonitor created = new AllEventsRawMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_MK, created) ;
		}
		// D(X) main:8--9
		matchedEntry.event_ball_close_true(MK);

		if ((cachehit == false) ) {
			AllEvents_MK_Map_cachekey_MK = MK;
			AllEvents_MK_Map_cachevalue = matchedEntry;
		}

		all_events_RVMLock.unlock();
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

public aspect all_eventsMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public all_eventsMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock all_events_MOPLock = new ReentrantLock();
	static Condition all_events_MOPLock_cond = all_events_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution() && BaseAspect.notwithin();
	pointcut AllEvents_ball_close_true(Kicker MK) : (call(public boolean Kicker.ballClose(boolean)) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : AllEvents_ball_close_true(MK) {
		all_eventsRuntimeMonitor.ball_close_trueEvent(MK);
	}

	pointcut AllEvents_kick_at_goal_state_enter(Kicker MK) : (call(public void Kicker.kickBall(int, int, int, int, int, int)) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : AllEvents_kick_at_goal_state_enter(MK) {
		all_eventsRuntimeMonitor.kick_at_goal_state_enterEvent(MK);
	}

	pointcut AllEvents_dribble_to_goal_state_enter(Kicker MK) : (call(public void Kicker.dribbleBall()) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : AllEvents_dribble_to_goal_state_enter(MK) {
		all_eventsRuntimeMonitor.dribble_to_goal_state_enterEvent(MK);
	}

	pointcut AllEvents_goto_goal_state_enter(Kicker MK) : (call(public boolean Kicker.gotoGoal(boolean)) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : AllEvents_goto_goal_state_enter(MK) {
		all_eventsRuntimeMonitor.goto_goal_state_enterEvent(MK);
	}

	pointcut AllEvents_gotoballstate_enter(Kicker MK) : (call(public boolean Kicker.gotoBall()) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : AllEvents_gotoballstate_enter(MK) {
		all_eventsRuntimeMonitor.gotoballstate_enterEvent(MK);
	}

	pointcut AllEvents_turnto_ball_state_enter(Kicker MK) : (call(public boolean Kicker.turnToBall()) && this(MK)) && MOP_CommonPointCut();
	before (Kicker MK) : AllEvents_turnto_ball_state_enter(MK) {
		all_eventsRuntimeMonitor.turnto_ball_state_enterEvent(MK);
	}

	pointcut AllEvents_turnto_ball_state_true(Kicker MK) : (call(public boolean StateCheck.WonderState(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean wonderCheckRes) : AllEvents_turnto_ball_state_true(MK) {
		all_eventsRuntimeMonitor.turnto_ball_state_trueEvent(MK, wonderCheckRes);
	}

	pointcut AllEvents_goto_ball_state_true(Kicker MK) : (call(public boolean StateCheck.GotoBallState(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean gtbCheckRes) : AllEvents_goto_ball_state_true(MK) {
		all_eventsRuntimeMonitor.goto_ball_state_trueEvent(MK, gtbCheckRes);
	}

	pointcut AllEvents_turnto_goal_state_true(Kicker MK) : (call(public boolean StateCheck.TurnToGoalState(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean ttgCheckRes) : AllEvents_turnto_goal_state_true(MK) {
		all_eventsRuntimeMonitor.turnto_goal_state_trueEvent(MK, ttgCheckRes);
	}

	pointcut AllEvents_dribble_to_goal_state_true(Kicker MK) : (call(public boolean StateCheck.DribbleBallState(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean dribbleCheckRes) : AllEvents_dribble_to_goal_state_true(MK) {
		all_eventsRuntimeMonitor.dribble_to_goal_state_trueEvent(MK, dribbleCheckRes);
	}

	pointcut AllEvents_kick_ball_state_true(Kicker MK) : (call(public boolean StateCheck.KickBallAtGoal(Kicker)) && !execution(State StateCheck.GetState(ChangeEvent, Kicker)) && args(MK)) && MOP_CommonPointCut();
	after (Kicker MK) returning (boolean dribbleCheckRes) : AllEvents_kick_ball_state_true(MK) {
		all_eventsRuntimeMonitor.kick_ball_state_trueEvent(MK, dribbleCheckRes);
	}

	pointcut AllEvents_ballinfront_true(Kicker MK) : (call(public void Kicker.generateBallInFrontState()) && target(MK)) && MOP_CommonPointCut();
	after (Kicker MK) : AllEvents_ballinfront_true(MK) {
		all_eventsRuntimeMonitor.ballinfront_trueEvent(MK);
	}

}
