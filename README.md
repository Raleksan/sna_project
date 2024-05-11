# System and Network Administration Course IU S24 Final Project

## Project info

### Group members

- Aleksandr Ryabov (B22-CBS-01, [a.ryabov@innopolis.university](mailto:a.ryabov@innopolis.university))

## Project objective

The goal of the project is to provide a toolkit that 
is automated in installation, customization, and upgrades,
which will be useful to the developer as a unified development tool.

## Installation instructions
- Run following command to download and directly execute a script from GitHub

```
    curl -sSL https://raw.githubusercontent.com/raleksan/sna_project/main/scripts/install.sh | bash
```

## Description of project components

Generally project consist of 2 parts:
GitHub Action workflow and installation/update script.

### Description of workflow

- Workflow Trigger
    - This workflow is triggered automatically on a daily schedule at midnight or can also be manually triggered.

- Jobs
    - `build_svls`:This job checks for updates in the dalance/svls repository, builds the svls binary if updates are found, and archives it.
  
    - `build_slang`: Similarly, checks for updates in the MikePopoloski/slang repository, builds the slang binary if updates are found, and archives it.

    - `publish`: Once both binaries are built, this job downloads them, combines them into a single archive, after uploads and publishes the combined archive as a release.

### Description of installation script

- Bash script automates the installation of a toolkit. It then fetches information about the latest release of the toolkit from GitHub repository.
  
- After downloading and unpacking the release asset, it copies the necessary binary files to a system directory for global accessibility. Temporary files are removed after copying and a cron job is set up to ensure regular updates.

- Overall, the script provides a convenient and efficient way to install and manage the toolkit.
