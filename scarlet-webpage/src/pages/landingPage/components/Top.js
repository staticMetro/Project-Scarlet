import "./../../../styles/landingPageStyles/Top.css"
import Header from "./Header";
import { Button, Box } from '@mui/material';
import { Link as RouterLink } from "react-router-dom";
const Top = () => {

    return (
        <Box className="top-container">
            <Header />
            <Box className="top-text">
                <h1>Project Scarlet</h1>
                <p>Trusted by millions of women. Scarlet
                    is the tool that helps you keep track and know
                    everything about your cycle day by day.
                </p>
                <Button sx={{
                    "&.MuiButton-root": {
                        padding: "0px"
                    }
                }} component={RouterLink} to={"https://www.apple.com/app-store/"}>
                    <img src={"https://tools.applemediaservices.com/api/badges/download-on-the-app-store/black/en-us?size=250x83&amp;releaseDate=1276560000&h=7e7b68fad19738b5649a1bfb78ff46e9"} alt={"Apple Store Button"} />
                </Button>

            </Box>
        </Box>)
}

export default Top;