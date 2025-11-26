import { useState, useEffect } from "react";
import { ResCard } from "./ResCard";
import Shimmer from "./Shimmer";

const Body = () => {
  const [restaurants, setRestaurants] = useState([]);
  const [allRestaurants, setAllRestaurants] = useState([]);
  const [searchText, setSearchText] = useState("");

  const baseURL =
    "https://www.swiggy.com/dapi/restaurants/list/v5?lat=17.385044&lng=78.486671&is-seo-homepage-enabled=true&page_type=DESKTOP_WEB_LISTING";

  const fetchData = async () => {
    try {
      const res = await fetch(baseURL);
      const data = await res.json();

      const restaurantsData =
        data?.data?.cards[1]?.card?.card?.gridElements?.infoWithStyle
          ?.restaurants || [];

      setAllRestaurants(restaurantsData);
      setRestaurants(restaurantsData);
    } catch (err) {
      console.error("Error fetching:", err);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  useEffect(() => {
    if (searchText.trim() === "") {
      setRestaurants(allRestaurants);
    } else {
      const filtered = allRestaurants.filter((res) =>
        res.info.name.toLowerCase().includes(searchText.toLowerCase())
      );
      setRestaurants(filtered);
    }
  }, [searchText, allRestaurants]);

  // ⭐ Top Rated Filter
  const filterTopRated = () => {
    const top = allRestaurants.filter((res) => res.info.avgRating > 4.3);
    setRestaurants(top);
  };

  return (
    <>
      <div className="top-bar">
        <input
          className="search-input"
          type="text"
          placeholder="Search restaurants..."
          value={searchText}
          onChange={(e) => setSearchText(e.target.value)}
        />

        <button className="top-btn" onClick={filterTopRated}>
          ⭐ Top Rated
        </button>

        <button className="reset-btn" onClick={() => setRestaurants(allRestaurants)}>
          Reset
        </button>
      </div>

      {restaurants.length === 0 ? (
        <Shimmer />
      ) : (
        <div className="movies-grid">
          {restaurants.map((res) => (
            <ResCard key={res.info.id} resObj={res} />
          ))}
        </div>
      )}
    </>
  );
};

export default Body;
