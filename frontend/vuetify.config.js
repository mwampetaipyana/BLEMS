import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
import { fa } from "vuetify/iconsets/fa";
import { aliases, mdi } from "vuetify/lib/iconsets/mdi";

export default createVuetify({
        components,
        directives,
        theme: {
          defaultTheme: 'myCustomTheme',
          themes: {
            myCustomTheme: {
              dark: false,
              colors: {
                main:"#30564b",
                main2 : "#ddd9d0",
                main3 : "#ebebeb"
              },
            },
          },
        },
        icons: {
            defaultSet: "mdi",
            aliases,
            sets: {
              mdi,
              fa,
            },
          },
      })
