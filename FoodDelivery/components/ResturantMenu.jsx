import { useEffect, useState } from "react";
import { MenuShimmer } from "./Shimmer";

function RestaurantMenu() {
  const { id } = useParams();
  const [menuData, setMenuData] = useState([]);

  const mainId = id.split("-").at(-1);

  async function fetchMenu() {
    try {
      let data = await fetch(
        `${import.meta.env.VITE_BASE_URL}/menu/pl?page-type=REGULAR_MENU&complete-menu=true&lat=17.385044&lng=78.486671&restaurantId=${mainId.split("rest")[1]}`
      );

      let res = await data.json();

      let actualMenu = res?.data?.cards.find((d) => d?.groupedCard);

      setMenuData(
        actualMenu?.groupedCard?.cardGroupMap?.REGULAR?.cards.filter(
          (d) => d?.card?.card?.itemCards || d?.card?.card?.categories
        )
      );
    } catch (err) {
      console.error(err);
    }
  }

  useEffect(() => {
    fetchMenu();
  }, []);

  return (
    <div className="w-full md:w-[700px] mx-auto mt-10 p-4">
      <h1 className="text-2xl font-bold text-center mb-5">MENU</h1>

      {!menuData.length ? (
        <MenuShimmer />
      ) : (
        <div>
          {menuData.map(({ card: { card } }, i) => (
            <SimpleMenuCard card={card} key={i} />
          ))}
        </div>
      )}
    </div>
  );
}

function SimpleMenuCard({ card }) {
  if (card.itemCards) {
    return (
      <div className="mb-8">
        <h2 className="text-xl font-semibold mb-2">
          {card.title} ({card.itemCards.length})
        </h2>

        <div className="ml-3">
          {card.itemCards.map(({ card: { info } }) => (
            <p key={info.id} className="py-1 text-gray-700">
              • {info.name}
            </p>
          ))}
        </div>

        <hr className="my-4" />
      </div>
    );
  } else {
    return (
      <div className="mb-5">
        <h2 className="text-xl font-semibold mb-2">{card.title}</h2>
        {card.categories?.map((sub, i) => (
          <SimpleMenuCard key={i} card={sub} />
        ))}
      </div>
    );
  }
}

export default RestaurantMenu;
