const colors = {
  transparent: "transparent",

  black: {
    DEFAULT: "#000000",
  },

  sockeye: {
    DEFAULT: "#d06348",
  },

  petrel: {
    DEFAULT: '#282938',
  },

  gold: {
    DEFAULT: '#c6ae40',
  },

  lark: {
    DEFAULT: '#83c3a5',
  },

  white: {
    DEFAULT: "#ffffff",
  },
};

module.exports = {
  mode: 'jit',
  purge: {
    content: ["./templates/**/*.html", "./templates/**/*.twig"],
    options: {},
  },
  theme: {
    colors: colors,
    container: {
      center: true,
      // padding: {
      //   DEFAULT: "1rem",
      //   sm: "2rem",
      //   lg: "4rem",
      //   xl: "5rem",
      // },
    },
    fontFamily: {
      'sans': ['"Source Sans Pro"', 'sans-serif'],
      'serif': ['"Crimson Text"', 'serif'],
    },
    screens: {
      xs: "480px",
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1280px",
    },
    extend: {

    },
  },
  variants: {
    animation: ["motion-safe"],
  },
  plugins: [require("@tailwindcss/typography")],
};
