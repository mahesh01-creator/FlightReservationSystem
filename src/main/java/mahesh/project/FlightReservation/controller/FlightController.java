package mahesh.project.FlightReservation.controller;

import java.util.List;


import java.time.LocalDate;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.format.annotation.DateTimeFormat;

import mahesh.project.FlightReservation.entity.Flight;

import mahesh.project.FlightReservation.service.FlightService;

@Controller
public class FlightController {

    @Autowired
    private FlightService service;

    @GetMapping("/addFlight")
    public String openAddFlightPage() {
        return "add-flight";
    }

    
    @PostMapping("/addFlight")
    public String addFlight(
            @RequestParam("flightName") String flightName,
            @RequestParam("source") String source,
            @RequestParam("destination") String destination,
            @RequestParam("flightDate")   @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate flightDate,
            @RequestParam("departureTime") String departureTime,
            @RequestParam("arrivalTime") String arrivalTime,
            @RequestParam("price") double price,
            @RequestParam("seats") int seats) {

        Flight flight = new Flight();

        flight.setFlightName(flightName);
        flight.setSource(source);
        flight.setDestination(destination);
        flight.setFlightDate(flightDate);
        flight.setDepartureTime(departureTime);
        flight.setArrivalTime(arrivalTime);
        flight.setPrice(price);
        flight.setSeats(seats);

        service.addFlight(flight);

        return "redirect:/home";
    }
    
   
    @PostMapping("/searchFlight")
    public String searchFlight(
            @RequestParam("source") String source,
            @RequestParam("destination") String destination,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) 
            LocalDate flightDate,
            Model model) {

        List<Flight> flights = service.searchFlight(source, destination, flightDate);
        model.addAttribute("flights", flights);
        return "flight-results";
    }
    
    
}
