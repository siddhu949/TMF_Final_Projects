import { Link } from "react-router-dom";

export const ResCard = (props) => {
  const { info } = props.resObj;

  return (
    <Link to={`/restaurant/${info.id}`} className="card-link">
      <div className="card">
        <img
          className="poster"
          src={
            "https://media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_660/" +
            info.cloudinaryImageId
          }
          height="200"
          width="100"
        />

        <div className="meta">
          <strong>{info.name}</strong>
          <p>{info.locality}</p>
          <p>{info.costForTwo}</p>
          <p>{info.areaName}</p>
          <p>{info.cuisines.join(",")}</p>
        </div>

        <div className="rating">★ {info.avgRating}</div>
      </div>
    </Link>
  );
};
