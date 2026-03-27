<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Seats</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    background: radial-gradient(circle at top, #1e293b, #020617);
}

nav a {
    position: relative;
}

nav a::after {
    content: "";
    position: absolute;
    width: 0%;
    height: 2px;
    background: #3b82f6;
    left: 0;
    bottom: -4px;
    transition: 0.3s;
}

nav a:hover::after {
    width: 100%;
}

/* Seat */
.seat{
    width:45px;
    height:45px;
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius:12px;
    font-size:12px;
    cursor:pointer;
    transition: all 0.25s ease;
}

/* Hover */
.seat:hover{
    transform: scale(1.15);
    box-shadow:0 0 15px rgba(59,130,246,0.8);
}

/* Card Glass */
.glass{
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border: 1px solid rgba(255,255,255,0.1);
}
</style>

</head>

<body class="text-white">

<!-- ✅ NAVBAR (FIXED PROPER) -->
<nav class="flex justify-between items-center px-12 py-5 backdrop-blur-xl bg-white/5 border-b border-white/10">

    <h1 class="text-3xl font-bold">
        ✈ SkyBook
    </h1>

    <div class="flex gap-8 text-lg items-center">

        <a href="home" class="hover:text-blue-400 flex items-center gap-2">
            🏠 Home
        </a>

        <a href="myBookings" class="text-blue-400 font-semibold flex items-center gap-2">
            🎫 My Bookings
        </a>

        <a href="profile" class="hover:text-blue-400 flex items-center gap-2">
            👤 Profile
        </a>

        <a href="login" class="bg-red-500 px-4 py-2 rounded-lg hover:bg-red-600">
            Logout
        </a>

    </div>

</nav>

<div class="min-h-screen flex flex-col items-center px-4 py-6">

<!-- HEADER -->
<h1 class="text-3xl font-bold mb-6 tracking-wide">
     Select Your Seats
</h1>

<!-- FLIGHT CARD -->
<div class="glass w-full max-w-4xl p-6 rounded-3xl shadow-xl mb-6">

    <div class="flex flex-col md:flex-row justify-between items-center">

        <!-- Flight Info -->
        <div>
            <h2 class="text-xl font-semibold">${flight.flightName}</h2>
            <p class="text-gray-400 text-sm">Flight ID: ${flight.id}</p>
        </div>

        <!-- Price -->
        <div class="text-right">
            <p class="text-2xl font-bold text-green-400">₹ ${flight.price}</p>
            <p class="text-xs text-gray-400">Per Seat</p>
        </div>

    </div>

    <!-- Route -->
    <div class="flex items-center mt-6">

        <div class="text-center w-1/3">
            <p class="font-bold text-lg">${flight.source}</p>
            <p class="text-xs text-gray-400">${flight.departureTime}</p>
        </div>

        <div class="flex-1 flex items-center justify-center">
            <div class="w-full border-t border-dashed border-gray-500"></div>
            <i class="fa-solid fa-plane mx-2 text-blue-400"></i>
            <div class="w-full border-t border-dashed border-gray-500"></div>
        </div>

        <div class="text-center w-1/3">
            <p class="font-bold text-lg">${flight.destination}</p>
            <p class="text-xs text-gray-400">${flight.arrivalTime}</p>
        </div>

    </div>

</div>

<!-- MAIN GRID -->
<div class="flex flex-col lg:flex-row gap-6 w-full max-w-5xl">

<!-- SEAT AREA -->
<div class="glass flex-1 p-6 rounded-3xl shadow-xl overflow-x-auto">

<%
List booked = (List) request.getAttribute("bookedSeats");
%>

<div class="min-w-[500px] space-y-3">

<%
for(int row=1; row<=10; row++){
%>

<div class="flex justify-center items-center gap-3">

<%
for(char col='A'; col<='F'; col++){

String seat = row + "" + col;
boolean isBooked = booked != null && booked.contains(seat);
%>

<div class="<%= isBooked ? "bg-red-500" : "bg-green-500" %> seat"
onclick="<%= isBooked ? "" : "toggleSeat(this,'" + seat + "')" %>"
<%= isBooked ? "style='cursor:not-allowed'" : "" %>>

<%= seat %>

</div>

<%
if(col=='C'){ %>
<div class="w-6"></div>
<% } } %>

</div>

<% } %>

</div>

<!-- LEGEND -->
<div class="flex justify-center gap-6 mt-6 text-sm">

<div class="flex items-center gap-2">
<div class="w-4 h-4 bg-green-500 rounded"></div> Available
</div>

<div class="flex items-center gap-2">
<div class="w-4 h-4 bg-yellow-400 rounded"></div> Selected
</div>

<div class="flex items-center gap-2">
<div class="w-4 h-4 bg-red-500 rounded"></div> Booked
</div>

</div>

</div>



<!-- FORM -->
<form action="passengerDetails" method="post">
	<input type="hidden" name="flightId" value="${flight.id}">
	<input type="hidden" id="selectedSeats" name="selectedSeats">
	
	<!-- SUMMARY PANEL -->
	<div class="glass w-full lg:w-72 p-6 rounded-3xl shadow-xl h-fit">
	<h3 class="text-lg font-semibold mb-4">Booking Summary</h3>
	<p class="text-sm text-gray-400">Seats Selected</p>
	<p id="seatCount" class="text-xl font-bold text-yellow-400">0</p>

	<hr class="my-4 border-gray-600">

	<p class="text-sm text-gray-400">Total Price</p>
	<p class="text-2xl font-bold text-green-400">
	₹ <span id="totalPrice">0</span>
	</p>

	</div>
	
    <button type="submit" class="bg-blue-500 px-6 py-2 rounded-lg hover:bg-blue-600" onclick="return validateSeats()">
        Continue
    </button>
</form>

</div>

<script>
let seats = [];
let pricePerSeat = ${flight.price != null ? flight.price : 0};

function toggleSeat(el, seat){

if(el.classList.contains("bg-green-500")){
    el.classList.remove("bg-green-500");
    el.classList.add("bg-yellow-400");
    seats.push(seat);
}
else{
    el.classList.remove("bg-yellow-400");
    el.classList.add("bg-green-500");
    seats = seats.filter(s => s !== seat);
}

document.getElementById("selectedSeats").value = seats.join(",");
document.getElementById("seatCount").innerText = seats.length;
document.getElementById("totalPrice").innerText = seats.length * pricePerSeat;
}

function validateSeats(){
    if(seats.length === 0){
        alert("Please select at least one seat");
        return false;
    }
    return true;
}
</script>

</body>
</html>