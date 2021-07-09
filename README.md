# [Company Employee Tracker](https://github.com/arielo5/Company_Employee_Tracker) 

[![License](https://img.shields.io/badge/License-MIT-brightgreen)](https://choosealicense.com/licenses/mit/)

  ## Table of Contents

  - [Description](#description)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Screenshots](#screenshots)
    - [Snippets](#snippets)
  - [License](#license)
  - [Contributing](#contributing)

  ## Description
  
  The motivation for this project was to build a Node.js command-line application that will keep track of your company's employees, roles, and departments. The reason for this is to help create a command-line application that tracks all the basic information for all the employee of the company. It solve a better and faster way to to save and get employee information. For this project I learn that to better improve myself I need to continuously learn all the new tips and knowledge that I can  implement in every project that I can get my hands on.

  ## Installation

  Steps to install application:
    Command prompt:
        1. mysql -u root -p
        2. Enter password
        3. source db/employeeTrackerSchema.sql
        4. source seed/employeeTrackerSeed.sql (optional)

    Git Bash
        1. git clone git@github.com:kqarlos/employee-tracker.git
        2. npm install
        3. add enviroment variable or update credentials in connection.js
        4. npm start

```
npm install
node eTracker.js
```
  ## Usage
  
  ### Screenshots

1. Displaying tables

![Site](./assets/images/tables.png)

2. Adding employee manager example

![Site2](./assets/images/addEmployee.png)

3. Removing employee example

![Site3](./assets/images/removeEmployee.png)

4. Working app

![Site4](./assets/images/Company_Employee_Tracker.gif)

### Snippets


1. Workflow to add employee

```javascript

//Calls to get employees and roles. calls to prompt for new employee's info
function addEmployee() {
    db.Employee.getEmployees().then(function (managers) {
        db.Role.getRoles().then(function (roles) {
            promptSelectRole(roles).then(function (roleid) {
                promptForEmployeeinfo(roleid, managers);
            });
        });
    });
}
    
```
* This function is called when a user selects to add a user. It handles the workflow and gathering of data necesary to ask the user for the new employee's information and eventually perform the mySQL query to add a new employee. It relies on promises that return a list of employees and a list of roles respectively. The list of roles is then used to ask the user for the new employee's role. This is then sent to _promptForEmployeeinfo(roleid, manager)_ This will make sure the user has the necessary information to populate the new user's properties.

2. Gets all employees from database

```javascript

    getEmployees(cb) {
        console.log("Getting all employees");
        this.connection.query("SELECT * FROM Employee", (err, res) => {
            if (err) throw err;
            cb(res);
        });
    }

```
* This function from the Employee class perform the query to retrieve all employees and call the callback function on the query response.

3. Asks user to select a role for the new employee

```javascript

function promptSelectRole(roles) {
    console.log("Select employee role...");
    return new Promise(function (resolve, reject) {
        if (!roles) return reject(Error("No roles found!"));
        let roleTitles = roles.map(r => {
            return (r.title);
        });
        inquirer.prompt({
            type: "list",
            name: "role",
            message: "Choose a role",
            choices: roleTitles
        }).then(function (res) {
            roles.forEach(r => {
                if (r.title === res.role) {
                    resolve(r.id);
                }
            });
        });
    });
}

```
* This function takes care of getting a role from the user. This encapsulates the process of getting a _roleid_ from the user which is used on other functions.

4. Prompts user to enter employee information

```javascript

//Ask user for information of the new employee to add
//Gets all roles titles to let the user choose new employee's role
//calls to query add employee
function promptForEmployeeinfo(roleid, managers) {
    console.log("Enter new employee's information");
    let managerNames = managers.map(m => {
        return (m.first_name + " " + m.last_name);
    });
    managerNames.push("No Manager");
    inquirer.prompt([
        {
            type: "input",
            message: "Enter first name: ",
            name: "firstName"
        },
        {
            type: "input",
            message: "Enter last name: ",
            name: "lastName"
        },
        {
            type: "list",
            message: "Select manager: ",
            name: "manager",
            choices: managerNames
        }
    ]).then(function (res) {
        var managerid;
        managers.forEach(m => {
            if ((m.first_name + " " + m.last_name) === res.manager) {
                managerid = m.id;
            }
        });
        db.Employee.addEmployee([
            res.firstName,
            res.lastName,
            roleid,
            managerid
        ], employee =>{
            mainMenu()
        );
    });

}

```
* This function prompts the user to enter or select information of the new employee. It uses the array of managers and maps only their  name. This allows the user to select the new employee's manager based on easier to understand properties. Then, the user's selection is mapped back to the original arrays to get the _managerid_. The user's input information, roleid and managerid is then used to call the database to _addEmployee()_ to the employee table.

4. Adds an employee to the database

```javascript

    addEmployee(employee, cb) {
        console.log("Adding employee...");
        this.connection.query("INSERT INTO employee(first_name, last_name, role_id, manager_id) VALUES (?, ?, ?, ?)", employee, (err, res) => {
            if (err) throw err;
            cb(res);
        });
    }

```
* This function recieves an array of employee information and a callback function. This array is used to insert a new employee into the _employees_ table. After the query is performed, the callback is called on the response.

  ## Contributing

  Have you spotted a typo, would you like to fix a link, or is there something you’d like to suggest? Browse the source repository of this article and open a pull request. I will do my best to review your proposal in due time.

  ## License

  [![License](https://img.shields.io/badge/License-MIT-brightgreen)](https://choosealicense.com/licenses/mit/)


  
  