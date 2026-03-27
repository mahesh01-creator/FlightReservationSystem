package mahesh.project.FlightReservation.repository;

import java.util.List;



import jakarta.persistence.*;
import jakarta.servlet.*;

import org.springframework.stereotype.Repository;

import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.Flight;

@Repository
public class BookingRepository {

	private static EntityManagerFactory factory;
    private static EntityManager manager;
    private static EntityTransaction transaction;
    private static TypedQuery<Flight> query;

    public static void openConnection() {

        factory = Persistence.createEntityManagerFactory("FlightReservation");
        manager = factory.createEntityManager();
        transaction = manager.getTransaction();

    }

    public static void closeConnection() {

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
    public void saveBooking(Booking booking) 
    {
    	
    	openConnection();
    	transaction.begin();
    	
        manager.persist(booking);
        transaction.commit();
        closeConnection();
    }
    
    public boolean isSeatBooked(int flightId, String seatNumber) {

        openConnection();
        transaction.begin();

        String jpql = "FROM Booking b WHERE b.flight.id = :fid AND b.seatNumber = :seat";

        TypedQuery<Booking> query = manager.createQuery(jpql, Booking.class);
        query.setParameter("fid", flightId);
        query.setParameter("seat", seatNumber);

        boolean booked = !query.getResultList().isEmpty();

        transaction.commit();
        closeConnection();

        return booked;
    }
    public List<String> getBookedSeats(int flightId) {

        openConnection();
        transaction.begin();

        String jpql = "SELECT b.seatNumber FROM Booking b WHERE b.flight.id = :fid";

        TypedQuery<String> query = manager.createQuery(jpql, String.class);
        query.setParameter("fid", flightId);

        List<String> bookedSeats = query.getResultList();

        transaction.commit();
        closeConnection();

        return bookedSeats;
    }

    public List<Booking> findByUserEmailOrderByIdDesc(String email) {

        openConnection();
        transaction.begin();

        String jpql = "FROM Booking b WHERE b.userEmail = :email ORDER BY b.id DESC";

        TypedQuery<Booking> query = manager.createQuery(jpql, Booking.class);
        query.setParameter("email", email);

        List<Booking> bookings = query.getResultList();

        transaction.commit();
        closeConnection();

        return bookings;
    }
    
    public List<Booking> findByPnr(String pnr) {

        openConnection();
        transaction.begin();

        String jpql = "FROM Booking b WHERE b.pnr = :pnr";

        TypedQuery<Booking> query = manager.createQuery(jpql, Booking.class);
        query.setParameter("pnr", pnr);

        List<Booking> list = query.getResultList();

        transaction.commit();
        closeConnection();

        return list;
    }
    
    public void deleteByPnr(String pnr) {

        openConnection();
        transaction.begin();

        String jpql = "DELETE FROM Booking b WHERE b.pnr = :pnr";

        manager.createQuery(jpql)
               .setParameter("pnr", pnr)
               .executeUpdate();

        transaction.commit();
        closeConnection();
    }
    
    
    
}
