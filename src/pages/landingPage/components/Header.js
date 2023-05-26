//My Files
import NavList from './NavList'
import "./../../../styles/landingPageStyles/index.css"

//Material UI
import { Box } from '@mui/material'

const Header = () => {

    return (
        <Box className="header">
            <Box className="header-wrapper">
                <Box sx={{backgroundColor: "white", borderRadius: "9px"}}>
                    <img src={"/appstore.png"} alt={"Periodic App Icon"} />
                </Box>
                <NavList />
            </Box>
        </Box>
    )
}

export default Header;