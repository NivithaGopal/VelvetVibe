package bean;

import java.sql.Timestamp;

public class BookingBean {
    private int booking_id;
    private int user_id;
    private int servicevv_id;
    private Timestamp appointment_timestamp;

    // Constructors
    public BookingBean() {}

    public BookingBean(int user_id, int servicevv_id, Timestamp appointment_timestamp) {
        this.user_id = user_id;
        this.servicevv_id = servicevv_id;
        this.appointment_timestamp = appointment_timestamp;
    }

    // Getters and Setters
    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getServicevv_id() {
        return servicevv_id;
    }

    public void setServicevv_id(int servicevv_id) {
        this.servicevv_id = servicevv_id;
    }

    public Timestamp getAppointment_timestamp() {
        return appointment_timestamp;
    }

    public void setAppointment_timestamp(Timestamp appointment_timestamp) {
        this.appointment_timestamp = appointment_timestamp;
    }

    @Override
    public String toString() {
        return "BookingBean [booking_id=" + booking_id + ", user_id=" + user_id + ", servicevv_id=" + servicevv_id
                + ", appointment_timestamp=" + appointment_timestamp + "]";
    }
}
