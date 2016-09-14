public class Adder{
	public static int firstNum;
	public static int secondNum;
	public static int total;
	
	public static int AddNum(){
		return (firstNum + secondNum);
	}
	
	public static void SetNum(int a, int b){
		firstNum = a;
		secondNum = b;
	}
	
	public static void main(String[] args) {
		long startTime = 0;
		long endTime = 0;
		startTime = System.currentTimeMillis();
		SetNum(10,20);
		total = AddNum();
		System.out.println(total);
		endTime = System.currentTimeMillis();
		System.out.println((endTime - startTime) + " ms");
	}
}