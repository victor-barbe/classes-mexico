import java.io.*;

//creating a class to display the data character by character and takes a brake between each char
//the use of syncronized means there will be only one thread executing at each time, so the strings gets displayed completely
class SharedDataPrinter {

  synchronized public void display(String str) {

    for(int i=0; i <str.length(); i++) {
      System.out.print(str.charAt(i));

      try {
        Thread.sleep(5000);
      } catch(Exception e) {}

    }
  }
}
//daughter class that extends thread, creates a threaads that displays geek
class Thread1 extends Thread {
  SharedDataPrinter p;

  public Thread1(SharedDataPrinter p) {
    this.p = p;
  }

  public void run() {
    p.display("Geeks");
  }
}

//other daughter class that extends thread and displays an other string
class Thread2 extends Thread{

  SharedDataPrinter p;

  public Thread2(SharedDataPrinter p) {
    this.p = p;
  }

  public void run() {
    p.display(" for Geeks");
    System.out.println();
    System.out.println("Termina");

  }
}

//class monitor that created a SharedDataPrinter object and 2 threads of each daughter class (thread1 and thread2)
//the class then launches both threads, but we can see the code still gets printed corretly (char by char but for each string) thanks to the use of synchronized at the top of the code
public class Monitor {

  public static void main(String[] args){
    SharedDataPrinter printer = new SharedDataPrinter();

    Thread1 t1 = new Thread1(printer);
    Thread2 t2 = new Thread2(printer);

    t1.start();
    t2.start();
  }
}
