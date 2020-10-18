const colors = {
  transparent: "transparent",

  black: {
    default: "#000000",
  },

  white: {
    default: "#ffffff",
  },
};

module.exports = {
  future: {},
  purge: {
    content: ["./templates/**/*.html", "./templates/**/*.twig"],
    options: {},
  },
  theme: {
    colors: colors,
    container: {
      center: true,
      padding: {
        default: "1rem",
        sm: "2rem",
        lg: "4rem",
        xl: "5rem",
      },
    },
    screens: {
      xs: "480px",
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1280px",
    },
    extend: {},
  },
  variants: {
    animation: ["motion-safe"],
  },
  plugins: [require("@tailwindcss/typography")],
  future: {
    removeDeprecatedGapUtilities: true,
  },
  experimental: {
    applyComplexClasses: true,
    extendedSpacingScale: true,
    defaultLineHeights: true,
  },
};
