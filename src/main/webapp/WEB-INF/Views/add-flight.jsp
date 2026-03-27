<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SkyBook | Add Flight</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    background:url("https://images.unsplash.com/photo-1502920917128-1aa500764cbd") no-repeat center/cover;
    min-height:100vh;
    font-family:'Segoe UI',sans-serif;
}

/* dark overlay */
.overlay{
    background:linear-gradient(to bottom, rgba(0,0,0,0.75), rgba(0,0,0,0.9));
}
</style>

</head>

<body>

<div class="overlay flex items-center justify-center min-h-screen">

<!-- Main Card -->
<div class="backdrop-blur-xl bg-white/10 border border-white/20 
            rounded-3xl shadow-2xl p-10 w-[500px]">

    <!-- Title -->
    <h2 class="text-3xl font-bold text-white text-center mb-8 tracking-wide">
        <i class="fa-solid fa-plane-departure text-blue-400"></i> 
        Add New Flight
    </h2>

    <!-- Form -->
    <form action="addFlight" method="post" class="space-y-5">

        <!-- Flight Name -->
        <div class="relative">
            <i class="fa-solid fa-plane absolute left-3 top-3 text-gray-400"></i>
            <input type="text" name="flightName" placeholder="Flight Name"
            class="w-full pl-10 p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">
        </div>

        <!-- Source & Destination -->
        <div class="grid grid-cols-2 gap-4">
            <input type="text" name="source" placeholder="From"
            class="p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">

            <input type="text" name="destination" placeholder="To"
            class="p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">
        </div>

        <!-- Date -->
        <input type="date" name="flightDate"
        class="w-full p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">

        <!-- Time -->
        <div class="grid grid-cols-2 gap-4">
            <input type="time" name="departureTime"
            class="p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">

            <input type="time" name="arrivalTime"
            class="p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">
        </div>

        <!-- Price & Seats -->
        <div class="grid grid-cols-2 gap-4">
            <input type="number" name="price" placeholder="Price"
            class="p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">

            <input type="number" name="seats" placeholder="Total Seats"
            class="p-3 rounded-xl bg-white/80 focus:outline-none focus:ring-2 focus:ring-blue-400">
        </div>

        <!-- Button -->
        <button 
        class="w-full bg-gradient-to-r from-blue-500 to-indigo-600 
               text-white py-3 rounded-xl font-semibold text-lg
               hover:scale-105 hover:shadow-xl transition duration-300 flex items-center justify-center gap-2">

            <i class="fa-solid fa-plus"></i> Add Flight
        </button>

    </form>

</div>

</div>

</body>
</html>