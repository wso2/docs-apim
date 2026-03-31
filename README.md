# WSO2 API Manager Documentation

[![slack](https://img.shields.io/badge/slack-wso2--apim-blueviolet)](https://join.slack.com/t/wso2-apim/shared_invite/enQtNzEzMzk5Njc5MzM0LTgwODI3NmQ1MjI0ZDQyMGNmZGI4ZjdkZmI1ZWZmMjNkY2E0NmY3ZmExYjkxYThjNzNkOTU2NWJmYzM4YzZiOWU?)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-wso2am-orange)](https://stackoverflow.com/tags/wso2-am/)
[![Jenkins Build](https://img.shields.io/jenkins/build?jobUrl=https%3A%2F%2Fwso2.org%2Fjenkins%2Fview%2Fdocs%2Fjob%2Fdocs%2Fjob%2Fdocs-apim%2F)](https://wso2.org/jenkins/view/docs/job/docs/job/docs-apim)

---

## Contributing to WSO2 API-M documentation

As an open source project, WSO2 API-M welcomes contributions from the community. To start contributing, read these contribution guidelines for information on how you should go about contributing to our project.

### 1. Accept the Contributor License Agreement (CLA)

You need to accept the Contributor License Agreement (CLA) when prompted by a GitHub email notification after sending your first Pull Request (PR). Subsequent PRs will not require CLA acceptance.  

If the CLA gets changed for some (unlikely) reason, you will be presented with the new CLA text after sending your first PR after the change.

### 2. Fork, Edit, and Send Pull Requests

Fork this repository, make your changes, and send in a pull request (PR). Make sure you are contributing to the correct branch (for example, if your change is relevant to WSO2 API-M 4.7.0 documentation, you should commit your changes to the 4.7.0 branch).  

### 3. Send PRs to Relevant Branches

If your change is relevant to the latest API-M release, please send your change to the respective latest API-M release branch and the master branch, which is the upcoming API-M release documentation branch.  

For example, if the latest API-M release is 4.7.0, and your change is relevant to API-M 4.6.0, 4.5.0, 4.4.0, 4.3.0, and 4.2.0, send PRs to the 4.6.0, 4.5.0, 4.4.0, 4.3.0, 4.2.0, and the master branches.  

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.

---

## Run the project locally

### Step 1 - Install Python

#### macOS

If you are using macOS, you probably already have a version of Python installed. Verify by running:

```shell
$ python --version
Python 2.7.2

If your version of Python is 2.x.x, also install Python 3 because the PDF plugin only supports Python3. Follow this guide
 to install Python3.

After installation, you will have two versions of Python on your machine: python2 and python3.

Ubuntu / Debian Linux

Python 3 is pre-installed. Verify with:

$ python3 -V

Install pip if needed:

$ sudo apt install -y python3-pip
$ pip3 -V
Step 2 - Install Pip

If pip is not installed, download get-pip.py and run:

$ python get-pip.py

Upgrade pip to the latest version:

$ pip install --upgrade pip
Step 3 - Install Required Packages
Fork the GitHub repository:
https://github.com/wso2/docs-apim.git
Clone your fork locally:
$ git clone https://github.com/[git-username]/docs-apim.git
Navigate to the repository folder:
$ cd docs-apim/en/
Install required pip packages:
For Python2:
$ pip install -r requirements.txt
For Python3:
$ pip3 install -r requirements.txt
Step 4 - Run MkDocs
Start the local server:
$ python3 -m mkdocs serve

Note:
To see live changes while editing:

Open mkdocs.yml and set strict: false
# Breaks build if there's a warning
strict: false
Run:
python3 -m mkdocs serve --dirtyreload
Open the documentation locally in a browser:

http://localhost:8000/get-started/overview/

Important:
Before sending a pull request, revert strict to true in mkdocs.yml.

License

Licensed under the Apache License, Version 2.0 (LICENSE
). You may not use this file except in compliance with the License.