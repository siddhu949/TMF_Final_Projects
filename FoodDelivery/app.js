// import React from "react";
// import { createRoot } from "react-dom/client";
// import Body from "./components/Body";
// import Header from "./components/Header";
// import { Footer } from "./components/Footer";
// // import UserPage from "./components/userPage";

// var reactElement = document.getElementById("root");
// var reactRoot = createRoot(reactElement);



// const App = () => {
//   return (
//     <>
//       <Header />
//       <Body />
//       <Footer />
//       {/* <UserPage/> */}
//     </>
//   );
// };




// // const styleObj = { color: "red" };
// // const Body = () => {
// //   return (
// //     <div style={styleObj}>
// //       <h1>Body Componenet</h1>
// //     </div>
// //   );
// // };

// const moviesArr = [
//   {
//     id: "1",
//     imgUrl:
//       "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//     title: "Inglourious Basterds",
//     genere: "Action",
//     duration: "2h 19m",
//     language: "English",
//     cast: ["Brad", "Quint", "Cristy"],
//     avgRating: 9.0,
//   },
//   {
//     id: "2",
//     imgUrl:
//       "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//     title: "Fight Club",
//     genere: "Action",
//     duration: "2h 00m",
//     language: "English",
//     cast: ["Manu", "Tom", "Cruse"],
//     avgRating: 9.0,
//   },
//   {
//     id: "3",
//     imgUrl:
//       "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//     title: "The Texas Chain Saw Massacre",
//     genere: "Thriller",
//     duration: "1h 19m",
//     language: "English",
//     cast: ["Jin", "Vinny", "Ram"],
//     avgRating: 9.0,
//   },
//   {
//     id: "4",
//     imgUrl:
//       "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//     title: "Django Unchained",
//     genere: "Horror",
//     duration: "3h 19m",
//     language: "English",
//     cast: ["Lee", "Dawn", "Sat"],
//     avgRating: 9.0,
//   },
//   {
//     id: "5",
//     imgUrl:
//       "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//     title: "Django Unchained",
//     genere: "Horror",
//     duration: "3h 19m",
//     language: "English",
//     cast: ["Lee", "Dawn", "Sat"],
//     avgRating: 9.0,
//   },
//   {
//     id: "6",
//     imgUrl:
//       "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//     title: "Django Unchained",
//     genere: "Horror",
//     duration: "3h 19m",
//     language: "English",
//     cast: ["Lee", "Dawn", "Sat"],
//     avgRating: 9.0,
//   },
// ];
// const movie1 = {
//   imgUrl:
//     "https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
//   title: "Inglourious Basterds",
//   genere: "Drama",
//   duration: "2h 56m",
//   language: "English",
//   cast: ["Brad", "Quint", "Cristy"],
//   avgRating: 9.0,
// };

// const MovieCard = (props) => {
//   console.log(props);
//   return (
//     <div className="card">
//       <img
//         className="poster"
//         src="https://m.media-amazon.com/images/M/MV5BODZhMWJlNjYtNDExNC00MTIzLTllM2ItOGQ2NGVjNDQ3MzkzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"
//         height="200"
//         width="100"
//       />
//       <div className="meta">
//         <strong>{props.movieObj.title}</strong>
//         <p>{props.movieObj.genere}</p>
//         <p>{props.movieObj.duration}</p>
//         <p>{props.movieObj.language}</p>
//         <p>{props.movieObj.cast.join(",")}</p>
//       </div>
//       <div className="rating">★ {movie1.avgRating}</div>
//     </div>
//   );
// };


// //PROPS




// reactRoot.render(<App />);
import React from "react";
import { createRoot } from "react-dom/client";

// 🔥 ADDED React Router
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Body from "./components/Body";
import Header from "./components/Header";
import { Footer } from "./components/Footer";
import RestaurantMenu from "./components/RestaurantMenu"; // ⭐ ADD THIS

var reactElement = document.getElementById("root");
var reactRoot = createRoot(reactElement);

const App = () => {
  return (
    <>
      <BrowserRouter>
        <Header />

        <Routes>
          {/* Home Page */}
          <Route path="/" element={<Body />} />

          {/* Restaurant Menu Page */}
          <Route path="/restaurant/:id" element={<RestaurantMenu />} />
        </Routes>

        <Footer />
      </BrowserRouter>
    </>
  );
};

reactRoot.render(<App />);
