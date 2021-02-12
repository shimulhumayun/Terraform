## Codebuild: Custom build environment
This project to customize build environments in CodeBuild to include all dependencies in a Docker image.

### Goals
* Standardized environment across all platforms. We can deploy it to any other system where docker is running with minimal changes.
* Upgrade to spark to 3.0
* Reduce CI/CD build time.

### Architecture
** Image*

### Components for custom environment
* Dockerfile
* Python
* Pyspark 3.0
* Python and Pyspark dependencies
* PostgreSQL
* OpenJDK 


#### Cloudformation Temple - *cf.yml*
* Creates an AWS codebuild environment for docker.
* An ECR repository to store the docker image.

