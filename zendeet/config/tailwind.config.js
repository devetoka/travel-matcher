module.exports = {
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        primary: '#2563EB',      // blue-600
        'primary-hover': '#1D4ED8', // blue-700
        secondary: '#2DD4BF',    // teal-500
        'secondary-hover': '#0D9488', // teal-600
        'background-start': '#EFF6FF', // blue-50
        'background-end': '#CCFBF1',   // teal-100
        text: '#1E40AF',         // blue-700
        accent: '#2DD4BF'        // teal-500
      }
    }
  },
  plugins: []
};