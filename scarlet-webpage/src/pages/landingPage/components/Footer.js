//My Files
import "./../../../styles/landingPageStyles/index.css"
import NavList from './NavList'

//Material UI
import { Box } from '@mui/material';

function Footer() {
    return (
        <Box className="footer">
            <Box className="footer-wrapper">
                <NavList />
                <Box sx={{whiteSpace: "nowrap"}}>
                    <Box component="span">
                        {`Terms and Conditions | `}
                    </Box>
                    <Box component="span">
                        {`Privacy Policy | `}
                    </Box>
                    <Box component="span">
                        All Rights Reserved &copy;2023 Periodic App
                    </Box>
                    </Box>
            </Box>
        </Box>
    )
}

export default Footer;