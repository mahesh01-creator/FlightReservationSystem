
package mahesh.project.FlightReservation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.User;
import mahesh.project.FlightReservation.repository.UserRepository;

@Service
public class UserService 
{
	@Autowired
	private UserRepository repo;
	
	public User registerUser(String name, String email,String pass,long phn) 
	{
		return repo.saveUser(name, email, pass, phn);
		
	}
	
	public User loginUser(String email,String pass) 
	{
		return repo.loginUser(email, pass);
		
	}

//	public List<Booking> getBookingsByUser(String email) {
//		// TODO Auto-generated method stub
//		return null;
//	}
	public User getUserByEmail(String email){
        return repo.findByEmail(email);
    }

    public void updateUser(User user){
        repo.update(user);
    }
	
    public int getTotalTrips(String email) {
        return repo.countBookingsByUser(email);
    }

    public double getTotalSpent(String email) {
        return repo.sumTotalPriceByUser(email);
    }

    public int getUpcomingTrips(String email) {
        return repo.countUpcomingTrips(email);
    }

    public List<Booking> getRecentBookings(String email) {
        return repo.findRecentBookings(email);
    }
	

}

