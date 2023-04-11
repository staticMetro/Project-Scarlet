//My Files
import NavList from './NavList'
import "./../../../styles/landingPageStyles/index.css"

//Material UI
import { Box } from '@mui/material'

const Header = () => {

    return (
        <Box className="header">
            <Box className="header-wrapper">
                <img src={"/appstore.png"} alt={"Periodic App Icon"}/>
                <NavList/>
            </Box>
        </Box>
    )
}

export default Header;