package mahesh.project.FlightReservation.service;

import java.time.LocalDate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mahesh.project.FlightReservation.entity.Flight;

import mahesh.project.FlightReservation.repository.FlightRepository;


@Service
public class FlightService {

    @Autowired
    private FlightRepository repo;
    

   
    public Flight addFlight(Flight flight) {

        Flight savedFlight = repo.addFlight(flight);

//        // Generate seats automatically
//        for(int row = 1; row <= 10; row++) {
//
//            for(char col = 'A'; col <= 'F'; col++) {
//
//                Seat seat = new Seat();
//
//                seat.setSeatNumber(row + "" + col);
//                seat.setSeatClass("Economy");
//                seat.setStatus("AVAILABLE");
//                seat.setFlight(savedFlight);
//
//                seatRepository.saveSeat(seat);
//            }
//        }

        return savedFlight;
    }

    // Get All Flights
    public List<Flight> getAllFlights(){

        return repo.getAllFlights();

    }

    // Search Flight
    public List<Flight> searchFlight(String source,String destination,LocalDate date){
        return repo.searchFlight(source,destination,date);
    }

    // Delete Flight
    public void deleteFlight(int id){

        repo.deleteFlight(id);

    }
    
    public Flight getFlightById(int id) {
        return repo.getFlightById(id);
    }

}