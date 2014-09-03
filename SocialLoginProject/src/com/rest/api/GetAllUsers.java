package com.rest.api;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.core.MediaType;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.data.bean.UserInfo;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
 

@Path("/GetAllUsers") 
public class GetAllUsers {
 
// This rest API provides user login history in a text format	
    @GET    
    @Path("getUsersTEXT")
    @Produces(MediaType.TEXT_PLAIN) 
    public String getClichedMessage() {
    	String users ="";
    	try{
    		Key userKey = KeyFactory.createKey("user", "staticKey");
    		DatastoreService dataStore = DatastoreServiceFactory.getDatastoreService();
    		Query query = new Query("UsersTable", userKey);
    			   // Retrieving complete entities from google data store	   
    			   List<Entity> allUsers = dataStore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    			 
    			    for(Entity i : allUsers){
    			    	users = users + i.getProperty("userId").toString() + "\n";   	 			    	
    			    	
    			    }
 
    			    
    		} catch(Exception e) {
    			//out.println("Something went wrong : "+ e.getStackTrace());
    		} 
    	
    	return users; 
    }
    
    
    @GET
    @Path("getUsers")
    @Produces(MediaType.TEXT_PLAIN)

    public String getAllUsers(){ 
    	
    	List users = new ArrayList<>();
    	UserInfo uf = null;
    	try{
    		Key userKey = KeyFactory.createKey("user", "staticKey");
    		DatastoreService dataStore = DatastoreServiceFactory.getDatastoreService();
    		Query query = new Query("UsersTable", userKey);
    			   // Retrieving complete entities from google data store	   
    			   List<Entity> allUsers = dataStore.prepare(query).asList(FetchOptions.Builder.withDefaults());
    			 
    			    for(Entity i : allUsers){
    			    	
    			    	users.add(i.getProperty("userId").toString());    			    	
    			    	
    			    }
    			    
    			    uf = new UserInfo(users);
 
    			    
    		} catch(Exception e) {
    			//out.println("Something went wrong : "+ e.getStackTrace());
    		}
    	
    	return users.toString(); 
    }
}
