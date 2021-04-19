# Overriding the Publisher Portal Theme

There are mainly 2 ways to customize and override the publisher portal theme. 

1. Theming using userThemes.js
2. Overriding React components

In this section, we will cover the first technique which is the easiest way to change the appearance of Developer portal.

For the second technique, please refer [Advanced Customization]({{base_path}}/develop/customizations/advanced-ui-customization/) section.

The default theme of the Publisher portal is built into the portal bundle file. You can find the pre-packed default theme file in the `<API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/source/src/app/data/defaultTheme.js` source directory.

This can be used as a reference to identify the custom extension points that are available in the Publisher theme file.

To override the default theme parameters, you have to update the [externalized](https://webpack.js.org/configuration/externals/) `userThemes.js` file in the `<API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/public/conf/userThemes.js` file.

Changes done in the `userThemes.js` file are reflected directly in the Publisher app (You do not need to restart the server or rebuild the source code).

When modifying the theme, you can only provide the custom parameter that you want to override in the default theme, the rest of the theme parameters will be inherited from the built-in default theme configuration. 

### Content of defaultTheme.js

The following is the Publisher app theme object merging with the React Material Design default theme object described [here](https://material-ui.com/customization/default-theme/#default-theme).


<div>
<div class="jsonTreeOutput"></div>
<textarea class="jsonTreeInput">
{
  "overrides": {
    "MuiDrawer": {
      "paper": {
        "backgroundColor": "#18202c"
      }
    },
    "MuiButton": {
      "label": {
        "textTransform": "none"
      },
      "contained": {
        "boxShadow": "none",
        "&:active": {
          "boxShadow": "none"
        }
      }
    },
    "MuiIconButton": {
      "root": {
        "padding": 8
      }
    },
    "MuiTooltip": {
      "tooltip": {
        "borderRadius": 4
      }
    },
    "MuiDivider": {
      "root": {
        "backgroundColor": "#404854"
      }
    },
    "MuiListItemIcon": {
      "root": {
        "color": "inherit",
        "marginRight": 0,
        "& svg": {
          "fontSize": 20
        }
      }
    },
    "MuiAvatar": {
      "root": {
        "width": 32,
        "height": 32
      }
    }
  },
  "palette": {
    "primary": {
      "main": "#15b8cf"
    },
    "secondary": {
      "light": "#0066ff",
      "main": "#a2ecf5",
      "contrastText": "#ffcc00"
    },
    "background": {
      "default": "#f6f6f6",
      "paper": "#ffffff",
      "appBar": "#1d344f",
      "appBarSelected": "#1d344f",
      "leftMenu": "#1a1f2f",
      "leftMenuActive": "#254061",
      "drawer": "#1a1f2f",
      "activeMenuItem": "#254061"
    }
  },
  "typography": {
    "fontFamily": "\"Open Sans\", \"Helvetica\", \"Arial\", sans-serif",
    "fontSize": 12,
    "subtitle2": {
      "fontWeight": 600,
      "fontSize": "0.875rem"
    },
    "h4": {
      "fontSize": "1.3rem"
    }
  },
  "zIndex": {
    "apiCreateMenu": 1250,
    "operationDeleteUndo": 1600,
    "overviewArrow": 1,
    "goToSearch": 2
  },
  "custom": {
    "wrapperBackground": "#f9f9f9",
    "starColor": "#f2c73a",
    "disableColor": "#D3D3D3",
    "leftMenuWidth": 210,
    "contentAreaWidth": 1240,
    "drawerWidth": 250,
    "logo": "/site/public/images/logo.svg",
    "logoHeight": 40,
    "logoWidth": 222,
    "defaultApiView": "grid",
    "showApiHelp": false,
    "leftMenu": "icon left",
    "leftMenuIconSize": 24,
    "leftMenuIconMainSize": 52,
    "leftMenuTextStyle": "capitalize",
    "resourceChipColors": {
      "get": "#61affe",
      "post": "#49cc90",
      "put": "#fca130",
      "delete": "#f93e3e",
      "options": "#0d5aa7",
      "patch": "#50e3c2",
      "head": "#9012fe",
      "trace": "#785446",
      "disabled": "#ebebeb"
    },
    "operationChipColor": {
      "query": "#b3e6fe",
      "mutation": "#c1dea0",
      "subscription": "#ffcc80"
    },
    "overviewStepper": {
      "backgrounds": {
        "completed": "#eeeeee",
        "active": "#fff",
        "inactive": "#e0e0e0"
      },
      "iconSize": 32
    },
    "thumbnail": {
      "backgrounds": [
        {
          "prime": 2406206207,
          "sub": 1338177791
        },
        {
          "prime": 4101969663,
          "sub": 3453762047
        },
        {
          "prime": 4097980159,
          "sub": 4274063359
        },
        {
          "prime": 563540991,
          "sub": 2934571263
        },
        {
          "prime": 4288086271,
          "sub": 4293606655
        },
        {
          "prime": 4288086271,
          "sub": 4267123455
        }
      ],
      "document": {
        "icon": "library_books",
        "backgrounds": {
          "prime": 3489136639,
          "sub": 3808425983
        }
      }
    },
    "adminRole": "admin",
    "commentsLimit": 5,
    "maxCommentLength": 1300,
    "productSampleProgess": {
      "backgroundMain": "#15b8cf",
      "backgroundChip": "#5aebf9"
    },
    "warningColor": "#ffc439",
    "title": {
      "prefix": "[Devportal]",
      "sufix": "- WSO2 APIM"
    }
  }
}
</textarea>
</div>
