# WSO2 API Manager Documentation

[![slack](https://img.shields.io/badge/slack-wso2--apim-blueviolet)](https://join.slack.com/t/wso2-apim/shared_invite/enQtNzEzMzk5Njc5MzM0LTgwODI3NmQ1MjI0ZDQyMGNmZGI4ZjdkZmI1ZWZmMjNkY2E0NmY3ZmExYjkxYThjNzNkOTU2NWJmYzM4YzZiOWU?)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-wso2am-orange)](https://stackoverflow.com/tags/wso2-am/)
[![Jenkins Build](https://img.shields.io/jenkins/build?jobUrl=https%3A%2F%2Fwso2.org%2Fjenkins%2Fview%2Fdocs%2Fjob%2Fdocs%2Fjob%2Fdocs-apim%2F)](https://wso2.org/jenkins/view/docs/job/docs/job/docs-apim)

---

This is the documentation for the upcoming release of WSO2 API Manager (WSO2 API-M). Please note that this documentation is work in progress.

To see the **latest released documentation** for the WSO2 API Manager, go to: [https://apim.docs.wso2.com/en/latest/](https://apim.docs.wso2.com/en/latest/)

## Contributing to WSO2 API-M documentation

As an open source project, WSO2 API-M welcomes contributions from the community. To start contributing, read these contribution guidelines for information on how you should go about contributing to our project.

1. Accept the Contributor License Agreement (CLA)

    You need to Accept the Contributor License Agreement (CLA) when prompted by a GitHub email notification after sending your first Pull Request (PR). Subsequent PRs will not require CLA acceptance.

    If the CLA gets changed for some (unlikely) reason, you will be presented with the new CLA text after sending your first PR after the change.

2. Fork this repository, make your changes, and send in a pull request (PR). Make sure you are contributing to the correct branch (for example, if your change is relevant to WSO2 API-M 3.2.0 documentation, you should commit your changes to the 3.2.0 branch).

3. Send multiple pull requests to all the relevant branches.

    If your change is relevant to the latest API-M release, please send your change to the respective latest API-M release branch and the master branch, which is the upcoming API-M release documentation branch, as well.

    For example, if the latest API-M release is 3.2.0, and if your change is relevant to API-M 3.2.0, 3.1.0, and 3.0.0, send PRs to the 3.0.0, 3.1.0, 3.2.0, and the master branches.

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.

## Run the project locally

### Step 1 - Install Python

If you are using MacOS, you probably already have a version of Python installed on your machine. You can verify this by running the following command.

```shell
$ python --version
Python 2.7.2
```

If your version of Python is Python 2.x.x, you also need to install Python3. This is because the PDF plugin only supports Python3. Follow the instructions in [this guide](https://docs.python-guide.org/starting/install3/osx/) to install Python3 properly.

Once you are done, you will have two versions of Python on your machine; a version of python2 and a version of python3.

### Step 2 - Install Pip
>
> **INFO**
>
> If pip is not already installed on your machine, download `get-pip.py` to install pip for the first time. Then run the following command to install it:
> ```shell
> $ python get-pip.py
> ```
>

Pip is most likely installed by default. However, you may need to upgrade pip to the latest version:

```shell
$ pip install --upgrade pip
```

### Step 3 - Install the pip packages

1. Navigate to the `<language-folder>/` folder.

    ```shell
    $ cd docs-apim/en
    ```

2. Install the required pip packages.

    This will install MkDocs and the required theme, extensions, and plugins.

    - If you are using Python2, use the following command:

      ```shell
      $ pip install -r requirements.txt
      ```

    - If you are using Python3, use the following command:

      ```shell
      $ pip3 install -r requirements.txt
      ```

### Step 4 - Run MkDocs

Follow the steps below to clone the API-M documentation GitHub repository and to run the site on your local server.

1. Fork the GitHub repository: `https://github.com/wso2/docs-apim.git`
2. Navigate to the place where you want to clone the repo.

    Git clone the forked repository.

    ```shell
    $ git clone https://github.com/[git-username]/docs-apim.git
    ```

3. Navigate to the folder containing the repo that you cloned in step 4.1 on a terminal window.

    For example:

    ```shell
    $ cd docs-apim/<Language-folder>/
    ```

    ```shell
    $ cd docs-apim/en/
    ```

4. Run the following command to start the server and view the site on your local server.

    ```shell
    $ mkdocs serve
    ```

    > **NOTE:**
    >
    > If you are making changes and want to see them on the fly, run the following command to start the server and view the site on your local server.
    > 1. Navigate to the `mkdocs.yml` file.
    > 2. Change the following configuration to `false` as shown below. 
    >     ```
    >     #Breaks build if there's a warning
    >     strict: false
    >     ```
    > 3. Run the following command to start the server and to make the server load only the changed items and display the changes faster. 
    >
    >    `mkdocs serve --dirtyreload`
  
5. Open the following URL on a new browser window to view the API-M documentation site locally.

    [http://localhost:8000/getting-started/overview/](http://localhost:8000/getting-started/overview/)

> **NOTE:**
>
> If you were running the `mkdocs serve --dirtyreload` command to run the MkDocs server, make sure to change the configuration in the `mkdocs.yml` file as follows before sending a pull request.
>
> `strict: true` 

## License

Licenses this source under the Apache License, Version 2.0 ([LICENSE](LICENSE)), You may not use this file except in compliance with the License.
