<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SkyBook | Login</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
*{margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif;}
body{height:100vh; display:flex; justify-content:center; align-items:center; 
background:url("https://images.unsplash.com/photo-1474302770737-173ee21bab63?auto=format&fit=crop&w=1950&q=80") center/cover no-repeat fixed; position:relative; overflow:hidden;}
body::before{content:""; position:absolute; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:0;}

.container{
position:relative; width:900px; max-width:90%; height:540px; background:rgba(255,255,255,0.08);
border-radius:20px; overflow:hidden; box-shadow:0 20px 60px rgba(0,0,0,0.4); backdrop-filter:blur(20px); z-index:2; transition:0.7s;
}

.form-container{
position:absolute; top:0; height:100%; width:50%; padding:60px 40px; display:flex; flex-direction:column; justify-content:center; align-items:center; transition:0.6s; z-index:2;
}

/* PREMIUM HEADING FIXED FOR VISIBILITY */
h2 {
  margin-bottom: 25px;
  font-size: 2.4rem;
  font-weight: 700;
  color: #ffffff; /* Solid white for contrast */
  text-align: center;
  text-shadow: 0 4px 15px rgba(0,0,0,0.5); /* Dark shadow for readability */
  position: relative;
  animation: popIn 0.8s ease forwards; /* smooth pop-in effect */
}

/* UNDERLINE SWIPE */
h2::after {
  content: "";
  position: absolute;
  bottom: -6px;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 3px;
  background: #000000; /* subtle blue underline */
  border-radius: 2px;
  transition: 0.5s;
}
h2:hover::after { width: 60%; }

/* POP-IN ANIMATION */
@keyframes popIn {
  0% { transform: scale(0.85); opacity: 0; }
  100% { transform: scale(1); opacity: 1; }
}
h2:hover {
  transform: scale(1.05);
  text-shadow: 0 6px 20px rgba(0,0,0,0.6); /* stronger shadow on hover */
  transition: 0.3s;
}
h2:hover::after{width:60%;}

/* GRADIENT ANIMATION */
@keyframes gradientMove{
  0%{background-position:0% 50%;}
  50%{background-position:100% 50%;}
  100%{background-position:0% 50%;}
}

/* POP-IN ANIMATION */
@keyframes popIn{
  0%{transform: scale(0.85); opacity:0;}
  100%{transform: scale(1); opacity:1;}
}
h2:hover{
  transform: scale(1.05);
  text-shadow: 0 6px 20px rgba(0,0,0,0.3);
  transition:0.3s;
}

/* INPUTS WITH ICONS */
.input-group{position:relative; width:280px; margin:16px 0;}
.input-group input{width:100%; padding:16px 40px 16px 40px; border:1px solid rgba(255,255,255,0.4); border-radius:8px; outline:none; background:rgba(255,255,255,0.05); font-size:14px; color:#fff; transition:0.3s;}
.input-group input:focus{border-color:#5a78b0; box-shadow:0 0 12px rgba(90,120,176,0.5); background:rgba(255,255,255,0.08);}
.input-group label{position:absolute; top:16px; left:40px; color:rgba(255,255,255,0.7); font-size:14px; pointer-events:none; transition:0.3s; background:transparent; padding:0 4px; font-weight:500;}
.input-group input:focus + label,
.input-group input:not(:placeholder-shown) + label{top:-10px; left:35px; font-size:12px; color:#;font-weight: 600;}
.input-group i{position:absolute; left:12px; top:50%; transform:translateY(-50%); color:rgba(255,255,255,0.7); font-size:16px;}
.show-pass{position:absolute; right:12px; top:50%; transform:translateY(-50%); cursor:pointer; color:rgba(255,255,255,0.7);}

/* REMEMBER ME & FORGOT PASSWORD */
.options{width:280px; display:flex; justify-content:space-between; align-items:center; font-size:13px; color:#fff; margin-top:-5px;}
.options a{color:#6c7baf; text-decoration:none; transition:0.3s;}
.options a:hover{text-decoration:underline;}

/* BUTTONS */
button{margin-top:20px; padding:14px 36px; border:none; border-radius:30px; background:linear-gradient(135deg,#4e6ca1,#6c7baf); color:white; cursor:pointer; font-weight:600; font-size:15px; transition:0.4s; box-shadow:0 5px 20px rgba(0,0,0,0.25);}
button:hover{transform:translateY(-4px); box-shadow:0 12px 30px rgba(0,0,0,0.35);}

.login-container{ left:0; }
.signup-container{ left:0; opacity:0; z-index:1; }

.overlay{
position:absolute; top:0; left:50%; width:50%; height:100%; background:rgba(78,108,161,0.85); color:white; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:40px; transition:0.6s; z-index:1; border-left:2px solid rgba(255,255,255,0.2);
}
.overlay h2{font-size:28px; margin-bottom:10px;}
.overlay p{font-size:14px; opacity:0.9;}
.overlay button{background:white; color:#4e6ca1; margin-top:20px; font-weight:bold; padding:14px 32px; border-radius:30px; cursor:pointer; transition:0.3s;}
.overlay button:hover{background:#dbe0f0; color:#4e6ca1; transform:translateY(-3px);}

.container.right-panel-active .login-container{transform:translateX(-100%);}
.container.right-panel-active .signup-container{transform:translateX(100%); opacity:1; z-index:5;}
.container.right-panel-active .overlay{transform:translateX(-100%);}

/* SUCCESS POPUP */
.success{
  position:fixed;
  top:50%;
  left:50%;
  transform:translate(-50%,-50%) scale(0);
  background:rgba(255,255,255,0.95);
  padding:50px;
  border-radius:15px;
  box-shadow:0 15px 50px rgba(0,0,0,0.5);
  text-align:center;
  z-index:10;
  opacity:0;
  transition: transform 0.6s ease, opacity 0.6s ease;
}

.success.active{
  transform:translate(-50%,-50%) scale(1);
  opacity:1;
}

.check{
  font-size:60px;
  color:green;
  margin-bottom:15px;
}

.success h3{
  font-size:1.8rem;
  margin-bottom:10px;
  color:#000;
}

.success p{
  font-size:1rem;
  color:#333;
}

@media(max-width:768px){.container{height:auto; min-height:600px;} .form-container{width:100%; position:relative; transform:none !important;} .overlay{display:none;}}
</style>
</head>
<body>
<div class="container" id="container">

<!-- LOGIN FORM -->
<div class="form-container login-container">
<h2>Welcome Back</h2>
<form action="login" method="post">
<div class="input-group">
<i class="fa fa-envelope"></i>
<input type="email" name="email" placeholder=" " required>
<label>Email</label>
</div>
<div class="input-group">
<i class="fa fa-lock"></i>
<input type="password" name="password" placeholder=" " id="loginPass" required>
<label>Password</label>
<i class="fa fa-eye show-pass" onclick="togglePassword('loginPass')"></i>
</div>
<div class="options">
<label><input type="checkbox"> Remember me</label>
<a href="#">Forgot password?</a>
</div>
<button type="submit">Login</button>
</form>
</div>

<!-- SIGNUP FORM -->
<div class="form-container signup-container">
<h2>Create Account</h2>
<form action="signup" method="post" onsubmit="showSuccess()">
<div class="input-group">
<i class="fa fa-user"></i>
<input type="text" name="name" placeholder=" " required>
<label>Name</label>
</div>
<div class="input-group">
<i class="fa fa-envelope"></i>
<input type="email" name="email" placeholder=" " required>
<label>Email</label>
</div>
<div class="input-group">
<i class="fa fa-lock"></i>
<input type="password" name="password" placeholder=" " id="signupPass" required>
<label>Password</label>
<i class="fa fa-eye show-pass" onclick="togglePassword('signupPass')"></i>
</div>
<div class="input-group">
<i class="fa fa-phone"></i>
<input type="text" name="phone" placeholder=" " required>
<label>Phone</label>
</div>
<button type="submit">Register</button>
</form>
</div>

<!-- OVERLAY -->
<div class="overlay">
<h2 id="overlayTitle">Create New Account</h2>
<p id="overlayText">Sign up and start booking flights today</p>
<button onclick="toggle()" id="overlayBtn">Register</button>
</div>

</div>

<!-- SUCCESS POPUP -->
<div class="success" id="successBox">
<div class="check">✔</div>
<h3>Registration Successful</h3>
<p>Switching to Login...</p>
</div>

<script>
function toggle(){
  let container=document.getElementById("container");
  container.classList.toggle("right-panel-active");
  let title=document.getElementById("overlayTitle");
  let text=document.getElementById("overlayText");
  let btn=document.getElementById("overlayBtn");
  if(container.classList.contains("right-panel-active")){
    title.innerText="Already Have an Account?";
    text.innerText="Login to continue booking flights";
    btn.innerText="Login";
  }else{
    title.innerText="Create New Account";
    text.innerText="Sign up and start booking flights today";
    btn.innerText="Register";
  }
}

function showSuccess(){
	  let box = document.getElementById("successBox");
	  box.classList.add("active"); // show popup
	  setTimeout(function(){
	    box.classList.remove("active"); // hide popup
	    document.getElementById("container").classList.remove("right-panel-active");
	  }, 15000); // 4 seconds
	}

function togglePassword(id){
  let input = document.getElementById(id);
  if(input.type === "password"){ input.type = "text"; }
  else{ input.type = "password"; }
}
</script>
</body>
</html>