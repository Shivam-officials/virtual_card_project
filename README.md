
# virtual_card_project

# Contact Manager App

This Flutter app demonstrates CRUD (Create, Read, Update, Delete) operations using the **sqflite** plugin. It also integrates Google ML Kit for text extraction, providing a seamless experience for managing contact information from visiting cards.

## Features
✅ **Home Screen**
- Bottom Navigation Bar with:
  - **All Contacts** tab
  - **Favourites** tab
- Each contact has its own **Contact Details Page** with:
  - **Call**, **Email**, **Map**, and **SMS** actions (using `url_launcher`)
  - Displays the contact’s visiting card image and details

✅ **Scan Page**
- Accessible via the Floating Action Button (FAB) in the center
- Supports image loading from:
  - **Gallery**
  - **Camera**
- Uses **Google ML Kit** for text extraction
- Includes **Drag and Drop** functionality to assign extracted text to the correct fields

✅ **Form Page**
- Allows users to edit contact information if data is incorrectly extracted
- Enables saving contact details to a permanent database using **sqflite**

✅ **Database Management**
- All contact details are stored securely using **sqflite**
- Supports CRUD operations efficiently

## Tech Stack
- **Flutter**
- **sqflite** (Database)
- **Provider** (State Management)
- **flutter_easyloading** (Loading Indicators)
- **google_mlkit_text_recognition** (Text Extraction)
- **image_picker** (Image Selection)
- **go_router** (Navigation)
- **url_launcher** (Handling External Links)

## Screenshots
<p align="center">
  <img src="https://github.com/user-attachments/assets/2f533ad0-8b57-46b7-945d-5312c847be26" width="250" />
  <img src="https://github.com/user-attachments/assets/cbb77123-96e0-4dbb-977e-c2386bb4a94a" width="250" />
  <img src="https://github.com/user-attachments/assets/9fb80662-a0c6-4e2b-8ad8-f86124a09514" width="250" />
  <img src="https://github.com/user-attachments/assets/a425c187-89d9-488e-9176-7bf3500257f7" width="250" />
  <img src="https://github.com/user-attachments/assets/056fd975-502c-438a-ba2a-faf9dadac92a" width="250" />
</p>


---

Feel free to contribute or provide suggestions for enhancing this project!

