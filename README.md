# System and Network Administration Course IU S24 Final Project

## Project info

### Group members:

1. Aleksandr Ryabov (B22-CBS-01, [a.ryabov@innopolis.university](mailto:a.ryabov@innopolis.university))

## Project objective

The goal of the project is to provide a toolkit that 
is automated in installation, customization, and upgrades,
which will be useful to the developer as a unified development tool.

## Installation instructions
- TBA

## Description of project components

Generally project consist of 2 parts:
GitHub Action workflow and installation/update script.

### Description of workflow:

- Workflow Trigger:
    - This workflow is triggered automatically on a daily schedule at midnight and can also be manually triggered.

- Jobs:
    - `build_svls`: This job sets up the environment, checks for updates in the `dalance/svls` repository, builds the `svls` binary if updates are found, and archives it.

    - `build_slang`: Similarly, this job sets up the environment, checks for updates in the `MikePopoloski/slang` repository, builds the `slang` binary if updates are found, and archives it

    - `publish`: Once both binaries are built, this job downloads them, combines them into a single archive, creates a draft release based on the current date, uploads the combined archive as a release asset, and finally publishes the draft release.

### Description of installation script:

- Bash script automates the installation of a toolkit by first checking for sudo privileges and welcoming the user. It then fetches information about the latest release of the toolkit from a specified GitHub repository.

- After downloading and unpacking the release asset, it copies the necessary binary files to a system directory for global accessibility. Temporary files are removed to maintain system cleanliness, and a cron job is set up to ensure regular updates.

- Overall, the script provides a convenient and efficient way to install and manage the toolkit, enhancing the user's development experience.
