package in.koyad.piston.app.userMgmt.service.resources;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.koyad.piston.core.model.User;

import in.koyad.piston.app.userMgmt.sdk.api.UserManagementService;
import in.koyad.piston.common.bo.Attribute;
import in.koyad.piston.common.exceptions.FrameworkException;
import in.koyad.piston.common.utils.LogUtil;
import in.koyad.piston.common.utils.ServiceManager;
import in.koyad.piston.common.utils.StringUtil;

@Path("/users")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UserResource {
	
	private static final LogUtil LOGGER = LogUtil.getLogger(UserResource.class);

	private static final UserManagementService userMgmtService = ServiceManager.getService(UserManagementService.class);
	
	@GET
	public List<User> searchUsers(@QueryParam("query") String query) throws FrameworkException {
		LOGGER.enterMethod("searchUsers");
		
		String[] tokens = StringUtil.split(query.substring(0, query.length() - 1), "&");
		
		List<Attribute> atts = new ArrayList<>();
		for(String token : tokens) {
			String[] paramValue = StringUtil.split(token, "=");
			atts.add(new Attribute(paramValue[0], paramValue[1]));
		}
		List<User> users = userMgmtService.searchUsers(atts);
		
		LOGGER.exitMethod("searchUsers");
		return users;
	}
	
	@GET
	@Path("{id}")
	public User getUser(@PathParam("id") String id) throws FrameworkException {
		LOGGER.enterMethod("getUser");
		
		User user = userMgmtService.fetchUser(id);
		
		LOGGER.exitMethod("getUser");
		return user;
	}
	
	@POST
	@PUT
	public void saveUser(User user) throws FrameworkException {
		LOGGER.enterMethod("saveUser");
		
		userMgmtService.saveUser(user);
		
		LOGGER.exitMethod("saveUser");
	}
}
