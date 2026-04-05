# Mini E-Commerce App (Flutter)

## Overview
This is a simple e-commerce mobile/web application built using Flutter.  
It includes authentication, product listing, cart functionality, and order submission.

## Features
- Login & Register screens
- Local authentication with token storage (SharedPreferences)
- Product listing fetched from a real mock API (DummyJSON)
- Display product name, price, and stock status
- Add/remove items from cart
- Cart badge showing number of items
- Order form with validation (phone & address)
- Order confirmation screen

## Tech Stack
- Flutter
- Dio (API calls)
- Provider (State Management)
- SharedPreferences (Local Storage)

## Setup Instructions
1. Clone the repository
2. Run:
   flutter pub get
3. Run the app:
   flutter run -d edge --web-port 8080

## Demo Video
Watch the app demo here:
[Video Demo] https://drive.google.com/file/d/1q-22g4NyL1OHCaJq_NTjq2aFX1OtEMAG/view?usp=sharing

## Notes
- Authentication is simulated locally (no backend provided)
- Order submission is simulated locally
- Products are fetched from DummyJSON API