# Expenses service
A set of endpoints that manage expenses entiy their associated entities like user and expense category.
User is the foreigh entity that expenses are attached to.

# Model
An expense is a set of data related with a category being posted by a user. No business rules associated to expenses are coded as this is a demo service, but possible rules are that expenses cannot be posted in the future, or that cost of expenses need to obey rto a certain thrweshold or that they have an approval work flow

# Improvement for the future

## Features improvements
### Workflow implementation
Implement a workflow of expense approval and an expense state machine

## Architecure

### Secure endpoints
Make endpooints secure and only accessible by a specific set of roles. As an add on only rect expenses from a specific user if the user requesting expenses is the user owner or a delegate (approval is there is any lifecycle implementatoin)

### Caching responses and seperate data layer


### Implement a CI pipeline
Dockerize components so we can build and run them consistently

### Implement a CD pipeline
Terraform infrastructure to deploy them consistently

### Implement meaninfull tests guardians of the pipelines health
Security and performance tests on top of the functional tests so we make sure pipelines health are ensured

## TBD