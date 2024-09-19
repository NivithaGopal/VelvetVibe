<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // Retrieve service details from the request
    String serviceId = request.getParameter("serviceId");
    String serviceName = request.getParameter("serviceName");
    String amountFrom = request.getParameter("amountFrom");
    String amountTo = request.getParameter("amountTo");

    if (serviceId == null || serviceName == null || amountFrom == null || amountTo == null) {
        response.sendRedirect("viewFavourites.jsp?message=Invalid service details");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Booking</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h3 class="text-center">Schedule Booking for <%= serviceName %></h3>
        <div class="card">
            <div class="card-body">
                <form action="confirmBooking.jsp" method="POST">
                    <input type="hidden" name="serviceId" value="<%= serviceId %>">
                    <input type="hidden" name="amountFrom" value="<%= amountFrom %>">
                    <input type="hidden" name="amountTo" value="<%= amountTo %>">
                                        <input type="hidden" name="serviceName" value="<%= amountFrom %>">
                    

                    <div class="form-group">
                        <label for="serviceName">Service Name</label>
                        <input type="text" class="form-control" id="serviceName" value="<%= serviceName %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="amountRange">Amount Range</label>
                        <input type="text" class="form-control" id="amountRange" value="&#x20B9 <%= amountFrom %> - &#x20B9 <%= amountTo %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="appointmentDate">Choose Appointment Date</label>
                        <input type="date" class="form-control" id="appointmentDate" name="appointmentDate" required>
                    </div>

                    <div class="form-group">
                        <label for="appointmentTime">Choose Appointment Time</label>
                        <select class="form-control" id="appointmentTime" name="appointmentTime" required>
                            <!-- Time slots will be dynamically added here -->
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary">Confirm Booking</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Restrict past dates
        window.onload = function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("appointmentDate").setAttribute('min', today);
            populateTimeSlots(); // Populate time slots when page loads
        };

        // Populate time slots from 9:00 AM to 1:00 PM and 2:00 PM to 6:00 PM with 30-minute intervals
        function populateTimeSlots() {
            var timeSelect = document.getElementById("appointmentTime");

            var times = [
                "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM",
                "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM", "05:30 PM", "06:00 PM"
            ];

            times.forEach(function(time) {
                var option = document.createElement("option");
                option.value = time;
                option.text = time;
                timeSelect.appendChild(option);
            });
        }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
