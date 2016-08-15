pointcut getBallDirectionPC(Kicker MK) : call(public void Kicker.getBallDirection()) && target(MK);
	pointcut ballClosePC(Kicker MK) : call(public void Kicker.ballClose(boolean)) && target(MK);
	pointcut ballKickablePC(Kicker MK) : call(public void Kicker.ballKickable(boolean)) && target(MK);
	pointcut ballInFrontPC(Kicker MK) : call(public void Kicker.ballInFront(boolean)) && target(MK);
	pointcut gotoWaypointPC(Kicker MK) : call(public void Kicker.gotoWaypoint(Waypoint, boolean)) && target(MK);
	pointcut turnToBallPC(Kicker MK) : call(public void Kicker.turnToBall()) && target(MK);
	pointcut gotoBallPC(Kicker MK) : call(public void Kicker.gotoBall()) && target(MK);
	pointcut wonderPC(Kicker MK) : call(public void Kicker.wonder()) && target(MK);
	
	
	
	//***************SENSOR SETUPS************************
	// Sonar sensor setup
	//pointcut sonarSensorSetup(Kicker MK) : cflowbelow(playPC(MK)) && set(EV3UltrasonicSensor SensorControl.sonarSensor);
	//after(Kicker MK):sonarSensorSetup(MK){}
	
	
	
	// IR sensor setup
	//pointcut irSensorSetup(Kicker MK): cflowbelow(playPC(MK)) && set(HiTechnicIRSeekerV2 SensorControl.irSensor);
	//after(Kicker MK):irSensorSetup(MK){}
	
	
	// Compass sensor setup
	//pointcut compassSensorSetup(Kicker MK): cflowbelow(playPC(MK)) && set(HiTechnicCompass SensorControl.compassSensor);
	//after(Kicker MK):compassSensorSetup(MK){
		
	//}
	
	
	
	//***************SAMPLE SETUPS************************
	
	
	// IR Mod sampler
	pointcut irSeekModeModSetup(Kicker MK):cflowbelow(playPC(MK)) && set(SampleProvider SensorControl.irSeekModeMod);
	after(Kicker MK):irSeekModeModSetup(MK){
		System.out.println("***IR SampleProvider - MOD***");
		//PrintState(MK.GetState());
	}
	
	
	
	// IR Un-Mod sampler
	pointcut irSeekModeUnModSetup(Kicker MK):cflowbelow(playPC(MK)) && set(SampleProvider SensorControl.irSeekModeUnMod);
	after(Kicker MK):irSeekModeUnModSetup(MK){
		System.out.println("***IR SampleProvider - UN_MOD***");
		//PrintState(MK.GetState());
	}
	
	
	
	
	// Compass sampler
	//pointcut compassSPSetup(Kicker MK):cflowbelow(playPC(MK)) && set(SampleProvider SensorControl.compassSP);
	//after(Kicker MK):compassSPSetup(MK){}
	
	
	
	//***************MOTOR SETUPS*************************
	// Arm setup
	pointcut armSetup(Kicker MK):cflowbelow(playPC(MK)) && set(UnregulatedMotor MotionControl.arm);
	after(Kicker MK):armSetup(MK){
		System.out.println("***ARM Setup***");
		//PrintState(MK.GetState());
	}
	
	
	
	// Left motor setup
	pointcut leftMotorSetup(Kicker MK):cflowbelow(playPC(MK)) && set(RegulatedMotor MotionControl.leftMotor);
	after(Kicker MK):leftMotorSetup(MK){
		System.out.println("***LEFT MOTOR***");
		//PrintState(MK.GetState());
	}
	
	
	
	// Right motor setup
	pointcut rightMotorSetup(Kicker MK):cflowbelow(playPC(MK)) && set(RegulatedMotor MotionControl.rightMotor);
	after(Kicker MK):rightMotorSetup(MK){
		System.out.println("***RIGHT MOTOR***");
		//PrintState(MK.GetState());
	}
	
	
	
	// roboMotor setup
	pointcut roboMotorSetup(Kicker MK):cflowbelow(playPC(MK)) && set(Navigator MotionControl.roboMotor);
	after(Kicker MK):roboMotorSetup(MK){
		System.out.println("***ROBO MOTOR***");
		//PrintState(MK.GetState());
	}
	
	
	
	
	// roboMotor Motion Check -- Internal boolean for Navigator (LeJOS API)
	//pointcut roboMotorMoving(Kicker MK):cflowbelow(playPC(MK)) && set(Navigator Navigator._keepGoing);
	//after(Kicker MK):roboMotorMoving(MK){}
	
	
	
	
	
	
	// After Init
	/*pointcut RobotInit():call(public MotionControl(RegulatedMotor, RegulatedMotor,SensorControl,boolean)) ||
		call(public SensorControl(Port,Port,Port,boolean));
	
	pointcut Wonder():call(public boolean Wonder());
	
	pointcut GotoBallPC():call(public boolean GotoBall());
	
	pointcut GotoGoal():call(public boolean GotoWaypoint(Waypoint, boolean));
	
	// Goes with goto goal technically
	pointcut Dribble():call(public boolean DribbleBall());
	
	pointcut KickAtGoal():call(public boolean KickBall(int,int, int,int, int, int));*/