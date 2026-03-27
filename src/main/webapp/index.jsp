<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>SkyBook | Flight Reservation</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<!-- AOS Animation -->
<link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

/* BACKGROUND */

body{
min-height:100vh;
background:
linear-gradient(rgba(10,15,30,0.8), rgba(10,15,30,0.9)),
url("https://images.unsplash.com/photo-1502920917128-1aa500764b5c")
center/cover no-repeat;
color:white;
overflow-x:hidden;
}

/* NAVBAR */

.navbar{
display:flex;
justify-content:space-between;
align-items:center;
padding:25px 8%;
position:sticky;
top:0;
backdrop-filter:blur(12px);
background:rgba(255,255,255,0.05);
z-index:10;
}

.logo{
font-size:28px;
font-weight:700;
letter-spacing:2px;
color:#38bdf8;
}

.nav-buttons{
display:flex;
gap:15px;
}

.nav-buttons a{
text-decoration:none;
padding:10px 24px;
border-radius:30px;
font-size:14px;
transition:0.3s;
}

/* Buttons */

.login-btn{
border:1px solid rgba(255,255,255,0.5);
color:white;
}

.login-btn:hover{
background:white;
color:black;
}

.signup-btn{
background:linear-gradient(135deg,#38bdf8,#0ea5e9);
color:white;
box-shadow:0 0 15px rgba(56,189,248,0.5);
}

.signup-btn:hover{
transform:scale(1.05);
box-shadow:0 0 25px rgba(56,189,248,0.8);
}

/* HERO */

.hero{
display:flex;
justify-content:center;
align-items:center;
text-align:center;
padding:100px 10%;
}

.hero-content{
max-width:900px;
}

.hero h1{
font-size:60px;
font-weight:700;
background:linear-gradient(to right,#38bdf8,#22c55e);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
margin-bottom:20px;
}

.hero p{
font-size:18px;
opacity:0.9;
margin-bottom:40px;
}

/* CTA */

.cta-buttons{
display:flex;
justify-content:center;
flex-wrap:wrap;
gap:20px;
}

.cta-buttons a{
text-decoration:none;
padding:15px 40px;
border-radius:30px;
font-size:16px;
transition:0.3s;
}

.book-btn{
background:linear-gradient(135deg,#22c55e,#4ade80);
color:black;
font-weight:600;
box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

.book-btn:hover{
transform:translateY(-4px) scale(1.05);
box-shadow:0 15px 40px rgba(0,0,0,0.6);
}

/* FEATURES */

.features{
display:flex;
justify-content:center;
flex-wrap:wrap;
gap:30px;
padding:80px 8%;
}

.feature-card{
flex:1 1 250px;
max-width:300px;
padding:30px;
border-radius:20px;
background:rgba(255,255,255,0.08);
backdrop-filter:blur(15px);
border:1px solid rgba(255,255,255,0.1);
transition:0.4s;
position:relative;
overflow:hidden;
}

.feature-card::before{
content:"";
position:absolute;
width:200%;
height:200%;
background:radial-gradient(circle, rgba(56,189,248,0.2), transparent);
top:-50%;
left:-50%;
opacity:0;
transition:0.5s;
}

.feature-card:hover::before{
opacity:1;
}

.feature-card:hover{
transform:translateY(-12px) scale(1.03);
}

.feature-card h3{
margin:10px 0;
font-size:20px;
}

.feature-card p{
font-size:14px;
opacity:0.85;
}

/* FOOTER */

.footer{
text-align:center;
padding:20px;
font-size:14px;
opacity:0.7;
}

/* RESPONSIVE */

@media(max-width:1024px){
.hero h1{
font-size:45px;
}
}

@media(max-width:768px){

.navbar{
flex-direction:column;
gap:15px;
}

.hero{
padding:70px 20px;
}

.hero h1{
font-size:34px;
}

.hero p{
font-size:16px;
}

}

@media(max-width:480px){

.hero h1{
font-size:28px;
}

.cta-buttons a{
padding:12px 25px;
font-size:14px;
}

}

</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar" data-aos="fade-down">
<div class="logo">SkyBook</div>

<div class="nav-buttons">
<a href="login" class="login-btn">Login</a>
<a href="signup" class="signup-btn">Create Account</a>
</div>
</div>

<!-- HERO -->
<div class="hero">
<div class="hero-content" data-aos="zoom-in">

<h1>Book Flights Around The World</h1>

<p>
Experience seamless booking with a modern, fast, and secure flight reservation system.
</p>

<div class="cta-buttons">
<a href="signup" class="book-btn">Start Booking</a>
</div>

</div>
</div>

<!-- FEATURES -->
<div class="features">

<div class="feature-card" data-aos="fade-up">
<h3> Smart Flight Search</h3>
<p>Find flights instantly with an intelligent search system.</p>
</div>

<div class="feature-card" data-aos="fade-up" data-aos-delay="100">
<h3> Secure Booking</h3>
<p>End-to-end encrypted and safe reservations.</p>
</div>

<div class="feature-card" data-aos="fade-up" data-aos-delay="200">
<h3> Global Destinations</h3>
<p>Access hundreds of routes worldwide.</p>
</div>

<div class="feature-card" data-aos="fade-up" data-aos-delay="300">
<h3> Fast Reservations</h3>
<p>Complete bookings in seconds with smooth UX.</p>
</div>

</div>

<!-- FOOTER -->
<div class="footer">
SkyBook Flight Reservation System © 2026
</div>

<!-- AOS INIT -->
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
AOS.init({
duration:1000,
once:true
});
</script>

</body>
</html>