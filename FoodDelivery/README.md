🍔 React Food App — README.md
# 🍽️ React Food App  
A simple and fast food ordering UI built with **React.js** that fetches live restaurant data from the **Swiggy Public API**.  
The app includes **search**, **top-rated filter**, and **restaurant menu view** features.

---

## 🚀 Features

### 🔍 Search Restaurants  
Search restaurants by name using a real-time filter.

### ⭐ Top Rated Filter  
Get only the top-rated restaurants (rating > 4).

### 🏪 Restaurant Details  
Click on any restaurant card to view its full menu.

### ⚡ Fast UI  
Uses React functional components and `useState`, `useEffect` for clean and optimized rendering.

---

## 🛠️ Tech Stack

- **React.js (Vite / CRA)**
- **JavaScript (ES6+)**
- **Swiggy API**
- **CSS / Tailwind (optional)**

---

## 📁 Project Structure

```
src/
│── components/
│   ├── Header.jsx
│   ├── Body.jsx
│   ├── ResCard.jsx
│   ├── Shimmer.jsx
│   └── RestaurantMenu.jsx
│
│── utils/
│   ├── swiggyApi.js
│   └── helpers.js
│
└── App.jsx

```


## ⚙️ Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```
### 2️⃣ Install Dependencies
```
npm install
```

### 3️⃣ Start Development Server
```
npm run dev

The app will run at:
👉 http://localhost:5173
```

### 🌐 API Used (Swiggy API)
```
The project fetches data using the Swiggy public API endpoint:
https://www.swiggy.com/dapi/restaurants/list/v5?lat=...&lng=...
```
### Menu API used:
```
https://www.swiggy.com/dapi/menu/pl?page-type=REGULAR_MENU&complete-menu=true&lat=...&lng=...&restaurantId=...
```

## 🧩 Key Components
###🟦 Body.jsx


- Fetches restaurant list


- Stores data in state


- Handles search & filter


- Displays restaurant cards


### 🟩 ResCard.jsx
Shows individual restaurant details like:


- Name


- Image


- Ratings


- Cuisines


- Delivery time


### 🟨 RestaurantMenu.jsx
Fetches and displays menu items for a selected restaurant.
### 🟧 Shimmer UI
Skeleton loading effect when API data is loading.


### 📜 UML Documentation
Included:


✔ Use Case Diagram


✔ Sequence Diagram


✔ Functional Requirements


✔ Overview



### 💡 Future Enhancements


- Add cart functionality


- Add user authentication


- Add live location detection


- Add infinite scrolling


- Add pagination


- Add category filter



### 🤝 Contributing
```
Contributions are welcome!
Fork the repo → Make changes → Open a PR.
```
### 📄 License
```
This project is licensed under the MIT License.
```
### ✨ Author
K Aditya Satya Prakash
📧 [email](aditya94.dev@gmail.com)
💼 [github](github.com/siddhu949)

---

