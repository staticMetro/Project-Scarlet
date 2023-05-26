//Page Sections
import Top from './components/Top'
import Center from './components/Center'
import Testimonials from './components/Testimonials'
import Info from './components/Info'
import Footer from './components/Footer';

//Material UI
import { Box } from '@mui/material';


const FrontPage = () => {
    return (
        <Box>
            <Top />
            <Center />
            <Info />
            <Testimonials/>
            <Footer />
        </Box>
    )
}

export default FrontPage;