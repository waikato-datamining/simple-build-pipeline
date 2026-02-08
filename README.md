# simple-build-pipeline
Simple build pipeline aimed at projects that use Maven as build system.
However, the build command can be changed to something else, globally 
and per project.


## Requirements

The following ADAMS application can be used for running the flows:

* Java 11+
* [adams-basic-app](https://adams.cms.waikato.ac.nz/snapshots/adams/adams-basic-app-snapshot-bin.zip)


## Directory structure

```
execute.flow
|
+- config
|  |
|  +- .props files, one per project to build
|
+- src  source code gets checked out here
|
+- bin  the build output gets copied here
```


## Flows

* [execute.flow](execute.flow) - performs the checkout/update/build of the source code

### execute.flow

You can override the following parameters by adding a `execute.props`
file alongside the flow:

* `git_cmd` - the git executable and its options to use (e.g., `git` or `/some/where/git -v`)
* `ssh_cmd` - the ssh executable and its options to use (e.g., `ssh`); 
  `-i SSH_KEY` gets added automatically
* `build_cmd` - the Maven executable and its options to use for building the projects
  (e.g., `mvn clean install -DskipTests=true -Dstyle.color=never`)
* `build_output` - the regexp for locating the build output in the project dirs 
  to copy to the `bin` directory (e.g., `.*-bin.zip`)
* `clean_mvn_repo` - whether to remove the `$HOME/.m2/repository` directory
  before starting the builds


## Config files

The configuration files in directory [config](config) are simple
[Java properties files](https://en.wikipedia.org/wiki/.properties) 
with `.props` as extension.

```properties
repo=git@github.com:gitorg/my-repo.git
dir=my-repo
```

If the repository is a private one, you can also specify an ssh key 
(pointing to the private part of the key pair):

```properties
ssh_key=/some/where/build-key
```

You can also override the following global settings on a per-project basis:

* `build_cmd` - the command to build the source code (e.g., `mvn clean install -DskipTests=true -Dstyle.color=never`) 
* `build_output` - the regexp for locating the files to copy to the `bin` directory (e.g., `.*-bin.zip`)
* `git_cmd` - the git executable and its options to use (e.g., `git` or `/some/where/git -v`)
* `ssh_cmd` - the ssh executable and its options to use (e.g., `ssh`); 
  `-i IDENTIFY_FILE` gets added automatically


## Order of execution

The `.props` config files get ordered by name and executed that way,
allowing you to define a deterministic build order.


## Headless execution

Of course, you don't have to execute the flows with the graphical interface. Instead, you can 
execute them as follows:

```bash
bin/exec.sh -input checkout.flow -headless
bin/exec.sh -input build.flow -headless
```
