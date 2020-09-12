# Advanced Customization

### Prerequisites

- NodeJS
- NPM

NodeJS is a platform required for ReactJS development. 

The user interface of the Developer Portal can be customized simply without editing the React codebase or  the CSS in most cases. You will be required to modify the react code base, if you need to do advanced customizations.

1. Navigate to `<API-M_HOME>/repository/deployment/server/jaggeryapps`  in a terminal and run the following command.
    ```js
    lerna bootstrap
    ```
2. Run the command given below in the relevant app(if it is a devportal, run the npm run build:dev at the devportal folder or else run at the publisher folder ), to start the npm build. Note that it will continuously watch for any changes and rebuild the project.
    ```js
    Example:
    
    Navigate to '<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal'

    npm run build:dev
    ```
3. If you are required to rewrite the UI completely, you can make changes in the `devportal/source` folder. If you want to override a specific React Component or a File from the `source/src/` folder, you need to do it in the `devportal/override/src` folder by only copying the desired file/files.

#### Overriding the API Documentation and Overview components
```sh
override
└── src
    ├── Readme.txt
    └── app
        └── components
            └── Apis
                └── Details
                    ├── Documents
                    │   └── Documentation.jsx
                    └── Overview.jsx
```

#### Adding new files to the override folder
```sh
override
└── src
    ├── Readme.txt
    └── app
        └── components
            └── Apis
                └── Details
                    ├── Documents
                    │   └── Documentation.jsx
                    └── Overview.jsx
                    └── NewFile.jsx
                    
```
You can import the **NewFile.jsx** by adding the **AppOverride** prefix to the import and provide the full path relative to the override folder.
```sh
import NewFile from 'AppOverride/src/app/components/Apis/Details/NewFile.jsx';
```

A compilation error will show up if you try to import the **NewFile.jsx** from **Overview.jsx** as follows.
```sh
import NewFile from './NewFile.jsx';
```

### Development

During an active development, the watch mode works with the overridden files. Adding new files and directories will not trigger a new webpack build.

### Production Build

Make sure you do a production build after you finish development with the command given below. The output of the production build contains minified javascript files optimized for web browsers.

```
npm run build:prod
```
