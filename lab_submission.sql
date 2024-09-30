-- CREATE EVN_average_customer_waiting_time_every_1_hour

-- Create a scheduled event that runs every 1 hour
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
-- Insert the current timestamp and the calculated average waiting time into the customer_service_kpi table
INSERT INTO customer_service_kpi (customer_service_KPI_timestamp, customer_service_KPI_average_waiting_time_minutes)
SELECT 
    NOW(), -- Insert current timestamp
    IFNULL(AVG(TIMESTAMPDIFF(MINUTE, ticket_created_time, ticket_resolved_time)), 0) -- Insert average waiting time, default to 0 if no tickets
FROM 
    customer_service_ticket
-- Only consider tickets created in the last 1 hour
WHERE 
    ticket_created_time >= NOW() - INTERVAL 1 HOUR;

