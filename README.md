# Introduction
Excpense tracket application is a sample demo springboot - react full stack application in which data is colected into a simple react application and persisted in a database through the use of a rest api exposed in /api

# API contract/endpoints
For reference the end points implemented so far are:
/api/expenses
/api/expense/{id}
/api/categories
/api/category/{id}


# Getting Started

## Architecure

### Runtime architecture

*Web Browser (react app)* --- http ---> *expense-webapp* <--- REST ---> *expense-service* --- JDBC ---> *expense-db*

### Static architecture

Expense     *-- belongs to -->1 User
|
Expense     *-- represents a -- >1 category

### Physical architecture

nodejs                             springboort                        postgres
expensetracker    <--tcp/ip-->   expense-service   <--tcp/ip-->   postgresql

 * expensetracker: nodejs react app docker container exposing port 3000
 * expense-service: spring boot rest api docker container exposing port 8080
 * postgresql: postgres database docker container exposing port 5432


##Building the entire solution

Docker composer file located in the root folder creates all three services (expensetracker, expense-service and postgres - along with the admin pgadmin console for ease of use)

``` 
$ cd expense-service; ./mvnw install
$ cd ..; docker-compose up -- build 
```

