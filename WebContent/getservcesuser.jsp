<%@page import="dao.UserRegistrationDAO"%>
<%@page import="bean.UserRegistration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="dao.ServiceVelvetvibeDAO"%>
<%@ page import="bean.addServiceBean"%>
<%@ page import="bean.ServiceVelvetvibeBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.IOException"%>
<%@ page import="bean.UserProfileBean"%>
<%@ page import="dao.UserProfileDAO"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Service Details</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body {
        background-color: #f5f5f5;
        font-family: 'Arial', sans-serif;
        color: #333;
        padding-top: 5rem;
    }

    .card {
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        border: none;
        overflow: hidden;
        background: #f8f9fa;
        margin-bottom: 20px;
    }

    .card-header {
        background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
        color: #fff;
        text-align: center;
        padding: 20px;
        font-size: 1.5rem;
        font-weight: bold;
    }

    .img-thumbnail {
        width: 100%; /* Makes the image fill the width of its container */
        height: 100%; /* Sets a common height */
        object-fit: cover; /* Ensures the image covers the container without distortion */
        margin-bottom: 15px;
    }

    .btn-success {
        border-radius: 30px;
        padding: 10px 20px;
        font-size: 1.2rem;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        color: #fff;
        background-color: #343a40;
        border-color: #343a40;
    }

    .btn-success:hover {
        background-color: #495057;
        border-color: #495057;
    }

    .alert {
        border-radius: 10px;
    }

    h3 {
        font-size: 2rem;
        font-weight: bold;
        color: #212529;
        text-align: center;
        margin-bottom: 2rem;
    }

    .text-center {
        text-align: center;
    }

    .btn-container {
        display: flex;
        justify-content: space-between;
        margin-top: 1rem;
    }

    .btn-container .btn {
        border-radius: 30px;
        padding: 10px 20px;
        font-size: 1.2rem;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: all 0.3s ease;
    }
    h3 {
	font-size: 2rem;
	font-weight: bold;
	color: #212529;
	text-align: center;
}
    
</style>

</head>
<body>

<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    // Retrieve the email from the session
    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    // Redirect to login if session does not exist or email is not found
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

%>
<%
UserRegistrationDAO userDAO=new UserRegistrationDAO();
UserRegistration user = userDAO.getUserByEmail(email);

if (user != null) {
    out.println("User ID: " + user.getUser_id()); // Debug print
} else {
    response.sendRedirect("login.jsp?message=User not found");
    return;
}
%>

    <div class="container">
        <%
            String serviceIdStr = request.getParameter("serviceId");

            if (serviceIdStr != null) {
                try {
                    int serviceId = Integer.parseInt(serviceIdStr);

                    // Fetch the service details from ServiceDAO
                    ServiceDAO serviceDao = new ServiceDAO();
                    addServiceBean service = serviceDao.getServiceById(serviceId);

                    if (service != null) {
                        String serviceName = service.getServiceName(); // Fetching the service name
        %>
		 <h3>VELVETVIBE</h3>
        <h4 class="text-center">Service Details: <%= serviceName %></h4><br>

        <%
                        if (serviceName != null && !serviceName.isEmpty()) {
                            // Fetch details from ServiceVelvetvibeDAO using serviceId and serviceName
                            ServiceVelvetvibeDAO velvetvibeDao = new ServiceVelvetvibeDAO();
                            List<ServiceVelvetvibeBean> services = velvetvibeDao.getServiceByIdAndName(serviceId, serviceName);

                            if (services != null && !services.isEmpty()) {
                                for (ServiceVelvetvibeBean velvetService : services) {
        %>

        <div class="card service-card">
            <div class="card-header">
                <%= velvetService.getCategoryName() %>
            </div>
            <div class="card-body">
                <p><strong>Description:</strong> <%= velvetService.getDescription() %></p>
                <p><strong>Amount From:</strong> &#x20B9 <%= velvetService.getAmount_from() %></p>
                <p><strong>Amount To:</strong> &#x20B9 <%= velvetService.getAmount_to() %></p>

                <div class="row">
                    <div class="col-md-4">
                        <img src="<%= velvetService.getImage1() %>" class="img-thumbnail" alt="Service Image 1">
                    </div>
                    <div class="col-md-4">
                        <img src="<%= velvetService.getImage2() %>" class="img-thumbnail" alt="Service Image 2">
                    </div>
                    <div class="col-md-4">
                        <img src="<%= velvetService.getImage3() %>" class="img-thumbnail" alt="Service Image 3">
                    </div>
                </div>

                <div class="btn-container">
  <form action="addToFav.jsp" method="post">
    <input type="hidden" name="userId" value="<%= user.getUser_id() %>">
    <input type="hidden" name="servicevvId" value="<%= velvetService.getServicevv_id() %>">
    <button type="submit" class="btn btn-success">
        Add to Favourite
    </button>
</form>
  
                   
                    <button class="btn btn-success" id="bookNowButton<%= velvetService.getCategoryName() %>">Book Now</button>
                </div>
            </div>
        </div>

        <%
                                }
                            } else {
        %>
        <div class="alert alert-warning" role="alert">No service found in ServiceVelvetvibeDAO for the given ID and name.</div>
        <%
                            }
                        } else {
        %>
        <div class="alert alert-danger" role="alert">Service Name not provided for ServiceVelvetvibeDAO lookup.</div>
        <%
                        }
                    } else {
        %>
        <div class="alert alert-danger" role="alert">No service found in ServiceDAO for the given ID.</div>
        <%
                    }
                } catch (NumberFormatException e) {
        %>
        <div class="alert alert-danger" role="alert">Invalid service ID format.</div>
        <%
                } catch (Exception e) {
        %>
        <div class="alert alert-danger" role="alert">Error retrieving service details: <%= e.getMessage() %></div>
        <%
                }
            } else {
        %>
        <div class="alert alert-danger" role="alert">No service ID provided.</div>
        <%
            }
        %>
    </div>

   
    
   
<script>

</script>

</body>
</html>
