import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Scanner;
 
/*
Make sure you are connected to vpn 
Compile and Execute with the following 2 commands:
    javac -cp ojdbc7.jar; Main_program.java Main_tester.java
    java -cp ojdbc7.jar; Main_program

    ******On linux replace ; with : ******
 */
public class Main_program {
 
    public static void main(String[] args) {
 
        Connection conn1 = null;

        try {
            // registers Oracle JDBC driver - though this is no longer required
            // since JDBC 4.0, but added here for backward compatibility
            Class.forName("oracle.jdbc.OracleDriver");
 
           
         //   String dbURL1 = "jdbc:oracle:thin:username/password@oracle.scs.ryerson.ca:1521:orcl";  // that is school Oracle database and you can only use it in the labs
																						
         	
             String dbURL1 = "jdbc:oracle:thin:vhhuynh/11192518@oracle.scs.ryerson.ca:1521:orcl";
			/* This XE or local database that you installed on your laptop. 1521 is the default port for database, change according to what you used during installation. 
			xe is the sid, change according to what you setup during installation. */
			
			conn1 = DriverManager.getConnection(dbURL1);
            if (conn1 != null) {
                System.out.println("Connected with connection #1");
            }
            // Display menu options
            main_menu(conn1);
 
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (conn1 != null && !conn1.isClosed()) {
                    conn1.close();
                }
     
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
			

    }


public static void main_menu(Connection conn1) {
    boolean isrunning = true;
    String welcome = (
        "===========================================\n" +
        "E-Commerce DB System\n" +
        "Main Menu\n" +
        "*Please select an operation*\n" +
        "============================================\n"
    );
    String options = (
        "0) Display the menu \n" +
        "1) Create Tables \n" + 
        "2) Populate Tables \n" +
        "3) Query Tables \n" +
        "4) Drop Tables \n" +
        "5) Exit"
    );
    // Display the menu 
    String display_main_menu = welcome + options;
    System.out.println(display_main_menu);

    // takes in menu input from user
    Scanner user_input = new Scanner(System.in);

    while (isrunning) {

        String input = user_input.nextLine();
        String[] values = input.split(" ");

        switch (values[0]) {
            case "1":
                try {
                    System.out.println("Now creating the tables...\n");
                    Main_tester.createTables(conn1);
                } catch (SQLException e) {
                    System.out.println("Error in creating tables: " + e);
                }
                break;
            case "2":
                try {
                    System.out.println("Now populating the tables...\n");
                    Main_tester.populateTables(conn1);
                } catch (SQLException e) {
                    System.out.println("Error in populating tables: " + e);
                }
                break;
            case "3":
                try {
                    System.out.println("Now querying the tables...\n");
                    Main_tester.queryTables(conn1);
                } catch (SQLException e) {
                    System.out.println("Error in querying tables: " + e);
                }
                break;
            case "4":
                try {
                    System.out.println("Now dropping the tables...\n");
                    Main_tester.dropTables(conn1);
                } catch (SQLException e) {
                    System.out.println("Error in dropping tables: " + e);
                }
                break;
            case "5":
                user_input.close();
                isrunning = false;
                break;
            case "0":
                System.out.println(display_main_menu);
                break;
            default:
                continue;
        }

    }
}
}