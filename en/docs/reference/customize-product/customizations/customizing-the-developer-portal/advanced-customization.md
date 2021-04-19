# Advanced Customization

The user interface of the WSO2 API-M Developer Portal and Publisher Portal can be customized simply without editing the React codebase or the CSS in most cases. You will be required to modify the React codebase only if you need to do advanced customizations.

## Adding advanced UI customizations to WSO2 API-M UIs

Follow the instructions below to add advanced UI customizations to the Developer Portal and/or Publisher.

!!! note "Prerequisites"
    - **NodeJS**(minimum 8.12.0) - This is a platform required for ReactJS development.
    - **NPM**(minimum 5.7.0)

1. Navigate to the `<API-M_HOME>/repository/deployment/server/jaggeryapps` directory in a terminal and run the following command.

     ```js
     npm install
     ```

     This will install the dependencies for the `lerna` package manager.
     
2. Run the following command from the same directory in a terminal.

     ```js
     npm run bootstrap
     ```

     This will install the local package dependencies in the Publisher and Developer Portal applications.

3. Run the command given below in the relevant application.

     If it is a Developer Portal, run `npm run build:dev` from the `devportal` folder or else run the command from the `publisher` folder), to start the npm build. Note that it will continuously watch for any changes and rebuild the project.

     **For example to customize the Developer Portal:**

     1. Navigate to the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal` directory.

     2. Run the following command.

        ```js
        npm run build:dev
        ```

3. Make the UI related changes in the respective folder based on the WSO2 API-M Console.

     - If you need to rewrite the UI completely, you can make changes in the following directory.
         - Developer Portal - `devportal/source`
         - Publisher Portal - `publisher/source`
     - If you want to override a specific React component or a file from the `source/src/` directory, you need to make the changes in the following directory by only copying the desired file/files.
         - Developer Portal - `devportal/override/src`
         - Publisher Portal - `publisher/override/src`

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

You can import the **NewFile.jsx** by adding the **AppOverride** prefix to the import and provide the full path relative to the override directory.

```sh
import NewFile from 'AppOverride/src/app/components/Apis/Details/NewFile.jsx';
```

A compilation error will show up if you try to import the **NewFile.jsx** from **Overview.jsx** as follows.

```sh
import NewFile from './NewFile.jsx';
```

## Development

During an active development, the watch mode works with the overridden files. Adding new files and directories will not trigger a new webpack build.

## Production Build

Make sure you do a production build after you finish development with the command given below. The output of the production build contains minified javascript files optimized for web browsers.

```
npm run build:prod
```
