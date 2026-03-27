<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String msg = (String) request.getAttribute("msg"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight Ticket</title>

<script src="https://cdn.tailwindcss.com"></script>

<style>
body{
    background: linear-gradient(to right,#020617,#0f172a);
    font-family: 'Segoe UI', sans-serif;
}

/* NAV HOVER */
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

/* Ticket Cut Effect */
.ticket{
    position:relative;
}
.ticket::before,
.ticket::after{
    content:'';
    position:absolute;
    width:35px;
    height:35px;
    background:#020617;
    border-radius:50%;
}
.ticket::before{
    top:50%;
    left:-18px;
    transform:translateY(-50%);
}
.ticket::after{
    top:50%;
    right:-18px;
    transform:translateY(-50%);
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

<!-- ✅ MAIN CONTAINER -->
<div class="max-w-5xl mx-auto px-6 py-12">

    <!-- ✈ TICKET CARD -->
    <div class="ticket bg-white/10 backdrop-blur-xl rounded-3xl shadow-2xl p-10">

        <!-- HEADER -->
        <div class="flex justify-between items-center border-b border-white/20 pb-5 mb-8">

            <div>
                <h2 class="text-3xl font-bold text-green-400">
                    E-Ticket / Boarding Pass
                </h2>
                <p class="text-gray-400 text-sm">
                    Your booking is confirmed
                </p>
            </div>

            <div class="text-right">
                <p class="text-gray-400 text-sm">PNR</p>
                <p class="text-2xl font-bold text-yellow-400">
                    SB${flight.id}${bookings.size()}
                </p>
            </div>

        </div>

        <!-- ✈ ROUTE -->
        <div class="grid grid-cols-3 text-center mb-10">

            <div>
                <p class="text-3xl font-bold">${flight.source}</p>
                <p class="text-gray-400">${flight.departureTime}</p>
            </div>

            <div class="flex flex-col items-center justify-center">
                <p class="text-xl">✈</p>
                <p class="text-gray-400 text-sm">${flight.flightName}</p>
            </div>

            <div>
                <p class="text-3xl font-bold">${flight.destination}</p>
                <p class="text-gray-400">${flight.arrivalTime}</p>
            </div>

        </div>

        <!-- DATE -->
        <div class="text-center text-gray-300 mb-8">
            📅 ${flight.flightDate}
        </div>

        <!-- 👥 PASSENGERS -->
        <div class="space-y-4">

            <c:forEach var="b" items="${bookings}">
                <div class="bg-white/10 p-5 rounded-xl flex justify-between items-center hover:bg-white/20 transition">

                    <div>
                        <p class="font-semibold text-lg">${b.passengerName}</p>
                        <p class="text-sm text-gray-400">
                            ${b.gender}, Age ${b.passengerAge}
                        </p>
                    </div>

                    <div class="text-right">
                        <p class="text-yellow-400 font-bold text-lg">
                            Seat ${b.seatNumber}
                        </p>
                    </div>

                </div>
            </c:forEach>

        </div>

        <!-- 💳 PAYMENT + QR -->
        <div class="flex flex-col md:flex-row justify-between items-center mt-10 border-t border-white/20 pt-6 gap-6">

            <div>
                <p class="text-gray-400">Total Paid</p>
                <p class="text-3xl font-bold text-green-400">
                    ₹ ${total}
                </p>
            </div>

            <div class="bg-white p-3 rounded-lg">
                <img 
                src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=PNR-${flight.id}"
                alt="QR Code">
            </div>

        </div>

    </div>

    <!-- 🎯 ACTION BUTTONS -->
    <div class="flex justify-center gap-6 mt-10">

        <a href="home"
        class="bg-blue-500 px-8 py-3 rounded-xl hover:bg-blue-600 transition shadow-lg">
            🏠 Home
        </a>

        <a href="downloadTicket"
        class="bg-green-500 px-8 py-3 rounded-xl hover:bg-green-600 transition shadow-lg">
            ⬇ Download Ticket
        </a>

    </div>

</div>

</body>
</html>