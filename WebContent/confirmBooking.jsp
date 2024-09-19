
 
 <%@ page import="dao.BookingDAO, java.text.SimpleDateFormat, java.util.Date, java.sql.*, bean.UserRegistration, dao.UserRegistrationDAO" %>
<%
    // Retrieve service details from the request
    String serviceId = request.getParameter("serviceId");
    String serviceName = request.getParameter("serviceName");
    String amountFrom = request.getParameter("amountFrom");
    String amountTo = request.getParameter("amountTo");
    String appointmentDate = request.getParameter("appointmentDate");
    String appointmentTime = request.getParameter("appointmentTime");

    // Debugging output
    System.out.println("serviceId: " + serviceId);
    System.out.println("serviceName: " + serviceName);
    System.out.println("amountFrom: " + amountFrom);
    System.out.println("amountTo: " + amountTo);
    System.out.println("appointmentDate: " + appointmentDate);
    System.out.println("appointmentTime: " + appointmentTime);

    if (serviceId == null || serviceName == null || amountFrom == null || amountTo == null || appointmentDate == null || appointmentTime == null) {
        response.sendRedirect("viewFavourites.jsp?message=Invalid service details");
        return;
    }

    HttpSession httpsession = request.getSession(false);
    String email = null;

    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserRegistrationDAO userDAO = new UserRegistrationDAO();
    UserRegistration user = userDAO.getUserByEmail(email);
    int userId = user.getUser_id();

    // Convert appointmentDate from String to java.sql.Date
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    java.sql.Date sqlAppointmentDate = null;
    try {
        java.util.Date parsedDate = dateFormat.parse(appointmentDate);
        sqlAppointmentDate = new java.sql.Date(parsedDate.getTime());
    } catch (Exception e) {
        response.sendRedirect("bookNow.jsp?message=Invalid date format");
        return;
    }

    // Calculate advance amount (25% of the average of the amount range)
    double amountFromDouble = Double.parseDouble(amountFrom);
    double amountToDouble = Double.parseDouble(amountTo);
    double advanceAmount = 0.25 * ((amountFromDouble + amountToDouble) / 2); // Average of the range

    // Book the appointment using BookingDAO
    BookingDAO bookingDAO = new BookingDAO();
    
    int bookingId = bookingDAO.bookAppointment(
        Integer.parseInt(serviceId),  // serviceId
        serviceName,                   // serviceName
        amountFromDouble,              // amountFrom
        amountToDouble,                // amountTo
        sqlAppointmentDate,            // appointmentDate
        appointmentTime,               // appointmentTime
        userId                         // userId
    );

    if (bookingId > 0) {
        response.sendRedirect("payment.jsp?amount=" + advanceAmount + "&bookingId=" + bookingId);
    } else {
        response.sendRedirect("bookNow.jsp?message=Failed to book appointment");
    }
%>
 