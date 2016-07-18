package base;

public class ChildTest {
	public float val;
	
	
	ChildTest(){

	}
	
	public void FuncTest(){
		System.out.println("This is a test message: "+val);
	}
	
	void ChangeTest(){
		val = 10;
		System.out.println(val);
	}
}
