# Flutter App with Node.js Authentication

## Overview

This repository contains a Flutter mobile application integrated with a Node.js backend for user authentication. The backend uses Express.js, MongoDB for data storage, JWT for token-based authentication, and Bcrypt for password hashing. The Flutter application uses Provider for state management.

## Table of Contents

- [Features](#features)
- [Technologies](#technologies)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Backend Setup](#backend-setup)
  - [Frontend Setup](#frontend-setup)
- [Usage](#usage)


## Features

- User registration and login
- Secure password storage with Bcrypt
- JWT-based authentication
- State management with Provider in Flutter
- RESTful API using Express.js and MongoDB

## Technologies

### Backend

- Node.js
- Express.js
- MongoDB
- Mongoose
- JWT (JsonWebToken)
- Bcrypt

### Frontend

- Flutter
- Provider for state management

## Prerequisites

- Node.js and npm installed
- Flutter SDK installed
- MongoDB installed and running

## Getting Started

### Backend Setup

1. Clone the repository and navigate to the backend directory:

    ```bash
    git clone https://github.com/0CyberGhost0/flutterNodeAuth.git
    cd server
    ```

2. Install the necessary packages:

    ```bash
    npm install express mongoose cors bcryptjs jsonwebtoken
    ```

3. Create a `.env` file in the backend directory and add the following environment variables:

    ```env
    PORT=5000
    MONGO_URI=mongodb://localhost:27017/your-db-name
    JWT_SECRET=your_jwt_secret
    ```

4. Start the backend server:

    ```bash
    node index.js
    ```

    The backend server should now be running on `http://localhost:5000`.

### Frontend Setup

1. Navigate to the frontend directory:

    ```bash
    cd ../lib
    ```

2. Install the necessary Flutter packages:

    ```bash
    flutter pub get shared_preference http 
    ```

3. Update the API endpoint in the Flutter app to match your backend server URL. This is typically done in a service or API class where HTTP requests are made.

4. Run the Flutter app:

    ```bash
    flutter run
    ```

## Usage

1. Open the Flutter app on your device or emulator.
2. Register a new user account.
3. Log in with the registered account.
4. Explore the authenticated sections of the app.



