<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>SkyBook | Create Account</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<!-- AOS -->
<link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">

<!-- Lottie -->
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>

<style>

/* RESET */
*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

/* BACKGROUND */
body{
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:
linear-gradient(rgba(10,15,30,0.85), rgba(10,15,30,0.95)),
url("https://images.pexels.com/photos/358319/pexels-photo-358319.jpeg")
center/cover no-repeat fixed;
overflow:hidden;
}

/* CONTAINER */
.container{
width:100%;
max-width:420px;
padding:35px 28px;
border-radius:20px;

background:rgba(255,255,255,0.08);
backdrop-filter:blur(15px);
border:1px solid rgba(255,255,255,0.1);

box-shadow:0 20px 60px rgba(0,0,0,0.6);
}

/* HEADING */
.container h2{
text-align:center;
font-size:28px;
font-weight:600;
margin-bottom:15px;
background:linear-gradient(to right,#38bdf8,#22c55e);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
}

/* INPUT GROUP */
.input-group{
position:relative;
margin:15px 0;
}

/* INPUT */
.input-group input{
width:100%;
padding:12px 15px;
border:none;
border-radius:25px;
outline:none;

background:rgba(255,255,255,0.15);
color:white;
font-size:14px;
}

/* FLOAT LABEL */
.input-group label{
position:absolute;
left:15px;
top:12px;
color:#ccc;
font-size:14px;
transition:0.3s;
pointer-events:none;
}

.input-group input:focus + label,
.input-group input:valid + label{
top:-8px;
font-size:11px;
color:#38bdf8;
}

/* FOCUS */
.input-group input:focus{
background:rgba(255,255,255,0.25);
box-shadow:0 0 12px rgba(56,189,248,0.8);
}

/* PASSWORD TOGGLE */
.toggle-pass{
position:absolute;
right:15px;
top:12px;
cursor:pointer;
font-size:12px;
color:#ddd;
}

/* STRENGTH */
#strength{
font-size:12px;
margin-top:5px;
}

/* BUTTON */
button{
width:100%;
margin-top:18px;
padding:13px;
border:none;
border-radius:25px;

background:linear-gradient(135deg,#38bdf8,#0ea5e9);
color:white;
font-size:15px;
font-weight:600;

cursor:pointer;
transition:0.3s;
}

button:hover{
transform:translateY(-3px);
box-shadow:0 0 20px rgba(56,189,248,0.8);
}

/* TERMS */
.terms{
font-size:13px;
margin-top:10px;
color:#ddd;
}

/* LOGIN LINK */
p{
text-align:center;
margin-top:15px;
font-size:14px;
color:#ccc;
}

p a{
color:#38bdf8;
text-decoration:none;
}

p a:hover{
text-decoration:underline;
}

/* RESPONSIVE */
@media(max-width:480px){
.container{
padding:28px 20px;
}
}

</style>
</head>

<body>

<div class="container" data-aos="zoom-in">

<!-- LOTTIE -->
<lottie-player 
src="https://assets2.lottiefiles.com/packages/lf20_tfb3estd.json"
background="transparent"
speed="1"
style="width:120px; margin:auto;"
loop autoplay>
</lottie-player>

<h2>Create Account</h2>

<form action="signup" method="post" onsubmit="showLoader(event)">

<div class="input-group">
<input type="text" name="name" required>
<label>Full Name</label>
</div>

<div class="input-group">
<input type="email" name="email" required>
<label>Email Address</label>
</div>

<div class="input-group">
<input type="password" id="password" name="password" required>
<label>Password</label>
<span class="toggle-pass" onclick="togglePassword()">Show</span>
<div id="strength"></div>
</div>

<div class="input-group">
<input type="text" name="phone" pattern="[0-9]{10}" required>
<label>Phone Number</label>
</div>

<div class="terms">
<input type="checkbox" required> I agree to Terms & Conditions
</div>

<button type="submit" id="btn">Create Account</button>

</form>

<p>Already have an account? <a href="login">Login</a></p>

</div>

<!-- AOS -->
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
AOS.init({duration:1000, once:true});
</script>

<!-- PASSWORD TOGGLE -->
<script>
function togglePassword(){
let pass = document.getElementById("password");
pass.type = pass.type === "password" ? "text" : "password";
}
</script>

<!-- PASSWORD STRENGTH -->
<script>
document.getElementById("password").addEventListener("input", function() {
let val = this.value;
let strength = document.getElementById("strength");

if(val.length < 6){
strength.innerHTML = "Weak Password";
strength.style.color = "red";
}
else if(val.match(/[A-Z]/) && val.match(/[0-9]/)){
strength.innerHTML = "Strong Password";
strength.style.color = "lightgreen";
}
else{
strength.innerHTML = "Medium Password";
strength.style.color = "orange";
}
});
</script>

<!-- LOADER -->
<script>
function showLoader(e){
let btn = document.getElementById("btn");
btn.innerHTML = "Creating...";
btn.disabled = true;
}
</script>

</body>
</html>