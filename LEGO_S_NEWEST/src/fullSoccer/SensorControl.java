package fullSoccer;
import java.io.FileNotFoundException;
import java.io.FileReader;

import lejos.hardware.Button;
import lejos.hardware.port.Port;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;
import lejos.robotics.localization.CompassPoseProvider;
import lejos.utility.Delay;
import lejos.hardware.DeviceException;

public class SensorControl {
	
	private SampleProvider irSeekModeMod;		// Gets value for modulated IR
	private SampleProvider irSeekModeUnMod;		// Gets value for unmodulated IR
	private SampleProvider distMode;			// Gets value for sonar
	private float[] distanceSample;				// The actual sonar value -- RAW
	private float[] irSample;					// The actual IR value -- RAW
	
	//private HiTechnicCompass compassSensor;		// The actual compass
	//private SampleProvider compassSP;			// compass sample provider
	private float ballDirMod;					// Last read IR Mod value
	private float ballDirUnMod;					// Last read IR Un-Mod value
	
	// Simulation parts
	private FileReader simFileReader;
	private boolean simMode; 
	
	EV3UltrasonicSensor sonarSensor = null;	// Actual Sonar sensor
	HiTechnicIRSeekerV2 irSensor = null;		// Actual IR Seeker
	
	
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
		
		
		simMode = simulatorMode;

		if(!simMode){
			try{
				if(sonarSensor == null && irSensor == null){
					System.out.println("SEN SETUP");
					sonarSensor = new EV3UltrasonicSensor(sonarPort);
					irSensor = new HiTechnicIRSeekerV2(irPort);
				}
				else{
					System.out.println("SensorPorts already in use!");
				}
			}
			catch(DeviceException portError){
				System.out.println("Sensor ports already setup!");
				System.out.println("Closing SensorControl Setup");
				//sonarSensor = new EV3UltrasonicSensor(sonarPort);
				//irSensor = new HiTechnicIRSeekerV2(irPort);
				return;
			}
			

			distMode = sonarSensor.getDistanceMode();
			distanceSample = new float[distMode.sampleSize()];
			irSeekModeMod = irSensor.getModulatedMode();
			irSeekModeUnMod = irSensor.getUnmodulatedMode();
			irSample = new float[irSeekModeMod.sampleSize()];
			//compassPort = LocalEV3.get().getPort("S4");
			//compassSensor = new HiTechnicCompass(compassPort);
			//compassSP = compassSensor.getCompassMode();
			
			//************Compass Calibration************************//
			/*System.out.println("Calib Compass? -- UP");
			if(Button.waitForAnyPress() == Button.ID_UP){
				System.out.println("Start Calib");
				//compassSensor.startCalibration();
				Button.waitForAnyPress();
				//compassSensor.stopCalibration();
				System.out.println("End Calib");
			}*/
		}
		else{
			/*try {
				simFileReader = new FileReader("simData/sensorData.txt");
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		}
	}
	
	// Just returns the last read modulated IR 
	public float getLastModIR(){
		return ballDirMod;
	}
	
	
	// Just returns the last read Unmodulated IR 
	public float getLastUnModIR(){
		return ballDirUnMod;
	}
	
	
	// Just returns the last read sonar 
	public float getLastSonar(){
		return distanceSample[0];
	}
	
	
	public float pingSonar(){
		float tmpDist[] = new float[2];
		distMode.fetchSample(tmpDist, 0);
		Delay.msDelay(50);
		return tmpDist[0];
	}
	
	public float pingIr(boolean modulated){
		float tmpIr[] = new float[2];
		if(modulated){
			irSeekModeMod.fetchSample(tmpIr, 0);
		}
		else{
			irSeekModeUnMod.fetchSample(tmpIr, 0);
		}
		Delay.msDelay(50);
		return tmpIr[0];
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
	public boolean fetchAngleVal(boolean modulated){
		if(!simMode){
			if(modulated){
				irSeekModeMod.fetchSample(irSample, 0);
				ballDirMod = irSample[0];
			}
			else{
				irSeekModeUnMod.fetchSample(irSample, 0);
				ballDirUnMod = irSample[0];
			}
			//System.out.println(irSample[0]);
			Delay.msDelay(50);
		}
		else{
			
		}
		if(!Float.isNaN(irSample[0])){
			return true;
		}
		else
			return false;
		
		//return irSample[0];
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
	public boolean getAllIrSig(){
		fetchAngleVal(true);
		fetchAngleVal(false);
		// Verify that an IR signal is read -- this should be at all times
		if(!Float.isNaN(ballDirMod) || !Float.isNaN(ballDirUnMod))
			return true;
		else
			return false;
		
	}
}