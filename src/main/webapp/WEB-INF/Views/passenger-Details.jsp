<%@ page contentType="text/html; charset=UTF-8" %>
<% String msg = (String) request.getAttribute("msg"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Passenger Details</title>

<script src="https://cdn.tailwindcss.com"></script>

<style>
body{
    background:linear-gradient(to right,#0f172a,#1e293b);
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

.glass{
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
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

<div class="min-h-screen flex justify-center items-center p-6">

<div class="glass p-8 rounded-3xl w-full max-w-3xl shadow-2xl">

<h2 class="text-2xl font-bold mb-6 text-center">
👤 Enter Passenger Details
</h2>

<form action="confirmBooking" onsubmit="return validatePassengers()" method="post">

<input type="hidden" name="flightId" value="${flightId}">

<%
String[] seats = (String[]) request.getAttribute("seats");

for(int i=0; i<seats.length; i++){
%>

<div class="bg-white/10 p-4 rounded-xl mb-4">

<h3 class="mb-3 font-semibold text-yellow-400">
Seat: <%= seats[i] %>
</h3>

<input type="hidden" name="seatNumbers" value="<%= seats[i] %>">

<div class="grid grid-cols-1 md:grid-cols-3 gap-3">

<input type="text" name="passengerName" placeholder="Name"
class="p-2 rounded text-black">

<input type="number" name="age" placeholder="Age"
class="p-2 rounded text-black">

<select name="gender" class="p-2 rounded text-black">
<option>Male</option>
<option>Female</option>
<option>Other</option>
</select>

</div>

</div>

<% } %>

<button class="w-full bg-green-500 py-3 rounded-xl hover:bg-green-600 transition">
Confirm Booking
</button>

</form>

</div>

</div>
<!-- TOAST -->
<div id="toast"
     class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 
            bg-red-500 text-white px-8 py-4 rounded-xl shadow-2xl 
            text-lg font-semibold hidden z-50">Fill all passenger details</div>
</body>

<script>
function validatePassengers(){

    let names = document.getElementsByName("passengerName");
    let ages = document.getElementsByName("age");
    let genders = document.getElementsByName("gender");

    for(let i = 0; i < names.length; i++){

        let name = names[i].value.trim();
        let age = ages[i].value;

        if(name === "" || age === ""){
            showToast(" Fill all passenger details");
            return false;
        }

        if(age <= 0 || age > 120){
            showToast(" Enter valid age");
            return false;
        }

        if(name.length < 2){
            showToast(" Enter valid name");
            return false;
        }
    }

    return true;
}

function showToast(message){
    let toast = document.getElementById("toast");

    toast.innerText = message;
    toast.classList.remove("hidden");
    toast.classList.add("animate-bounce");

    setTimeout(()=>{
        toast.classList.add("hidden");
        toast.classList.remove("animate-bounce");
    }, 1000);
}
</script>
</html>