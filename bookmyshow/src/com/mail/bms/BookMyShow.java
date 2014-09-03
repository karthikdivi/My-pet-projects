package com.mail.bms;
import java.net.*;
import java.util.Date;
import java.io.*;
import java.sql.Timestamp;

public class BookMyShow {

	public static void main(String[] args)  throws Exception {
		
		
		while(true){			
	
			
			
			
			System.out.println("knock knock "+ new Timestamp (new java.util.Date().getTime()));  
		
	        String movieName="Nenokkadine";	
	        

    		
    		
	        URL bms = new URL("http://www.cinemax.co.in/Home.aspx");
	        URLConnection yc = bms.openConnection();
	        BufferedReader in = new BufferedReader(new InputStreamReader(
	                                yc.getInputStream()));
	        String inputLine;
	        while ((inputLine = in.readLine()) != null || true){
	        	
	        	System.out.println(inputLine);
	        	
	        	if(inputLine.contains(movieName) ){ 
	        		
	        	//	SendMail.sendMail("karthik4153@gmail.com",movieName+" is listed now","book tickets at www.cinemax.co.in");
	        	//	SendMail.sendMail("Rakesh.Kumar@jda.com",movieName+" is listed now","book tickets at www.cinemax.co.in");
	        		
	        		System.exit(0); 
	        	}
	        	
	        	
	        }
	            
	        in.close(); 
	        
	        Thread.sleep(1800000); 
		
		}
		
		}
	
	
}
