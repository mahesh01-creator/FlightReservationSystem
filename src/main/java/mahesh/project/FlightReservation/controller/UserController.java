package mahesh.project.FlightReservation.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.Flight;
import mahesh.project.FlightReservation.entity.User;
import mahesh.project.FlightReservation.repository.UserRepository;
import mahesh.project.FlightReservation.service.FlightService;
import mahesh.project.FlightReservation.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService service;
    
    @Autowired
    private FlightService flightService;

    @GetMapping("/signup")
    public String signupPage() {
        return "signup";
    }

    @PostMapping("/signup")
    public String signUp(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") long phone) {

        service.registerUser(name, email, password, phone);
        return "login";
    }

    
    @GetMapping("/login")
    public String loginPage() 
    {
        return "login";
    }
    
    @PostMapping("/login")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        ModelMap model,
                        HttpServletRequest request
                        ) {

        User user = service.loginUser(email, password);

        if (user != null) 
        {
        	
        	HttpSession session = request.getSession();
	        session.setAttribute("login", email);
	        session.setMaxInactiveInterval(1000000);
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());

            List<Flight> flights = flightService.getAllFlights();
            model.addAttribute("flights", flights);

            return "home";

        } else {
            model.addAttribute("error", "Invalid Email or Password"); // optional
            return "login";
        }
    } 
    
    @PostMapping("/home")
    public String home(HttpSession session, ModelMap model,@SessionAttribute(name = "login", required = false) String mail) 
    {
    	if (mail!=null) 
		{
    		List<Flight> flights = flightService.getAllFlights();
            model.addAttribute("flights", flights);
            return "home";
		}
    	model.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";
    }
    
    @GetMapping("/home")
    public String blockDirectAccessHome(HttpSession session, ModelMap model,@SessionAttribute(name = "login", required = false) String mail) 
    {
    	if (mail!=null) 
		{
    		List<Flight> flights = flightService.getAllFlights();
            model.addAttribute("flights", flights);
    		return "home";
		}
        return "redirect:/login";
    }
    
    @GetMapping("/profile")
    public String profile(HttpSession session, ModelMap model,@SessionAttribute(name = "login", required = false) String mail) {

    	
    	if (mail!=null) 
		{
    		String email = (String) session.getAttribute("userEmail");

    		User user = service.getUserByEmail(email);

    		int totalTrips = service.getTotalTrips(email);
    		double totalSpent = service.getTotalSpent(email);
    		int upcomingTrips = service.getUpcomingTrips(email);

    		List<Booking> recent = service.getRecentBookings(email);

    		
    		String status = "Silver";
    		if(totalSpent > 50000) status = "Gold";
    		if(totalSpent > 100000) status = "Platinum";

    		model.addAttribute("user", user);
    		model.addAttribute("totalTrips", totalTrips);
    		model.addAttribute("totalSpent", totalSpent);
    		model.addAttribute("upcomingTrips", upcomingTrips);
    		model.addAttribute("status", status);
    		model.addAttribute("recentBookings", recent);

    		return "profile";
		}
    	model.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";
    }
    @PostMapping("/updateProfile")
    public String updateProfile(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") long phone,
            HttpSession session,
            ModelMap map,
            @SessionAttribute(name = "login", required = false) String mail
    ) {

    	if (mail!=null) 
		{
    		 User user = service.getUserByEmail(email);

    	        user.setName(name);
    	        user.setPhn(phone);
    	        service.updateUser(user);
    	        session.setAttribute("userName", name);

    	        return "redirect:/profile";
		}
    	map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";
       
    }
    
    @PostMapping("/changePassword")
    public String changePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            HttpSession session,
            ModelMap map,
            @SessionAttribute(name = "login", required = false) String mail
    ) {

    	if (mail!=null) 
		{ 
    		String email = (String) session.getAttribute("userEmail");

            User user = service.getUserByEmail(email);

            if(user.getPass().equals(oldPassword))
            {
                user.setPass(newPassword);
                service.updateUser(user);

                session.setAttribute("msg", "Password updated successfully");
            } 
            else 
            {
                session.setAttribute("error", "Old password is incorrect");
            }

            return "redirect:/profile";
		}
    	
    	map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";
    }
    
    @GetMapping("/logout")
	public String logout(HttpSession session) 
	{
		session.invalidate();
		return "login";
	}
}
