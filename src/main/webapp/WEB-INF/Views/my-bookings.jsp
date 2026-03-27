<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String msg = (String) request.getAttribute("msg"); %>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - SkyBook</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, #0f172a, #020617);
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
        .glass {
            background: rgba(255, 255, 255, 0.06);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.08);
        }

        .ticket {
            position: relative;
            overflow: hidden;
        }

        /* Perforated edges */
        .ticket::before, .ticket::after {
            content: "";
            position: absolute;
            width: 30px;
            height: 30px;
            background: #020617;
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
        }

        .ticket::before { left: -15px; }
        .ticket::after { right: -15px; }

        .hover-glow:hover {
            box-shadow: 0 0 30px rgba(59,130,246,0.4);
            transform: translateY(-6px);
        }

        .fade-in {
            animation: fadeIn 0.8s ease forwards;
        }

        @keyframes fadeIn {
            from {opacity:0; transform: translateY(20px);}
            to {opacity:1; transform: translateY(0);}
        }
    </style>
</head>

<body class="text-white min-h-screen">

<!-- PREMIUM NAVBAR -->
<nav class="flex justify-between items-center px-12 py-5 text-white backdrop-blur-xl bg-white/5 border-b border-white/10">

    <!-- LOGO -->
    <h1 class="text-3xl font-bold tracking-wide">
        <i class="fa-solid fa-plane-departure text-blue-400"></i> SkyBook
    </h1>

    <!-- MENU -->
    <div class="space-x-8 text-lg flex items-center">

        <!-- HOME -->
        <a href="home" class="hover:text-blue-400 transition flex items-center gap-2">
            <i class="fa-solid fa-house"></i> Home
        </a>

        <!-- BOOKINGS -->
        <a href="myBookings" class="text-blue-400 font-semibold flex items-center gap-2">
            <i class="fa-solid fa-ticket"></i> My Bookings
        </a>

        <!-- PROFILE -->
        <a href="profile" class="hover:text-blue-400 transition flex items-center gap-2">
            <i class="fa-solid fa-user"></i> Profile
        </a>

        <!-- LOGOUT -->
        <a href="login" class="bg-red-500 px-4 py-2 rounded-lg hover:bg-red-600 transition shadow flex items-center gap-2">
            <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>

    </div>

</nav>

<!-- Header -->
<div class="text-center py-10 mt-4">
    <h1 class="text-4xl font-bold">✈️ My Trips</h1>
    <p class="text-gray-400 mt-2">Manage your journeys like a pro</p>
</div>

<div class="max-w-6xl mx-auto px-4 space-y-8">

<c:forEach var="b" items="${bookings}" varStatus="loop">

    <div class="glass ticket rounded-2xl p-6 hover-glow transition duration-300 fade-in"
         style="animation-delay:${loop.index * 0.1}s">

        <!-- TOP SECTION -->
        <div class="flex flex-col md:flex-row justify-between md:items-center">

            <!-- LEFT: ROUTE -->
            <!-- LEFT: ROUTE -->
<div class="flex items-center gap-6">

    <!-- SOURCE -->
    <div class="text-center">
        <p class="text-2xl font-bold">
            ${b.flight.source}
        </p>
        <p class="text-xs text-gray-400">Departure</p>
    </div>

    <!-- PLANE -->
    <div class="flex flex-col items-center text-blue-400">
        <i class="fa-solid fa-plane text-xl"></i>
        <div class="w-20 h-[2px] bg-blue-400 my-1"></div>
        <p class="text-xs">
            ${b.flight.flightName}
        </p>
    </div>

    <!-- DESTINATION -->
    <div class="text-center">
        <p class="text-2xl font-bold">
            ${b.flight.destination}
        </p>
        <p class="text-xs text-gray-400">Arrival</p>
    </div>

</div>
            <!-- RIGHT: DATE -->
            <div class="text-right mt-4 md:mt-0">
                <p class="text-lg font-semibold text-green-400">Confirmed</p>
                <p class="text-sm text-gray-400">25 Mar 2026</p>
            </div>

        </div>

        <!-- DIVIDER -->
        <div class="border-t border-dashed border-white/20 my-5"></div>

        <!-- MIDDLE SECTION -->
        <div class="grid md:grid-cols-3 gap-4">

            <!-- Passenger -->
            <div>
                <p class="text-sm text-gray-400">Passenger</p>
                <p class="font-semibold text-lg">${b.passengerName}</p>
                <p class="text-xs text-gray-400">${b.gender}, Age ${b.passengerAge}</p>
            </div>

            <!-- PNR -->
            <div>
                <p class="text-sm text-gray-400">PNR</p>
                <p class="font-bold text-green-400 text-lg">${b.pnr}</p>
            </div>

            <!-- Seat -->
            <div>
                <p class="text-sm text-gray-400">Seat</p>
                <p class="font-semibold text-yellow-400 text-lg">${b.seatNumber}</p>
            </div>

        </div>

        <!-- DIVIDER -->
        <div class="border-t border-dashed border-white/20 my-5"></div>

        <!-- BOTTOM SECTION -->
        <div class="flex flex-col md:flex-row justify-between items-center gap-4">

            <!-- QR / Ticket -->
            <div class="flex items-center gap-4">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=80x80&data=${b.pnr}"
                     class="rounded-lg bg-white p-1">

                <div>
                    <p class="text-sm text-gray-400">Boarding Pass</p>
                    <p class="text-xs text-gray-500">Scan at gate</p>
                </div>
            </div>

            <!-- ACTIONS -->
            <div class="flex gap-3">

    <!-- VIEW -->
    <form action="ticketPage" method="get">
        <input type="hidden" name="pnr" value="${b.pnr}">
        <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 rounded-lg text-sm transition">
            <i class="fa-solid fa-eye mr-1"></i> View
        </button>
    </form>

    <!-- DOWNLOAD -->
    <form action="downloadTicket" method="get">
        <input type="hidden" name="pnr" value="${b.pnr}">
        <button onclick="showToast()" class="px-4 py-2 bg-green-500 hover:bg-green-600 rounded-lg text-sm transition">
            <i class="fa-solid fa-download mr-1"></i> Ticket
        </button>
    </form>

    <!-- CANCEL -->
    <form action="cancelBooking" method="post"
          onsubmit="return confirm('Are you sure you want to cancel this booking?');">
        <input type="hidden" name="pnr" value="${b.pnr}">
        <button class="px-4 py-2 bg-red-500 hover:bg-red-600 rounded-lg text-sm transition">
            <i class="fa-solid fa-xmark mr-1"></i> Cancel
        </button>
    </form>

</div>

        </div>

    </div>

</c:forEach>

</div>

<!-- EMPTY STATE -->
<c:if test="${empty bookings}">
    <div class="text-center mt-20">
        <img src="https://cdn.dribbble.com/users/357371/screenshots/2209282/plane.gif"
             class="mx-auto w-48 opacity-80">

        <p class="mt-6 text-gray-300 text-lg">
            No trips yet. Time to explore ✈️
        </p>
    </div>
</c:if>

<div id="toast"
     class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 
            bg-green-500 text-white px-8 py-4 rounded-xl shadow-2xl 
            text-lg font-semibold hidden z-50">
    ✅ Ticket Downloaded
</div>

</body>

<script>
function showToast() {
    let toast = document.getElementById("toast");

    toast.classList.remove("hidden");
    toast.classList.add("animate-bounce");

    setTimeout(() => {
        toast.classList.add("hidden");
        toast.classList.remove("animate-bounce");
    }, 2500);
}
</script>
</html>