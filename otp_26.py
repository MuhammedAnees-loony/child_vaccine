
from flask import Flask, request, jsonify
import mysql.connector
import random
import time
from flask_cors import CORS  # To allow cross-origin requests from Flutter

app = Flask(__name__)
CORS(app)  # Enable CORS to allow requests from your Flutter app

# Configure MySQL connection
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '200515',  # Change this to your MySQL root password
    'database': 'cipher'  # Change this to your database name
}

# Establish database connection
def get_db_connection():
    return mysql.connector.connect(**db_config)

# Function to generate a 6-digit OTP
def generate_otp():
    otp = random.randint(100000, 999999)
    return otp

# Store OTPs temporarily (for example purposes, in-memory storage)
otp_store = {}

# Login endpoint
@app.route('/login', methods=['POST'])
def login():
    try:
        data = request.json
        print(f"Received data for login: {data}")  # Log incoming data

        username = data.get('username')
        password = data.get('password')

        # Check if username and password are provided
        if not username or not password:
            return jsonify({'success': False, 'message': 'Missing username or password'}), 400

        # Query the database to check credentials
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM credentials WHERE username = %s AND password = %s"
        cursor.execute(query, (username, password))
        user = cursor.fetchone()

        # Close the connection
        cursor.close()
        conn.close()

        # Check if user is found
        if user:
            print(f"Login successful for user: {username}")  # Log successful login
            return jsonify({'success': True, 'message': 'Login successful', 'user': user}), 200
        else:
            print(f"Invalid login attempt for user: {username}")  # Log invalid login
            return jsonify({'success': False, 'message': 'Invalid username or password'}), 401

    except Exception as e:
        print(f"Error during login: {str(e)}")  # Log errors
        return jsonify({'success': False, 'message': f'An error occurred: {str(e)}'}), 500

# Registration endpoint
@app.route('/register', methods=['POST'])
def register():
    try:
        data = request.json
        print(f"Received registration data: {data}")  # Log incoming data for registration

        # Extract registration details
        first_name = data.get('first_name')
        last_name = data.get('last_name')
        address = data.get('address')
        pincode = data.get('pincode')
        village = data.get('village')
        occupation = data.get('occupation')
        married = data.get('married')
        phone_number = data.get('phone_number')
        dob = data.get('dob')
        country = data.get('country')
        state = data.get('state')
        district = data.get('district')
        sex = data.get('sex')
        username = data.get('username')  
        password = data.get('password')
        # Validate required fields
        if not all([first_name, last_name, phone_number, dob, country, state, district, sex,username, password]):
            return jsonify({'success': False, 'message': 'Missing required fields'}), 400

        # Insert the data into the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # Define the SQL query to insert the data into the "users" table
        query = '''
            INSERT INTO users (first_name, last_name, address, pincode, village, occupation, married, 
                               phone_number, dob, country, state, district, sex) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        '''
        cursor.execute(query, (first_name, last_name, address, pincode, village, occupation, married, 
                               phone_number, dob, country, state, district, sex))
        
        # Insert username and hashed password into the "credentials" table
        cred_query = '''
            INSERT INTO credentials (username, password)
            VALUES (%s, %s)
        '''
        cursor.execute(cred_query, (username, password))

        conn.commit()

        # Close the connection
        cursor.close()
        conn.close()

        print(f"Registration successful for user: {first_name} {last_name}")  # Log successful registration
        return jsonify({'success': True, 'message': 'User registered successfully'}), 201

    except Exception as e:
        print(f"Error during registration: {str(e)}")  # Log errors
        return jsonify({'success': False, 'message': f'An error occurred: {str(e)}'}), 500

# Route to generate and return an OTP
@app.route('/generate-otp', methods=['POST'])
def generate_otp_route():
    data = request.json
    print(f"Received data for OTP generation: {data}")  # Log incoming data for OTP generation

    phone_number = data.get('phone_number')

    if not phone_number:
        return jsonify({"error": "Phone number is required!"}), 400

    # Generate OTP
    otp = generate_otp()

    # Store OTP with a timestamp (for expiration handling)
    otp_store[phone_number] = {'otp': otp, 'timestamp': time.time()}

    # In a real scenario, send the OTP via SMS service like Twilio or an email service.
    print(f"Generated OTP for {phone_number}: {otp}")  # For testing purposes

    return jsonify({"otp": otp, "message": f"OTP generated for phone number {phone_number}"}), 200

# Route to clear the OTP after verification (optional)
@app.route('/clear-otp', methods=['POST'])
def clear_otp_route():
    data = request.json
    print(f"Received request to clear OTP: {data}")  # Log incoming request to clear OTP

    phone_number = data.get('phone_number')

    if phone_number in otp_store:
        del otp_store[phone_number]
        print(f"OTP cleared for phone number: {phone_number}")  # Log successful OTP clearance
        return jsonify({"message": "OTP cleared."}), 200
    
    print(f"No OTP found for phone number: {phone_number}")  # Log no OTP found
    return jsonify({"error": "No OTP found for this phone number."}), 404


if __name__ == '__main__':
    app.run(debug=True)
