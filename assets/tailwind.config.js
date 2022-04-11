const colors = require('tailwindcss/colors')
// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    colors: {
      // theme default
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.gray,
      green: colors.green,
      blue: colors.blue,
      emerald: colors.emerald,
      indigo: colors.indigo,
      yellow: colors.yellow,


      "primary"         : "",    
      "primary-hover"   : "",    
    
      "secondary"       : "",    
      "secondary-hover" : "",
      
      "success"         : "",
      "warning"         : "",
      "danger"         : "",
      "info"         : "",
      "debug"         : "",
    },
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
