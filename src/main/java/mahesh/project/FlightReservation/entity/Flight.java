package mahesh.project.FlightReservation.entity;

import jakarta.persistence.*;
import jakarta.servlet.*;

import java.time.LocalDate;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Flight 
{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String flightName;
    private String source;
    private String destination;
    private LocalDate flightDate;
    private String departureTime;
    private String arrivalTime;
    private double price;
    private int seats;
    
//    @OneToMany(mappedBy = "flight")
//    private List<Seat> seats;
    @OneToMany(mappedBy="flight")
    private List<Booking> bookings;
}
