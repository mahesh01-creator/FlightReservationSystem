package mahesh.project.FlightReservation.entity;

import java.time.LocalDate;

import jakarta.persistence.*;
import jakarta.servlet.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Booking 
{
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
	private String seatNumber;
    private String seatClass;
    private String passengerName;
    private int passengerAge;
    private String gender;
    private int seats;
    private LocalDate bookingDate;
    private double totalPrice;
    
    @Column
    private String pnr;

    @Column
    private String userEmail; 
    
    @ManyToOne
    @JoinColumn(name="flight_id")
    private Flight flight;

}
