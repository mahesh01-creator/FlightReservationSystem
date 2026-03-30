 package mahesh.project.FlightReservation.repository;

import java.util.List;
import jakarta.persistence.*;
import jakarta.servlet.*;

import org.springframework.stereotype.Repository;

import com.mysql.cj.Query;

import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.User;

@Repository
public class UserRepository 
{
	private static EntityManagerFactory factory;
	private static EntityManager manager;
	private static EntityTransaction transaction;
	private static TypedQuery<User> query;
	
	public static void OpenConnection() 
	{
		factory=Persistence.createEntityManagerFactory("FlightReservation");
		manager=factory.createEntityManager();
		transaction=manager.getTransaction();	
	}
	
	public static void closeConnection() 
	{
		if (factory != null) {
            factory.close();
        }

        if (manager != null) {
            manager.close();
        }

        if (transaction.isActive()) {
            transaction.rollback();
        }
		
	}
	
	
	 public User saveUser(String name, String email, String password, long phone) 
	 {
	        OpenConnection();
	        transaction.begin();

	        User user = new User();

	        user.setName(name);
	        user.setEmail(email);
	        user.setPass(password);
	        user.setPhn(phone);

	        manager.persist(user);

	        transaction.commit();
	        closeConnection();

	        return user;
	}
 	public User loginUser(String email, String password)	 	
	{

		    OpenConnection();
		    transaction.begin();

		    String jpql = "FROM User u WHERE u.email = :email AND u.pass = :password";

		    query = manager.createQuery(jpql, User.class);

		    query.setParameter("email", email);
		    query.setParameter("password", password);

		    List<User> result = query.getResultList();

		    User user = result.isEmpty() ? null : result.get(0);

		    transaction.commit();
		    closeConnection();

		    return user;
	}
	 	
	public User findByEmail(String email) 
	{
	        OpenConnection();
	        transaction.begin();
	        User user = null;

	        try {
	            TypedQuery<User> q = manager.createQuery(
	                "FROM User WHERE email = :email", User.class);
	            q.setParameter("email", email);
	            user = q.getSingleResult();
	        } catch(Exception e) {}

	        
	        transaction.commit();
	        closeConnection();
	        return user;
	}

	public void update(User user) 
	{
	    	OpenConnection();
	        transaction.begin();
	        
	        manager.merge(user);
	        
	        transaction.commit();
	        closeConnection();
	       
	}
	public List<Booking> findRecentBookings(String email) 
	{

	        OpenConnection();
	        transaction.begin();

	        String jpql = "FROM Booking b WHERE b.userEmail = :email ORDER BY b.id DESC";

	        List<Booking> list = manager.createQuery(jpql, Booking.class)
	                .setParameter("email", email)
	                .setMaxResults(5)
	                .getResultList();

	        transaction.commit();
	        closeConnection();

	        return list;
	}
	

	public int countUpcomingTrips(String email) 
	{

	        OpenConnection();
	        transaction.begin();

	        String jpql = "SELECT COUNT(b) FROM Booking b WHERE b.userEmail = :email AND b.flight.flightDate >= CURRENT_DATE";

	        Long count = manager.createQuery(jpql, Long.class)
	                .setParameter("email", email)
	                .getSingleResult();

	        transaction.commit();
	        closeConnection();
	        return count.intValue();
	}
	
	public double sumTotalPriceByUser(String email) 
	{

	        OpenConnection();
	        transaction.begin();

	        String jpql = "SELECT SUM(b.totalPrice) FROM Booking b WHERE b.userEmail = :email";

	        Double total = manager.createQuery(jpql, Double.class)
	                .setParameter("email", email)
	                .getSingleResult();

	        transaction.commit();
	        closeConnection();

	        return total != null ? total : 0;
	}
	    

	public int countBookingsByUser(String email) 
	{

	        OpenConnection();
	        transaction.begin();

	        String jpql = "SELECT COUNT(b) FROM Booking b WHERE b.userEmail = :email";

	        Long count = manager.createQuery(jpql, Long.class)
	                .setParameter("email", email)
	                .getSingleResult();

	        transaction.commit();
	        closeConnection();

	        return count.intValue();
	}
	    

}
