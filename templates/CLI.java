/*
  Usage:
    javac CLI.java   // compile creates the file CLI.class
    java CLI         // executes the #main method of the CLI.class
*/

public class CLI {

  public static void main(String[] args) {
    System.out.print("Hello, World was called ");

    if(args.length > 0) {
      System.out.println("with the following arguments ...");

      for(int i = 0; i < args.length; i++) {
        System.out.println(args[i]);
      }
    } else {
      System.out.println("without any command line arguments.");
    }

  } // end public static void main(String[] args) {

} // end public class CLI {
