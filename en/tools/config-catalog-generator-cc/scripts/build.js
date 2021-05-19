/**
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */

const fs = require('fs-extra');
const nunjucks = require('nunjucks');
const path = require('path');
const rimraf = require('rimraf');

const comp = ["adapter", "router", "enforcer", "control-plane", "analytics"]
var i;
for (i = 0; i < comp.length; i++) {
    const configData = require('../data/' + comp[i] + '/configs.json');
    const template = path.join(__dirname, '..', 'templates', 'index_' + comp[i] + '.njk');
    const outputFileName = comp[i] + '-configurations.md';
    const outputPath = path.join(__dirname, '..', 'dist');
    const output = path.join(outputPath, outputFileName);

    const content = nunjucks.render(template, configData);

    const writeFile = () => {
        fs.writeFileSync(output, content, (error) => {
            console.error(outputFileName + ' generation failed.');
            console.error(error);
        });

        console.info(outputFileName + ' generated.');
    };

    if (!fs.existsSync(outputPath)) {
        fs.mkdirSync(outputPath);
        writeFile();
    } else {
        rimraf(outputPath + '/*', () => {
            writeFile();
        });
    }
}

