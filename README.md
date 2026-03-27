**Flight Reservation System (SkyBook)** 



A full-stack Flight Reservation Web Application built using **Spring MVC, Hibernate, JSP, and MySQL**

This system allows users to search flights, book tickets, select seats, and receive email confirmations with PDF tickets.



*Admin Dashboard is not ready yet but by using **"addFlight"** you can add flights and get saved in Database.*



**🚀Features :-**

&#x09; User Authentication (Login / Signup)

&#x09; Flight Search (Source, Destination, Date)

&#x09; Seat Selection System

&#x09; Passenger Details Management

&#x09; Booking \& Payment Flow

&#x09; Ticket Generation (PDF)

&#x09; Email Notification with Ticket Attachment

&#x09; User Profile Dashboard

&#x09; Booking Cancellation





**Tech Stack :-**



* Backend : Java, Spring MVC
* ORM : Hibernate (JPA)
* Frontend : JSP, JSTL, Tailwind CSS
* Database : MySQL
* Server : Apache Tomcat 10
* Build Tool : Maven
* 
* Libraries :- 

&#x09;  Jakarta Mail (Email Service)

&#x09;  iTextPDF (PDF Generation)

&#x09;  ZXing (QR Code)





**📂 Project Structure :-**



FlightReservation1/

│── src/

│   ├── controller/

│   ├── service/

│   ├── repository/

│   ├── entity/

│   └── util/

│

│── WEB-INF/

│   ├── Views/

│   ├── web.xml

│   └── dispatcher-servlet.xml

│

│── pom.xml





**⚙️ Setup \& Installation :-**



&#x20;1️⃣ Clone Repository

&#x09;git clone https://github.com/your-username/FlightReservationSystem.git



2️⃣ Import Project

&#x09; Open in Eclipse / IntelliJ

&#x09; Import as Maven Project



3️⃣ Configure Database

&#x09;Update `persistence.xml`:

&#x09;	jdbc:mysql://localhost:3306/FlightReservationManagment

&#x09;	Set your MySQL username \& password.



&#x20;4️⃣ Run Project

&#x09; Deploy on Apache Tomcat 10

&#x09; Open : http://localhost:8080/FlightReservation1/





&#x20;**🧠 Key Learnings**

&#x09; 	MVC Architecture Implementation

&#x09; 	Session Management

&#x09; 	Email Integration (SMTP)

&#x09; 	PDF Generation

&#x09; 	Real-world Booking Flow Design



&#x20;**🚀 Future Improvements :**

&#x20;		Payment Gateway Integration

&#x09;	Admin Dashboard

&#x20;		REST API Version

&#x09;	JWT Authentication

&#x09;	Cloud Deployment (AWS)



&#x20;**👨‍💻 Author : Mahesh Lohar**





