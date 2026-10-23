# WSO2 API Manager Documentation

[![slack](https://img.shields.io/badge/slack-wso2--apim-blueviolet)](https://join.slack.com/t/wso2-apim/shared_invite/enQtNzEzMzk5Njc5MzM0LTgwODI3NmQ1MjI0ZDQyMGNmZGI4ZjdkZmI1ZWZmMjNkY2E0NmY3ZmExYjkxYThjNzNkOTU2NWJmYzM4YzZiOWU?)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-wso2am-orange)](https://stackoverflow.com/tags/wso2-am/)
[![Jenkins Build](https://img.shields.io/jenkins/build?jobUrl=https%3A%2F%2Fwso2.org%2Fjenkins%2Fview%2Fdocs%2Fjob%2Fdocs%2Fjob%2Fdocs-apim%2F)](https://wso2.org/jenkins/view/docs/job/docs/job/docs-apim)

---

## Contributing to WSO2 API-M documentation

As an open source project, WSO2 API-M welcomes contributions from the community. To start contributing, read these contribution guidelines for information on how you should go about contributing to our project.

1. Accept the Contributor License Agreement (CLA)

    You need to Accept the Contributor License Agreement (CLA) when prompted by a GitHub email notification after sending your first Pull Request (PR). Subsequent PRs will not require CLA acceptance.

    If the CLA gets changed for some (unlikely) reason, you will be presented with the new CLA text after sending your first PR after the change.

2. Fork this repository, make your changes, and send in a pull request (PR). Make sure you are contributing to the correct branch (for example, if your change is relevant to WSO2 API-M 4.7.0 documentation, you should commit your changes to the 4.7.0 branch).

3. Send multiple pull requests to all the relevant branches.

    If your change is relevant to the latest API-M release, please send your change to the respective latest API-M release branch and the master branch, which is the upcoming API-M release documentation branch, as well.

    For example, if the latest API-M release is 4.7.0, and if your change is relevant to API-M 4.6.0, 4.5.0, 4.4.0, 4.3.0, and 4.2.0, send PRs to the 4.6.0, 4.5.0, 4.4.0, 4.3.0, 4.2.0, and the master branches.

Check the issue tracker for open issues that interest you. We look forward to receiving your contributions.

## Run the project locally

### Step 1 - Install Python 3

Install Python 3.11 with pip and virtual environment support for the pinned documentation dependencies.

On macOS or Linux, verify the interpreter with `python3.11 --version`. On Debian-based systems, you may also need the `python3.11-venv` package.

On Windows, install Python 3.11 and the Python launcher, then verify it with `py -3.11 --version`.

### Step 2 - Clone the repository and create a virtual environment

1. Fork the GitHub repository: `https://github.com/wso2/docs-apim.git`.
2. Clone your fork:

    ```shell
    git clone https://github.com/[git-username]/docs-apim.git
    ```

3. Navigate to the language folder in the repository cloned in step 2.2:

    ```shell
    cd docs-apim/en/
    ```

4. Create and activate a virtual environment to keep the documentation dependencies separate from other Python projects.

    On macOS or Linux:

    ```shell
    python3.11 -m venv venv
    source venv/bin/activate
    ```

    On Windows PowerShell:

    ```powershell
    py -3.11 -m venv venv
    .\venv\Scripts\Activate.ps1
    ```

    On Windows Command Prompt, activate it with `venv\Scripts\activate.bat` instead.

### Step 3 - Install the required packages

Run these commands from `docs-apim/en/` with the virtual environment active:

```shell
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

Upgrading pip helps it understand current package metadata and resolve dependencies before installing the pinned documentation packages. Using `python -m pip` installs packages into the same Python environment used to run MkDocs.

The requirements include `setuptools<81` because the pinned Markdown 3.2.1 still imports the deprecated `pkg_resources` API.

### Step 4 - Run MkDocs

Use UTF-8 mode (`-X utf8`) so documentation and build messages also work with Windows locales that use a different default encoding.

1. From `docs-apim/en/`, with the virtual environment active, start the local server:

    ```shell
    python -X utf8 -m mkdocs serve
    ```

2. Open the local URL printed by MkDocs in the terminal. Its path follows the `site_url` setting in the branch's `mkdocs.yml`.

For faster incremental previews while editing, use:

```shell
python -X utf8 -m mkdocs serve --dirtyreload
```

Keep the repository's `mkdocs.yml` settings unchanged when submitting a pull request. If you temporarily adjust a setting for local development, restore its original value before submitting.

## License

Licenses this source under the Apache License, Version 2.0 ([LICENSE](LICENSE)), You may not use this file except in compliance with the License.
