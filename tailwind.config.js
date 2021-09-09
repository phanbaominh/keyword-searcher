module.exports = {
  mode: 'jit',
  purge: {
    enabled: ['production', 'staging'].includes(process.env.NODE_ENV),
    content: [
      './app/views/**/*.html.erb',
      './app/helpers/**/*.rb',
      './app/javascript/**/*.js',
    ],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
