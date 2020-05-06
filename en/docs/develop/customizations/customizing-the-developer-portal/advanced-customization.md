# Advanced Customization

### prerequisites

#### NodeJS and NPM

NodeJS is the platform needed for the ReactJS development. 

The devportal user interface can be customized simply without touching the React codebase or CSS for most common cases. But for advanced use cases, it's required to modify the react code base.

1. Navigate to <API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/  in a terminal and run the following command.

```js
npm ci
```
2. Run the following to start the npm build. Note that it will continuously watch for any changes and rebuild the project.  
```
npm run build:dev
```
3. If you are planning to completely rewrite the UI, then it's OK to start making changes for devportal/source/. But if you want to override a certain React Component / File from source/src/ folder, you need to do it in devportal/override/src folder. You do not have to copy the entire directory, only copy the desired file/files.

#### Example
Following will override the API Documentation component and Overview components.
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
If we try to import the **NewFile.jsx** from **Overview.jsx** as follows it will give a compilation error.

```sh
import NewFile from './NewFile.jsx';
```

The correct way is to add the **AppOverride** prefix to the import and provide the full path relative to the override folder.
```sh
import NewFile from 'AppOverride/src/app/components/Apis/Details/NewFile.jsx';
```

### Development

When you are doing active development, the watch mode is working with the overridden files. But adding new files and directories will not trigger a new webpack build.

### Production Build

When you finish your development, it's required to do a production build. The output of the production build has minified javascript files optimized for web browsers.

```
npm run build:prod
```
