<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String msg = (String) request.getAttribute("msg"); %>

<!DOCTYPE html>
<html>
<head>

<title>SkyBook - Flight Results</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

body{
background-image:url("https://images.unsplash.com/photo-1436491865332-7a61a109cc05");
background-size:cover;
background-position:center;
background-attachment:fixed;
font-family:'Segoe UI', sans-serif;
}

.overlay{
background:linear-gradient(to bottom, rgba(0,0,0,0.7), rgba(0,0,0,0.85));
}

.flight-line{
height:2px;
background:linear-gradient(to right,#60a5fa,#3b82f6,#1d4ed8);
flex:1;
margin:0 10px;
}

</style>

</head>

<body class="min-h-screen">

<div class="overlay min-h-screen">

<!-- Navbar -->

<nav class="flex justify-between items-center px-12 py-5 text-white backdrop-blur-md">

<h1 class="text-3xl font-bold tracking-wide">
<i class="fa-solid fa-plane-departure text-blue-400"></i> SkyBook
</h1>

<div class="space-x-6 text-lg">

<a href="home" class="hover:text-blue-400 transition">
<i class="fa-solid fa-house"></i> Home
</a>

<a href="#" class="hover:text-blue-400 transition">
<i class="fa-solid fa-ticket"></i> My Bookings
</a>

<a href="login" class="bg-red-500 px-4 py-2 rounded-lg hover:bg-red-600 transition shadow">
<i class="fa-solid fa-right-from-bracket"></i> Logout
</a>

</div>

</nav>


<!-- Results -->

<div class="mt-16 px-24">

<h2 class="text-white text-3xl mb-8 font-semibold">
<i class="fa-solid fa-plane"></i> Your Flights
</h2>

<div class="space-y-8">

<c:forEach var="f" items="${flights}">

<div class="bg-white rounded-2xl shadow-xl p-7 flex justify-between items-center hover:shadow-2xl hover:scale-[1.02] transition duration-300">

<!-- Flight Info -->

<div class="flex flex-col gap-2 w-1/5">

<h3 class="text-xl font-bold text-gray-800">
<i class="fa-solid fa-plane text-blue-500"></i>
${f.flightName}
</h3>

<p class="text-gray-500 text-sm">
<i class="fa-solid fa-location-dot text-red-500"></i>
${f.source}

<i class="fa-solid fa-arrow-right text-gray-400 mx-1"></i>

<i class="fa-solid fa-location-dot text-red-500"></i>
${f.destination}
</p>

<p class="text-sm text-gray-400">
<i class="fa-solid fa-calendar-days"></i>
Date : ${f.flightDate}
</p>

</div>


<!-- Route Visualization -->

<div class="flex items-center w-2/5">

<div class="text-center">

<p class="text-lg font-semibold text-gray-800">
${f.departureTime}
</p>

<p class="text-xs text-gray-400">
<i class="fa-solid fa-plane-departure"></i> Departure
</p>

</div>

<div class="flight-line"></div>

<div class="text-blue-500 text-xl">
<i class="fa-solid fa-plane"></i>
</div>

<div class="flight-line"></div>

<div class="text-center">

<p class="text-lg font-semibold text-gray-800">
${f.arrivalTime}
</p>

<p class="text-xs text-gray-400">
<i class="fa-solid fa-plane-arrival"></i> Arrival
</p>

</div>

</div>


<!-- Seats -->

<div class="text-center">

<p class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-semibold">
<i class="fa-solid fa-chair"></i>
Seats : ${f.seats}
</p>

<p class="text-xs text-gray-400 mt-1">
Availability
</p>

</div>


<!-- Price -->

<div class="text-center">

<p class="text-3xl font-bold text-blue-600">
<i class="fa-solid fa-indian-rupee-sign"></i>
${f.price}
</p>

<p class="text-xs text-gray-400">
Price / Seat
</p>

</div>


<!-- Book Button -->

<form action="selectSeat" method="get">
    <input type="hidden" name="flightId" value="${f.id}">
    <button>Book</button>
</form>

</div>

</c:forEach>

</div>

</div>

</div>
 
</body>
</html>