import AppIcon from "./AppIcon";
import { TitleComponenet,TitleTagLine } from "./TittleTagline";
const Header = () => {
  return (
    <div className="header">
      <div className="brand">
        <div>
          <AppIcon />
        </div>
        <div>
          <TitleComponenet />
          <TitleTagLine />
        </div>
      </div>
    </div>
  );
};
export default Header;