import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { dummyMenu } from "../util";
import MenuShimmer from "./Shimmer"; // ✅ import your shimmer component

const RestaurantMenu = () => {
  const { id } = useParams();
  const [menuData, setMenuData] = useState(null);

  // Simulate loading delay
  useEffect(() => {
    const timer = setTimeout(() => {
      setMenuData(dummyMenu);
    }, 1500); // 1.5s shimmer effect
    return () => clearTimeout(timer);
  }, [id]);

  if (!menuData) return <MenuShimmer />; // 🔥 show shimmer while loading

  const restaurantInfo = menuData?.data?.cards[0]?.card?.card?.info;

  const itemCards =
    menuData?.data?.cards[1]?.groupofcards?.cardGroupMap?.REGULAR?.cards[0]
      ?.card?.card?.itemCards || [];

  return (
    <div style={{ padding: "20px" }}>
      <h1>{restaurantInfo?.name}</h1>
      <p>
        {restaurantInfo?.cuisines?.join(", ")} • {restaurantInfo?.costForTwoMessage}
      </p>

      <h2>Menu</h2>
      <ul>
        {itemCards.map((item) => (
          <li key={item.card.info.id} style={{ margin: "10px 0" }}>
            <strong>{item.card.info.name}</strong> - ₹{item.card.info.price / 100}
            <br />
            <small>{item.card.info.description}</small>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default RestaurantMenu;
