# Bank

This is a tech test in Ruby to practice object-oriented design and test-driven development skills.

## Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012
**And** a deposit of 2000 on 13-01-2012
**And** a withdrawal of 500 on 14-01-2012
**When** she prints her bank statement
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

---

## Pre-requisites

- Ruby 2.7.0
- Bundler 2

## Get started

1. Clone this repository
1. Install dependencies
    ```bash
    bundle install
    ```
1. Run the Ruby linter
    ```bash
    bundle exec rubocop
    ```
1. Run the tests and check coverage
    ```bash
    bundle exec rspec
    ```
