import { Button, Box, List, ListItemText, ListItem, ListItemButton, Typography } from '@mui/material';
import { Link as RouterLink} from 'react-router-dom';
const Header = () => {

    const Item = ({ text, to, selected }) => {
        console.log(text);
        return (
            <ListItem key={text}
                selected={selected === text}
                disablePadding sx={{borderRadius: "5px",
                    "&.MuiListItem-root": {
                        ":hover": {
                            backgroundColor: "rgba(0,0,0,0.5)",
                            color: "white",
                            transition: "background-color 500ms linear"
                        }
                    }}}>
                <ListItemButton component={RouterLink} to={to}>
                    <ListItemText sx={{whiteSpace: "nowrap"}}>
                        {text}
                    </ListItemText>
                </ListItemButton>
            </ListItem>)
    }

    return (
        <Box className="header">
            <Box className="header-wrapper" sx={{display: "flex", justifyContent: "right"}}>
                <nav>
                    <List sx={{display: "flex"}}>
                        <Item text={"Home"} to={"/"}/>
                        <Item text={"Stories"} to={"/stories"}/>
                        <Item text={"About Scarlet"} to={"/about-scarlet"}/>
                        <Item text={"Contact Us"} to={"/contact-us"}/>
                    </List>
                </nav>
            </Box>
        </Box>
    )
}

export default Header;