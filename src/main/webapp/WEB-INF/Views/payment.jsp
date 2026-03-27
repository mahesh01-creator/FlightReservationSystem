<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<% String msg = (String) request.getAttribute("msg"); %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Secure Payment</title>

<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(15px);
}
.tab{
    cursor:pointer;
}
.active{
    background:#22c55e;
}
</style>

</head>

<body class="text-white min-h-screen flex flex-col">

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

<!-- CENTER CONTENT -->
<div class="flex justify-center items-center flex-1">

<div class="glass w-full max-w-lg p-6 rounded-3xl shadow-2xl">

<h2 class="text-2xl font-bold text-center mb-6">🔒 Secure Payment</h2>

<form action="paymentSuccess" method="post" onsubmit="return validatePayment()">

<input type="hidden" name="flightId" value="${flightId}">

<%
String[] seats = (String[]) request.getAttribute("seatNumbers");
String[] names = (String[]) request.getAttribute("names");
int[] ages = (int[]) request.getAttribute("ages");
String[] genders = (String[]) request.getAttribute("genders");

if(seats == null){
    seats = new String[0];
}

for(int i=0;i<seats.length;i++){
%>
<input type="hidden" name="seatNumbers" value="<%=seats[i]%>">
<input type="hidden" name="names" value="<%=names[i]%>">
<input type="hidden" name="ages" value="<%=ages[i]%>">
<input type="hidden" name="genders" value="<%=genders[i]%>">
<% } %>

<!-- TABS -->
<div class="grid grid-cols-3 gap-2 mb-4 text-center">

<div id="upiTab" class="tab p-2 bg-slate-700 rounded active" onclick="showTab('upi')">UPI</div>
<div id="cardTab" class="tab p-2 bg-slate-700 rounded" onclick="showTab('card')">Card</div>
<div id="netTab" class="tab p-2 bg-slate-700 rounded" onclick="showTab('net')">NetBank</div>

</div>

<input type="hidden" id="paymentType" name="paymentType" value="UPI">

<!-- UPI -->
<div id="upiSection">

<p class="text-center mb-2">Scan & Pay</p>

<img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=upi://pay?pa=test@upi"
class="mx-auto rounded">

<input id="upiId" type="text" placeholder="Enter UPI ID"
class="mt-3 p-2 w-full rounded text-black">

</div>

<!-- CARD -->
<div id="cardSection" class="hidden space-y-3">

<input id="cardNumber" type="text" placeholder="Card Number"
class="p-2 w-full rounded text-black">

<input id="cardName" type="text" placeholder="Card Holder"
class="p-2 w-full rounded text-black">

<div class="flex gap-2">
<input id="expiry" type="text" placeholder="MM/YY"
class="p-2 w-1/2 rounded text-black">

<input id="cvv" type="text" placeholder="CVV"
class="p-2 w-1/2 rounded text-black">
</div>

</div>

<!-- NET BANKING -->
<div id="netSection" class="hidden">

<select id="bank" class="p-2 w-full rounded text-black">
<option value="">Select Bank</option>
<option>SBI</option>
<option>HDFC</option>
<option>ICICI</option>
<option>Axis</option>
</select>

</div>

<div class="mb-4 text-sm bg-slate-800 p-3 rounded">

<p><b>Seats:</b>
<%
for(String s : seats){
    out.print(s + " ");
}
%>
</p>

</div>

<button id="payBtn" class="w-full mt-6 bg-green-500 py-3 rounded-lg hover:bg-green-600">
Pay Now
</button>

</form>

</div>
</div>

<!-- TOAST -->
<div id="toast"
class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 
bg-red-500 text-white px-8 py-4 rounded-xl shadow-2xl 
text-lg font-semibold hidden z-50">
⚠️ Error
</div>

<script>

function showToast(msg){
    let toast = document.getElementById("toast");
    toast.innerText = msg;
    toast.classList.remove("hidden");

    setTimeout(()=>{
        toast.classList.add("hidden");
    },2000);
}

function showTab(type){

document.getElementById("upiSection").style.display="none";
document.getElementById("cardSection").style.display="none";
document.getElementById("netSection").style.display="none";

document.getElementById("upiTab").classList.remove("active");
document.getElementById("cardTab").classList.remove("active");
document.getElementById("netTab").classList.remove("active");

if(type==="upi"){
document.getElementById("upiSection").style.display="block";
document.getElementById("upiTab").classList.add("active");
document.getElementById("paymentType").value="UPI";
}

if(type==="card"){
document.getElementById("cardSection").style.display="block";
document.getElementById("cardTab").classList.add("active");
document.getElementById("paymentType").value="CARD";
}

if(type==="net"){
document.getElementById("netSection").style.display="block";
document.getElementById("netTab").classList.add("active");
document.getElementById("paymentType").value="NETBANK";
}

}

function validatePayment(){

let type = document.getElementById("paymentType").value;

if(type==="UPI"){
let upi = document.getElementById("upiId").value;
if(upi === ""){
showToast("Enter UPI ID");
return false;
}
}

if(type==="CARD"){
let num = document.getElementById("cardNumber").value;
let cvv = document.getElementById("cvv").value;

if(num.length < 12){
showToast("Invalid Card Number");
return false;
}
if(cvv.length < 3){
showToast("Invalid CVV");
return false;
}
}

if(type==="NETBANK"){
let bank = document.getElementById("bank").value;
if(bank === ""){
showToast("Select Bank");
return false;
}
}

let btn = document.getElementById("payBtn");
btn.innerText="Processing...";
btn.disabled=true;

return true;
}

</script>

</body>
</html>