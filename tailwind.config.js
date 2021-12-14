const colors = require('tailwindcss/colors')

module.exports = {
  // mode: 'jit',
  content: [
    './app/components/**/*.html.haml',
    './app/components/**/*.rb',
    './app/views/**/*.html.haml',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        sky: colors.sky
      },
      borderWidth: {
        '16': '16px'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
  ]
}
