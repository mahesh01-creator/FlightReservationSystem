package mahesh.project.FlightReservation.repository;

import java.time.LocalDate;

import java.util.List;

import jakarta.persistence.*;
import jakarta.servlet.*;

import org.springframework.stereotype.Repository;

import mahesh.project.FlightReservation.entity.Flight;

@Repository
public class FlightRepository {

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

    // ADD FLIGHT
    public Flight addFlight(Flight flight) {

        openConnection();
        transaction.begin();

        manager.persist(flight);

        transaction.commit();
        closeConnection();

        return flight;

    }

    // GET ALL FLIGHTS
    public List<Flight> getAllFlights() {

        openConnection();
        transaction.begin();

        String jpql = "FROM Flight";

        query = manager.createQuery(jpql, Flight.class);

        List<Flight> flights = query.getResultList();

        transaction.commit();
        closeConnection();

        return flights;

    }

    // SEARCH FLIGHT
    public List<Flight> searchFlight(String source, String destination, LocalDate date){

        openConnection();
        transaction.begin();

        String jpql = "FROM Flight f WHERE f.source = :source AND f.destination = :destination AND f.flightDate = :date";

        query = manager.createQuery(jpql, Flight.class);

        query.setParameter("source", source);
        query.setParameter("destination", destination);
        query.setParameter("date", date);

        List<Flight> flights = query.getResultList();

        transaction.commit();
        closeConnection();

        return flights;
    }

    // DELETE FLIGHT
    public void deleteFlight(int id) {

        openConnection();
        transaction.begin();

        Flight flight = manager.find(Flight.class, id);

        if (flight != null) {
            manager.remove(flight);
        }

        transaction.commit();
        closeConnection();

    }
    
    public Flight getFlightById(int id) {

        openConnection();
        transaction.begin();

        Flight flight = manager.find(Flight.class, id);

        transaction.commit();
        closeConnection();

        return flight;
    }
   
    public void updateFlight(Flight flight) {

        openConnection();
        transaction.begin();

        manager.merge(flight);

        transaction.commit();
        closeConnection();
    }

}