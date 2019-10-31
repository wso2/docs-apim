# Contributing to WSO2 API Manager Documentation

WSO2 API Manager (API-M) documentation is a relavitely new project that involves hosting source documentation on GitHub. This documentation is rendered using [mkdocs](https://www.mkdocs.org/), which is a static site generator that's geared towards building project documentation. Documentation source files are written in Markdown, and configured with a single YAML configuration file.

We are an open-source project registered under Apache license.

We appreciate your help and contributions!

## Getting started with contribution

* Get started with the WSO2 Enterprise Integrator by accessing the [documentation landing](https://ei.docs.wso2.com/en/latest/) and navigating to the integrator of your choice. Start trying out our quick start guides and tutorials available in the Get Started and Learn sections.
* Submit issues and contribute content. Go to the **Issues** tab of this GitHub repo and click the New Issue button to file a bug report.
* Fix issues: Use comments on the issue itself to indicate that you will be working on it and get guidance and help.

## Filing issues

If you are unsure whether you have found a bug, please consider searching existing issues in GitHub and asking in dev@wso2.com or on [Stack Overflow](https://stackoverflow.com/tags/wso2).

> IMPORTANT: Sensitive security-related issues should be reported to [security@wso2.com](security@wso2.com). See the [security policy](https://wso2.com/security) for details.

To file non-security issues:

1. Click the **Issues** tab in the GitHub repository.

2. Click the **New Issue** button.

3. Fill out all sections in the issue template and submit.

## Contributing to docs

This is done by sending a Pull Request (PR) to the relevant file that you want to edit. We welcome more community contributions to our project.

### Accepting Contributor License Agreement (CLA)

Before you submit your first contribution please accept our Contributor License Agreement (CLA). When you send your first Pull Request (PR), GitHub will ask you to accept the CLA.

There is no need to do this before you send your first PR.

Subsequent PRs will not require CLA acceptance.

If for some (unlikely) reason at any time CLA changes, you will get presented with the new CLA text on your first PR after the change.

## Generating the documentation for viewing in your local machine

#### Prerequisites

- Install python
- Install pip
- Install mkdocs
    ```bash
    $ pip install mkdocs
    ```
- Install pymdown-extensions
    ```bash
    $ pip install pymdown-extensions
    ```
#### Generating website content

Navigate to `docs` directory and run the following command.

```bash
mkdocs serve
```

This will render the source code and generate website content.