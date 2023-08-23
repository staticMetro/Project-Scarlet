//My Files
import "./../../../styles/landingPageStyles/index.css"
import NavList from './NavList'

//Material UI
import { Box } from '@mui/material';

//React Files
import { Link as RouterLink } from 'react-router-dom'

function Footer() {
    return (
        <Box className="footer">
            <Box className="footer-wrapper">
                <NavList />
                <Box sx={{ whiteSpace: "nowrap" }}>
                    <RouterLink to={"/TermsAndConditions"}>
                        <Box component="span">
                            {`Terms and Conditions | `}
                        </Box>
                    </RouterLink>
                    <RouterLink to={"/PrivacyPolicy"}>
                        <Box component="span">
                            {`Privacy Policy | `}
                        </Box>
                    </RouterLink>
                    <RouterLink to={"/Copyright"}>
                        <Box component="span">
                            All Rights Reserved &copy;2023 Periodic App
                        </Box>
                    </RouterLink>
                </Box>
            </Box>
        </Box>
    )
}

export default Footer;