package fullSoccer;
import java.io.FileNotFoundException;
import java.io.FileReader;

import lejos.hardware.Button;
import lejos.hardware.ev3.LocalEV3;
import lejos.hardware.motor.EV3MediumRegulatedMotor;
import lejos.hardware.port.Port;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;
import lejos.robotics.localization.CompassPoseProvider;
import lejos.utility.Delay;


public class SensorControl {
	
	private SampleProvider irSeekModeMod;		// Gets value for modulated IR
	private SampleProvider irSeekModeUnMod;		// Gets value for unmodulated IR
	private SampleProvider distMode;			// Gets value for sonar
	private float[] distanceSample;				// The actual sonar value -- RAW
	private float[] irSample;					// The actual IR value -- RAW
	
	private HiTechnicCompass compassSensor;		// The actual compass
	private SampleProvider compassSP;			// compass sample provider
	private float ballDirMod;					// Last read IR Mod value
	private float ballDirUnMod;					// Last read IR Un-Mod value
	
	// Simulation parts
	private FileReader simFileReader;
	private boolean simMode; 
	
	
	/* Base Sensor Control constructor
	 *	Preconditions: 
	 *		1. Valid sonar port given
	 *			1.1. sonar connected
	 *		2. Valid ir port given
	 *			2.1. ir connected
	 *		3. Valid compass port given
	 *			3.1. compass connected
	 *		4. correct mode given
	 *	Postconditions:
	 *		1. IR sampler setup
	 *		2. Sonar sampler setup
	 *		3. compass sampler setup
	 */
	public SensorControl(Port sonarPort, Port irPort, Port compassPort, boolean simulatorMode){
		EV3UltrasonicSensor sonarSensor;	// Actual Sonar sensor
		HiTechnicIRSeekerV2 irSensor;		// Actual IR Seeker
		
		simMode = simulatorMode;
		
		if(!simMode){
			sonarSensor = new EV3UltrasonicSensor(sonarPort);
			irSensor = new HiTechnicIRSeekerV2(irPort);
			distMode = sonarSensor.getDistanceMode();
			distanceSample = new float[distMode.sampleSize()];
			irSeekModeMod = irSensor.getModulatedMode();
			irSeekModeUnMod = irSensor.getUnmodulatedMode();
			irSample = new float[irSeekModeMod.sampleSize()];
			//compassPort = LocalEV3.get().getPort("S4");
			compassSensor = new HiTechnicCompass(compassPort);
			compassSP = compassSensor.getCompassMode();
			
			//************Compass Calibration************************//
			System.out.println("Calib Compass? -- UP");
			if(Button.waitForAnyPress() == Button.ID_UP){
				System.out.println("Start Calib");
				compassSensor.startCalibration();
				Button.waitForAnyPress();
				compassSensor.stopCalibration();
				System.out.println("End Calib");
			}
		}
		else{
			try {
				simFileReader = new FileReader("simData/sensorData.txt");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	
	
	// Just returns the last read modulated IR 
	public float GetLastModIR(){
		return ballDirMod;
	}
	
	
	// Just returns the last read Unmodulated IR 
	public float GetLastUnModIR(){
		return ballDirUnMod;
	}
	
	
	
	
	
	
	/*	Get the ball distance value relative to the robot
	 *	Preconditions: 
	 *		1. sonar is initialized to the correct port
	 *		2. sonar is working
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Some object is seen by sonar
	 *		2. Returns false
	 *			2.1. No object is seen
	 *			2.1.1. OR sonar read failed
	 *			2.1.1. AND/OR robot's batteries are low
	 */
	public boolean fetchSonarVal(){
		if(!simMode){
			distMode.fetchSample(distanceSample, 0);
			//System.out.println(distanceSample[0]);
			Delay.msDelay(50);
		}
		else{
			// Grab value from file or DB here if in sim
		}
		
		// Check for valid sonar value
		if(!Float.isNaN(distanceSample[0])){
			if(distanceSample[0] <= 0)
				distanceSample[0] = 9999;
			return true;
		}
		else
			return false;
	}
	
	
	
	/*	Get the ball angle relative to the robot
	 *	Preconditions: 
	 *		1. IR Seeker is initialized to the correct port
	 *		2. IR Seeker is functioning properly
	 *	Postconditions:
	 *		1. Returns IR read : float
	 *			1.1. Valid Mod-IR read
	 *			1.1.1. OR valid Un-Mod IR read
	 *			1.2. Ball heading in relation to robot returned for requested mode
	 */
	public float FetchAngleVal(boolean modulated){
		if(!simMode){
			if(modulated)
				irSeekModeMod.fetchSample(irSample, 0);
			else
				irSeekModeUnMod.fetchSample(irSample, 0);
			//System.out.println(irSample[0]);
			Delay.msDelay(50);
		}
		else{
			
		}
		return irSample[0];
	}
	
	
	
	/*	Tells the IR reads of the robot in relation to the ball signal
	 *	Preconditions: 
	 *		1. IR Seeker is initialized to the correct port
	 *		2. IR Seeker is functioning properly
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Valid Mod-IR read
	 *			1.1.1. and/or valid Un-Mod IR read
	 *			1.2. Ball heading in relation to robot stored
	 *				 in the class variables:
	 *					- ballDirMod
	 *					- ballDirUnMod
	 *		2. Returns false
	 *			2.1. The ball is at an unreadable angle to the robot
	 *			2.1.1. OR The ball is off or batteries are dead.
	 *			2.1.1. OR The robot's batteries are low.
	 */
	public boolean GetAllIrSig(){
		ballDirMod = FetchAngleVal(true);
		ballDirUnMod = FetchAngleVal(false);
		// Verify that an IR signal is read -- this should be at all times
		if(!Float.isNaN(ballDirMod) || !Float.isNaN(ballDirUnMod))
			return true;
		else
			return false;
		
	}
	
	
	
	
	/*	Averages the IR reads of the robot in relation to the ball signal
	 *	Preconditions: 
	 *		1. IR Seeker is initialized to the correct port
	 *		2. IR Seeker is functioning properly
	 *	Postconditions:
	 *		1. Returns averaged ball IR signal -- from mod and Un-Mod
	 *		1.1. Returns -1 (invalid) if both IR signals are invalid
	 */
	public float GetBallDirection(){
		float avgDir = 0;	// Average reading from both IR signals
		int used = 0;		// Number of valid IR signal readings (max of 2)
		
		// Average both the Mod and Un-Mod
		if(GetAllIrSig()){
			// Add modulated IR to average
			if(!Float.isNaN(ballDirMod)){
				avgDir += ballDirMod;
				used++;
			}
			
			// Add un-modulated IR to average 
			if(!Float.isNaN(ballDirUnMod)){
				avgDir += ballDirUnMod;
				used++;
			}
			
			// If at least one IR is valid, return the average
			if(used > 0){
				avgDir = (avgDir/used)*-1;
				System.out.println(avgDir);
				return avgDir;
			}
			else{
				System.out.println("Invalid IR");
				return -1;
			}
		}
		else
			return -1;
		
	}
	
	
	
	
	
	
	/*	Tells if the ball is fully in the robot's arms
	 *	Preconditions: 
	 *		1. sonar is working
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Ball is fully in the robot's arms
	 *				 and is as close to the robot's sonar as possible
	 *			1.1.1. OR another object is somehow in the robot's arm-span
	 *					-- IR could help check
	 *		2. Returns false
	 *			2.1. The ball is not within a the robot's arm-span (not in between the arms)
	 *				 and is as close to the robot's sonar as possible
	 *			2.1.1. OR sonar failed
	 */
	public boolean BallClose(){
		// Check if sonar worked and grabbed sonar value
		if(fetchSonarVal()){
			// Check if the distance of an object is within the kick-able threshold
			if(distanceSample[0] < SoccerGlobals.BALL_SONAR_DIST_GRAB)
				return true;
		}
		return false;
	}
	
	
	
	/*	Tells if the ball is close enough for a full kick
	 *	Preconditions: 
	 *		1. sonar is working
	 *		2. in general, the robot is assumed to be moving forward
	 *		   to generate more power to the kick
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Ball is close enough for a full kick
	 *			1.1.1. OR another object is somehow in the robot's arm-span
	 *					-- IR could help check
	 *		2. Returns false
	 *			2.1. The ball is not within a the robot's arm-span (not in between the arms)
	 *			2.1.1. OR sonar failed
	 */
	public boolean BallKickable(){
		// Check if sonar worked and grabbed sonar value
		if(fetchSonarVal()){
			// Check if the distance of an object is within the kick-able threshold
			if(distanceSample[0] < SoccerGlobals.SONAR_OBJECT_KICKABLE)
				return true;
		}
		return false;
	}
	
	
	
	/*	Tells if the ball is in front of the robot
	 *	Preconditions: 
	 *		1. sonar and ir sensors are initialized and matched with correct ports
	 *		2. sonar and ir sensors are working
	 *	Postconditions:
	 *		1. Returns true (ball or object is aligned with the front of the robot)
	 *			1.1. Sonar says object is in the arms of the robot (not guaranteed to be the ball)
	 *			1.1.1. OR modulated IR or Unmodulated IR reads as 0
	 *		2. Returns false
	 *			2.1. Ball is out of range of the sonar
	 *			2.2. ball is either at an angle greater than 30 degrees from the front of the robot
	 *				 or the ball is not emitting a signal
	 *
	 */
	public boolean BallInFront(){
		
		//************** Sonar Check **************************//
		if(fetchSonarVal()){
			if(distanceSample[0] < SoccerGlobals.BALL_SONAR_DIST_GRAB){
				System.out.println("Ball In Grab Dist: "+ distanceSample[0]);
				return true;
			}
			System.out.println("Ball in Front Dist: "+ distanceSample[0]);
		}
		
		
		//************** IR Check******************************//
		if(GetAllIrSig()){
			//************** IR Check -- Modulated*****************//
			if(!Float.isNaN((ballDirMod))){
				if(ballDirMod == 0){
					return true;
				}
			}
			
			//************** IR Check -- UnModulated***************//
			if(!Float.isNaN(ballDirUnMod)){
				if(ballDirUnMod == 0){
					return true;
				}
			}
		}
		return false;
	}
}
