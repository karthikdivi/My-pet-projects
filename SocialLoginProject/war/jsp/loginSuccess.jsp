<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
    <%@ page import="loginradiussdk.LoginRadius" %>
    <%@ page import="loginradiussdk.LoginRadius.*" %>
    <%@ page import="loginradiusdataobject.userprofile.BasicUserLoginRadiusUserProfile" %>
    <%@ page import="com.google.gson.*" %>
    <%@ page import="java.util.List" %>
	<%@ page import="com.google.appengine.api.users.User" %>
	<%@ page import="com.google.appengine.api.users.UserService" %>
	<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
	<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
	<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
	<%@ page import="com.google.appengine.api.datastore.Query" %>
	<%@ page import="com.google.appengine.api.datastore.Entity" %>
	<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
	<%@ page import="com.google.appengine.api.datastore.Key" %>
	<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
	<%@ page import="java.util.Calendar" %>
	<%@ page import="java.text.SimpleDateFormat" %>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Successful</title>
<link href="../css/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>

	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<div class="hero-unit">

<%

try{
	// LoginRadius API Calls to retrive the user info
	// fcb17582-03d1-448d-ad9e-0b129bd59eb3 is LoginRadius secret key
    LoginRadius _loginradius = new LoginRadius(request,"fcb17582-03d1-448d-ad9e-0b129bd59eb3"); 
      if(_loginradius.IsAuthenticated) {  	      
    	 // userprofile objects holds the data of logged in user
          BasicUserLoginRadiusUserProfile userprofile=_loginradius.getBasicUserprofile();
          out.println("<br> <h1>");
          out.println("Welcome ");
       
          if(userprofile.fullName!=null){
          out.println(userprofile.fullName);}
          else{
          out.println("user");	  
          }
          out.println("</h1> <br> ");
          
          // Displaying extra information which i got from the userprofile object
          // This varies from service to service
          out.println("Here is the other information i can retrive ");
          out.println("<br>");
          
          if(userprofile.firstName!=null)
              out.println("User First Name: "+userprofile.firstName+"<br>");
          
          if(userprofile.middleName!=null)
              out.println("User Middle Name: "+userprofile.middleName+"<br>");
          
          if(userprofile.lastName!=null)
              out.println("User Last Name: "+userprofile.lastName+"<br>");
          
          if(userprofile.id!=null)
          out.println("User profile ID: "+userprofile.id+"<br>");
          
          if(userprofile.country!=null){
          if(userprofile.country.name!=null)
              out.println("User Country: "+userprofile.country.name+"<br>");
          
          if(userprofile.country.code!=null)
              out.println("User Country: "+userprofile.country.code+"<br>");
          }
          
          if(userprofile.gender!=null)
              out.println("User Gender: "+userprofile.gender+"<br>"); 
          
              if(userprofile.profileName!=null)
                  out.println("User Profile Name: "+userprofile.profileName+"<br>");
             

           // Storing the login info to Data Store 
           String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
            Key userKey = KeyFactory.createKey("user", "staticKey");
          	Entity usertEntity = new Entity("UsersTable",userKey);	
          	// forming string with username appended with date and time and storing it to google datastore
          	usertEntity.setProperty("userId", userprofile.fullName +" @ "+timeStamp);
          	DatastoreService dataStore = DatastoreServiceFactory.getDatastoreService();
          	dataStore.put(usertEntity);      
      
      }
      
    }catch (Exception e){    	
    	//out.println("Something went wrong : "+ e.getStackTrace());    	
    }
%>

<% 
// This code is to disply user login history
try{
Key userKey = KeyFactory.createKey("user", "staticKey");
DatastoreService dataStore = DatastoreServiceFactory.getDatastoreService();
Query query = new Query("UsersTable", userKey);
	   // I am fetching only 10 records to display in webpage	   
	   List<Entity> allUsers = dataStore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
	   out.println("<br>"+allUsers.size()+" Successful Logins till now ");
	   out.println("<br>");
	    for(Entity i : allUsers){
	    	out.println(i.getProperty("userId"));
	    	out.println("</br>");
	    	
	    }
	    out.println("<br>");
	    out.println(". . . . ");	    
	    
} catch(Exception e) {
	//out.println("Something went wrong : "+ e.getStackTrace());
}
%>
<!-- REST API CALL To retrieve complete user login history -->
For Complete list check <a href="/resources/GetAllUsers/getUsers">Here</a>
	</div>
</body>
</html>