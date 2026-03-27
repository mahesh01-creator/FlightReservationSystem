<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String msg = (String) request.getAttribute("msg"); %>

<!DOCTYPE html>
<html>
<head>

<title>SkyBook | Dashboard</title>

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
    background: radial-gradient(circle at top,#0f172a,#020617);
    font-family:'Poppins',sans-serif;
}

/* Glass UI */
.glass{
    background: rgba(255,255,255,0.06);
    backdrop-filter: blur(20px);
    border:1px solid rgba(255,255,255,0.08);
}

/* Hover Effects */
.card:hover{
    transform: translateY(-6px) scale(1.02);
    box-shadow: 0 10px 40px rgba(59,130,246,0.25);
}

/* Navbar */
.nav-link{
    transition: all 0.3s ease;
}
.nav-link:hover{
    color:#60a5fa;
    transform: translateY(-2px);
}

/* Animation */
.fade{
    animation: fade 0.5s ease;
}
@keyframes fade{
    from{opacity:0; transform:translateY(10px);}
    to{opacity:1; transform:translateY(0);}
}

</style>

</head>

<body class="text-white min-h-screen">

<!-- 🔝 NAVBAR -->
<nav class="sticky top-0 z-50 flex justify-between items-center px-10 py-4 backdrop-blur-md bg-black/30 border-b border-white/10">

    <h1 class="text-2xl font-bold">
        <i class="fa-solid fa-plane-departure text-blue-400"></i> SkyBook
    </h1>

    <div class="flex items-center gap-6 text-sm">

        <a href="home" class="nav-link">
            <i class="fa-solid fa-house"></i> Home
        </a>

        <a href="myBookings" class="nav-link">
            <i class="fa-solid fa-ticket"></i> My Bookings
        </a>

        <a href="profile" class="nav-link text-blue-400 font-semibold">
            <i class="fa-solid fa-user"></i> Profile
        </a>

        <a href="logout" class="bg-red-500 px-4 py-2 rounded-lg hover:bg-red-600 transition">
            Logout
        </a>

    </div>

</nav>

<!-- 🔵 HERO -->
<div class="max-w-7xl mx-auto mt-10 px-6 fade">

<div class="bg-gradient-to-r from-blue-600 via-indigo-600 to-purple-700 p-8 rounded-3xl shadow-2xl flex justify-between items-center">

    <div class="flex items-center gap-6">

        <div class="bg-white/20 p-6 rounded-full text-4xl">
            <i class="fa-solid fa-user"></i>
        </div>

        <div>
            <h2 class="text-3xl font-bold">${user.name}</h2>
            <p class="opacity-80">${user.email}</p>
        </div>

    </div>

    <div class="text-right">
        <p class="text-sm opacity-80">Status</p>
        <p class="text-xl font-bold text-green-300">${status}</p>
    </div>

</div>

</div>

<!-- 📊 STATS -->
<div class="max-w-7xl mx-auto mt-6 px-6 grid grid-cols-2 md:grid-cols-4 gap-5">

    <div class="glass card p-5 rounded-xl text-center">
        <i class="fa-solid fa-plane text-blue-400 text-xl"></i>
        <p class="text-2xl font-bold mt-2">${totalTrips}</p>
        <p class="text-xs text-gray-400">Total Trips</p>
    </div>

    <div class="glass card p-5 rounded-xl text-center">
        <i class="fa-solid fa-indian-rupee-sign text-green-400 text-xl"></i>
        <p class="text-2xl font-bold mt-2">₹ ${totalSpent}</p>
        <p class="text-xs text-gray-400">Total Spent</p>
    </div>

    <div class="glass card p-5 rounded-xl text-center">
        <i class="fa-solid fa-calendar text-yellow-400 text-xl"></i>
        <p class="text-2xl font-bold mt-2">${upcomingTrips}</p>
        <p class="text-xs text-gray-400">Upcoming Flights</p>
    </div>

    <div class="glass card p-5 rounded-xl text-center">
        <i class="fa-solid fa-star text-purple-400 text-xl"></i>
        <p class="text-2xl font-bold mt-2">${status}</p>
        <p class="text-xs text-gray-400">Tier</p>
    </div>

</div>

<!-- ⚡ ACTION CARDS -->
<div class="max-w-7xl mx-auto mt-6 px-6 grid grid-cols-2 md:grid-cols-4 gap-5">

    <div onclick="window.location.href='myBookings'"
         class="glass card p-5 rounded-xl text-center cursor-pointer">
        <i class="fa-solid fa-ticket text-blue-400 text-2xl"></i>
        <p class="mt-3 text-sm">My Bookings</p>
    </div>

    <div onclick="window.location.href='home'"
         class="glass card p-5 rounded-xl text-center cursor-pointer">
        <i class="fa-solid fa-magnifying-glass text-green-400 text-2xl"></i>
        <p class="mt-3 text-sm">Search Flights</p>
    </div>

    <div onclick="showTab('update')"
         class="glass card p-5 rounded-xl text-center cursor-pointer">
        <i class="fa-solid fa-user-gear text-yellow-400 text-2xl"></i>
        <p class="mt-3 text-sm">Update Profile</p>
    </div>

    <div onclick="showTab('security')"
         class="glass card p-5 rounded-xl text-center cursor-pointer">
        <i class="fa-solid fa-shield-halved text-red-400 text-2xl"></i>
        <p class="mt-3 text-sm">Change Credentials</p>
    </div>

</div>

<!-- 📦 CONTENT -->
<div class="max-w-7xl mx-auto mt-6 px-6">

<div class="glass p-6 rounded-2xl">

<!-- ================= DASHBOARD ================= -->
<div id="dashboardSection">

    <h2 class="text-xl font-semibold mb-4">Recent Bookings</h2>

    <div class="space-y-3">

    <c:forEach var="b" items="${recentBookings}">
        <div class="flex justify-between bg-white/10 p-4 rounded-lg card">
            <div>
                <p class="font-semibold">${b.flight.source} → ${b.flight.destination}</p>
                <p class="text-xs text-gray-400">${b.flight.flightDate}</p>
            </div>
            <p class="text-green-400">${b.pnr}</p>
        </div>
    </c:forEach>

    </div>

</div>

<!-- ================= UPDATE PROFILE ================= -->
<div id="updateSection" style="display:none;">

    <h2 class="text-xl font-semibold mb-4">Update Profile</h2>

    <form action="updateProfile" method="post" class="grid grid-cols-2 gap-4">

        <input type="text" name="name" value="${user.name}" class="p-3 rounded text-black">
        <input type="email" name="email" value="${user.email}" class="p-3 rounded text-black">
        <input type="text" name="phone" value="${user.phn}" class="p-3 rounded text-black">

        <button class="col-span-2 bg-blue-500 py-3 rounded hover:bg-blue-600">
            Save Changes
        </button>

    </form>

</div>

<!-- ================= CHANGE CREDENTIALS ================= -->
<div id="securitySection" style="display:none;">

    <h2 class="text-xl font-semibold mb-4">Change Credentials</h2>

    <form action="changePassword" method="post" class="space-y-4 max-w-md">

        <input type="password" name="oldPassword" placeholder="Old Password"
               class="w-full p-3 rounded text-black">

        <input type="password" name="newPassword" placeholder="New Password"
               class="w-full p-3 rounded text-black">

        <button class="bg-red-500 w-full py-3 rounded hover:bg-red-600">
            Update Password
        </button>

    </form>

</div>

</div>

</div>

</div>

<script>

function showTab(tab){

    // hide all sections
    document.getElementById("updateSection").style.display = "none";
    document.getElementById("securitySection").style.display = "none";
    document.getElementById("dashboardSection").style.display = "none";

    // show selected
    if(tab === "update"){
        document.getElementById("updateSection").style.display = "block";
    }

    if(tab === "security"){
        document.getElementById("securitySection").style.display = "block";
    }

    if(tab === "dashboard"){
        document.getElementById("dashboardSection").style.display = "block";
    }
}

</script>

</body>
</html>