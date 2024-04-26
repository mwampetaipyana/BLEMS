/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors :{
        main:"#30564b",
        main2 : "#ddd9d0",
        main3 : "#ebebeb"
      }
    },
  },
  plugins: [],
}

