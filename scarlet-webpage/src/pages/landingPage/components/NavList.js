
import { List, ListItemText, ListItem, ListItemButton } from '@mui/material';
import { Link as RouterLink } from 'react-router-dom';
const NavList = () => {

    const Item = ({ text, to, selected }) => {
        return (
            <ListItem key={text}
                selected={selected === text}
                disablePadding sx={{
                    borderRadius: "5px",
                    "&.MuiListItem-root": {
                        ":hover": {
                            backgroundColor: "rgba(0,0,0,0.5)",
                            color: "white",
                            transition: "background-color 500ms linear"
                        }
                    }
                }}>
                <ListItemButton component={RouterLink} to={to}>
                    <ListItemText sx={{ whiteSpace: "nowrap" }}>
                        {text}
                    </ListItemText>
                </ListItemButton>
            </ListItem>)
    }

    return (
        <nav>
            <List sx={{ display: "flex" }}>
                <Item text={"Home"} to={"/"} />
                <Item text={"Stories"} to={"/stories"} />
                <Item text={"About Scarlet"} to={"/about-scarlet"} />
                <Item text={"Contact Us"} to={"/contact-us"} />
            </List>
        </nav>
        )
}

export default NavList;