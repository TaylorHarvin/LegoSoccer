package base;

public class TestParent {
	public float otherVal;
	private ChildTest myTestObj;
	
	TestParent(){
		myTestObj = new ChildTest();
	}
	
	
	public void ParentChangeVal(){
		otherVal = 30;
		System.out.println("New Val: "+otherVal);
		ChildChange();
	}
	
	public ChildTest GetTestObj(){
		return myTestObj;
	}
	
	public void ChildChange(){
		myTestObj.ChangeTest();
	}
}
