
import { BrowserRouter, Routes, Route } from 'react-router-dom';

//pages
import FrontPage from './pages/landingPage/FrontPage'

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<FrontPage />} />
            </Routes>
        </BrowserRouter>
    );
}

export default App;
