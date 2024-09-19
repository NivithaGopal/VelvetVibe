package dao;

import bean.BookingBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import dbconnection.DBConnection;
import java.sql.*;


public class BookingDAO {

	public int bookAppointment(int serviceId, String serviceName, double amountFrom, double amountTo, java.sql.Date appointmentDate, String appointmentTime, int userId) {
	    int bookingId = 0;  // Initialize bookingId
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet generatedKeys = null;

	    try {
	        // Establish the database connection
	        connection = DBConnection.getConnection();

	        // Prepare the SQL query to insert the booking
	        String sql = "INSERT INTO bookings (servicevv_id, service_name, amount_from, amount_to, appointment_date, appointment_time, customer_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
	        preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	        preparedStatement.setInt(1, serviceId);
	        preparedStatement.setString(2, serviceName);
	        preparedStatement.setDouble(3, amountFrom);
	        preparedStatement.setDouble(4, amountTo);
	        preparedStatement.setDate(5, appointmentDate);
	        preparedStatement.setString(6, appointmentTime);
	        preparedStatement.setInt(7, userId);

	        // Execute the update
	        int rowsAffected = preparedStatement.executeUpdate();
	        if (rowsAffected > 0) {
	            generatedKeys = preparedStatement.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                bookingId = generatedKeys.getInt(1);  // Retrieve the generated booking ID
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // Close the resources
	        if (generatedKeys != null) {
	            try {
	                generatedKeys.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (preparedStatement != null) {
	            try {
	                preparedStatement.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (connection != null) {
	            try {
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return bookingId;  // Return the booking ID
	}


	
	 public boolean updatePaymentStatus(int bookingId, String paymentId) {
	        boolean result = false;
	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        try {
	            // Establish the database connection
	            connection = DBConnection.getConnection();

	            // Prepare the SQL query to update the payment status
	            String sql = "UPDATE bookings SET payment_id = ?, payment_status = 'Completed' WHERE booking_id = ?";
	            preparedStatement = connection.prepareStatement(sql);
	            preparedStatement.setString(1, paymentId);
	            preparedStatement.setInt(2, bookingId);

	            // Execute the update
	            int rowsAffected = preparedStatement.executeUpdate();
	            if (rowsAffected > 0) {
	                result = true;  // Payment status updated successfully
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            // Close the resources
	            if (preparedStatement != null) {
	                try {
	                    preparedStatement.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	            if (connection != null) {
	                try {
	                    connection.close();
	                } catch (SQLException e) {
	                    e.printStackTrace();
	                }
	            }
	        }

	        return result;
	    }
}
