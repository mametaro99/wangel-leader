import { red } from '@mui/material/colors';
import { createTheme } from '@mui/material/styles';

// Create a theme instance.
const theme = createTheme({
  palette: {
    primary: {
      main: '#008000', // 緑色
    },
    secondary: {
      main: '#A52A2A', // 茶色
    },
    error: {
      main: red.A400,
    },
  },
})

export default theme
