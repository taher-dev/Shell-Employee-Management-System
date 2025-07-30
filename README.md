# Employee Management Application

This is a simple Employee Management Application implemented in shell script. It allows users to manage employee records through a command-line interface.

## Project Structure

```
employee-management-app
├── src
│   └── employee_management.sh  # Main script for managing employees
├── data
│   └── employees.txt            # Storage for employee records
└── README.md                    # Documentation for the project
```

## Features

- Add new employee records
- Delete employee records
- List all employees
- Update employee record

## Requirements

- A Unix-like operating system with a shell environment
- Basic command-line knowledge

## How to Run the Application

1. Open your terminal.
2. Navigate to the project directory:
   ```
   cd path/to/employee-management-app/src
   ```
3. Make the script executable:
   ```
   chmod +x employee_management.sh
   ```
4. Run the application:
   ```
   ./employee_management.sh
   ```

## Managing Employee Records

- To add an employee, follow the prompts after selecting the add option.
- To delete an employee, provide the employee ID of the record you wish to remove.
- To list all employees, select the list option.
- To update employee record, enter the employee ID of the record you wish to update.

## Notes

- Employee records are stored in `data/employees.txt`. Each line contains the employee's details in the format: `ID, Name, Position`.
- Ensure that the `employees.txt` file is writable to allow adding and deleting records.