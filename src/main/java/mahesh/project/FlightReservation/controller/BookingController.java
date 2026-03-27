package mahesh.project.FlightReservation.controller;

import java.io.IOException;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mahesh.project.FlightReservation.entity.Booking;
import mahesh.project.FlightReservation.entity.Flight;
import mahesh.project.FlightReservation.repository.BookingRepository;
import mahesh.project.FlightReservation.service.BookingService;
import mahesh.project.FlightReservation.service.FlightService;
import mahesh.project.FlightReservation.util.EmailUtil;
import mahesh.project.FlightReservation.util.TicketPDFGenerator;

@Controller
public class BookingController 
{

    @Autowired
    private BookingService service;
    @Autowired
    private FlightService flightService;
   
    

    @PostMapping("/confirmBooking")
    public String confirmBooking(
            @RequestParam("flightId") int flightId,
            @RequestParam("seatNumbers") String[] seatNumbers,
            @RequestParam("passengerName") String[] names,
            @RequestParam("age") int[] ages,
            @RequestParam("gender") String[] genders,
            ModelMap model,HttpSession session) {

    	String mail = (String) session.getAttribute("login");
    	
    	if (mail!=null) 
    	{
    		// DO NOT SAVE YET ❌

            model.addAttribute("flightId", flightId);
            model.addAttribute("seatNumbers", seatNumbers);
            model.addAttribute("names", names);
            model.addAttribute("ages", ages);
            model.addAttribute("genders", genders);

            return "payment";   // 👉 go to payment page
		}
    	model.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";
    }
    @GetMapping("/confirmBooking")
    public String blockDirectAccess() 
    {
        return "redirect:/login";
    }
    
    @PostMapping("/bookFlight")
    public String openPassengerPage(@RequestParam("gender") String[] genders,
            ModelMap model,HttpSession session) 
    {
    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
    		return "passenger-Details";
    	}
    	model.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";
    }
    
    @GetMapping("/selectSeat")
    public String selectSeat(@RequestParam("flightId") int flightId, Model model,HttpSession session) {

    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
    		Flight flight = flightService.getFlightById(flightId);  // 🔥 ADD THIS

            List<String> bookedSeats = service.getBookedSeats(flightId);

            model.addAttribute("flight", flight);      // 🔥 IMPORTANT
            model.addAttribute("flightId", flightId);
            model.addAttribute("bookedSeats", bookedSeats);

            return "seat-selection";
    	}
    	model.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login";   
    }
    
 
    @GetMapping("/passengerDetails")
    public String blockDirectAccess(HttpSession session,ModelMap map) 
    {
    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
    		return "redirect:/login";
    	}
        map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login"; 
    }
    
    @PostMapping("/passengerDetails")
    public String passengerDetails(
            @RequestParam("flightId") int flightId,
            @RequestParam("selectedSeats") String selectedSeats,
            Model model) {

        String[] seats = selectedSeats.split(",");

        model.addAttribute("flightId", flightId);
        model.addAttribute("seats", seats);

        return "passenger-Details";
    }
    
    @PostMapping("/paymentSuccess")
    public String paymentSuccess(
            @RequestParam("flightId") int flightId,
            @RequestParam("seatNumbers") String[] seatNumbers,
            @RequestParam("names") String[] names,
            @RequestParam("ages") int[] ages,
            @RequestParam("genders") String[] genders,
            HttpSession session
    ) {

        String email = (String) session.getAttribute("userEmail");  // ✅ GET FROM SESSION

        List<Booking> bookings = new ArrayList<>();
        String pnr = "SB" + System.currentTimeMillis();

        for(int i=0; i<seatNumbers.length; i++){
            Booking b = new Booking();
            b.setPassengerName(names[i]);
            b.setPassengerAge(ages[i]);
            b.setGender(genders[i]);
            b.setSeatNumber(seatNumbers[i]);

            b.setPnr(pnr);
            b.setUserEmail(email);

            service.bookFlight(flightId, seatNumbers[i], b);
            bookings.add(b);
        }

        Flight flight = flightService.getFlightById(flightId);
        double total = seatNumbers.length * flight.getPrice();

        // 🎟️ GENERATE PDF
        byte[] pdf = TicketPDFGenerator.generate(flight, bookings, total);

        // 🪑 Seat String
        String seatStr = String.join(", ", seatNumbers);

        // 🎨 HTML EMAIL
        String html = EmailUtil.generateEmailTemplate(
                pnr,
                names,
                seatStr,
                total,
                flight.getSource(),
                flight.getDestination(),
                flight.getFlightDate().toString()
        );

        // 📩 SEND EMAIL WITH PDF
        EmailUtil.sendTicketEmail(
                email,
                "✈️ SkyBook Ticket - " + pnr,
                html,
                pdf
        );
        
        
        session.setAttribute("flight", flight);
        session.setAttribute("bookings", bookings);
        session.setAttribute("total", total);
        session.setAttribute("pnr", pnr);

          
        return "redirect:/ticketPage";
    }
    
    @GetMapping("/ticketPage")
    public String ticketPage(
            @RequestParam(value = "pnr", required = false) String pnr,
            HttpSession session,ModelMap map
            
    ) {
    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
    		// ✅ Case 1: Coming from MyBookings (PNR present)
            if (pnr != null) {
                List<Booking> bookings = service.getBookingsByPnr(pnr);

                Flight flight = bookings.get(0).getFlight();
                double total = bookings.size() * flight.getPrice();

                session.setAttribute("flight", flight);
                session.setAttribute("bookings", bookings);
                session.setAttribute("total", total);
                session.setAttribute("pnr", pnr);
            }

            // ✅ Case 2: Coming from Payment (session already set)
            return "ticket";
    	}
    	map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
		return "login"; 
    }
    
    @GetMapping("/downloadTicket")
    public void downloadTicket(
            @RequestParam(value = "pnr", required = false) String pnr,
            HttpServletResponse response,
            HttpSession session,ModelMap map
    ) throws IOException {
    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
    		 List<Booking> bookings;
    	        Flight flight;
    	        double total;

    	        // ✅ CASE 1: From MyBookings
    	        if (pnr != null) {
    	            bookings = service.getBookingsByPnr(pnr);
    	            flight = bookings.get(0).getFlight();
    	            total = bookings.size() * flight.getPrice();
    	        }

    	        // ✅ CASE 2: From Ticket Page (session)
    	        else {
    	            bookings = (List<Booking>) session.getAttribute("bookings");
    	            flight = (Flight) session.getAttribute("flight");
    	            total = (Double) session.getAttribute("total");
    	        }

    	        byte[] pdf = TicketPDFGenerator.generate(flight, bookings, total);

    	        response.setContentType("application/pdf");
    	        response.setHeader("Content-Disposition", "attachment; filename=SkyBook-Ticket.pdf");

    	        response.getOutputStream().write(pdf);
    	}
    	map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
    }
    
    @PostMapping("/downloadTicket")
    public String downloadTicket(HttpSession session,ModelMap map) 
    {
    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
            return "redirect:/myBookings";
    	}
    	map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
    	return "login";
	}
    
    @PostMapping("/cancelBooking")
    public String cancelBooking(@RequestParam("pnr") String pnr,HttpSession session,ModelMap map) 
    {
    	String mail = (String) session.getAttribute("login");
    	if (mail!=null) 
    	{
    		service.cancelBookingByPnr(pnr);
            return "redirect:/myBookings";
    	}
    	map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
    	return "login";
        
    }
    
    @GetMapping("/myBookings")
    public String myBookings(ModelMap map, HttpSession session) {

        String email = (String) session.getAttribute("userEmail");

        if (email!=null) 
    	{
        	List<Booking> bookings = service.getBookingsByUser(email);
            map.addAttribute("bookings", bookings);
            return "my-bookings";
    	}
        map.addAttribute("msg", "Please LoggedIn Yourself First!!!!!!!!");
    	return "login";
        
    }

}