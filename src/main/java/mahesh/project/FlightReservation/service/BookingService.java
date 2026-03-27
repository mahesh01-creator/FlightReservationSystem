package mahesh.project.FlightReservation.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.Flight;

import mahesh.project.FlightReservation.repository.BookingRepository;
import mahesh.project.FlightReservation.repository.FlightRepository;


@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;
    @Autowired
    private FlightRepository flightRepository;

//    
    public synchronized String bookFlight(int flightId, String seatNumber, Booking booking) {

        Flight flight = flightRepository.getFlightById(flightId);

        boolean isBooked = bookingRepository.isSeatBooked(flightId, seatNumber);

        if (isBooked) {
            return "Seat already booked";
        }

        booking.setFlight(flight);
        booking.setSeatNumber(seatNumber);
        booking.setSeatClass("Economy");
        booking.setTotalPrice(flight.getPrice());
        booking.setBookingDate(LocalDate.now());

        bookingRepository.saveBooking(booking);

        return "success";
    }
	
	public List<String> getBookedSeats(int flightId) 
	{
	    return bookingRepository.getBookedSeats(flightId);
	}

	public List<Booking> getBookingsByUser(String email){
	    return bookingRepository.findByUserEmailOrderByIdDesc(email);
	}

	public List<Booking> getBookingsByPnr(String pnr) 
	{
		 return bookingRepository.findByPnr(pnr);
	}

	public void cancelBookingByPnr(String pnr) 
	{
		bookingRepository.deleteByPnr(pnr);
		
	}
	
	
}