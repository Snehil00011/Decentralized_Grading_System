![image](https://github.com/user-attachments/assets/75024f80-cb1c-440d-8d50-5a6cc8978eb2)
# 🎓 Decentralized Grading System
## Project Description
### Contract Address: 0x64Aa551b7AdE03242560D76Efd3df7F2296cE566
![image](https://github.com/user-attachments/assets/38ab152c-af1e-4fb4-ab7c-b693fea3ebbc)

The Decentralized Grading System is an innovative approach to managing academic grades using the Ethereum blockchain. By leveraging the transparency, security, and immutability of blockchain technology, this system ensures that student grades are recorded permanently and can only be modified by authorized individuals. This decentralized system eliminates the risk of grade tampering and provides a trustworthy record of academic achievements.

## Key Features

- **🔗 Decentralized Management:** Grades are stored on the blockchain, offering a secure and transparent way to track academic records.
- **👨‍🏫 Authorized Teachers:** Only approved teachers can assign grades, ensuring that only valid entries are recorded.
- **📊 Detailed Grade Viewing:** Students and other authorized parties can view detailed information about grades, including course names and grades.
- **🔐 Flexible Administration:** The contract owner can authorize or revoke teachers' permissions, maintaining control over who can interact with the grading system.

## Project Vision

The Decentralized Grading System aims to revolutionize how academic records are managed by removing the need for a central authority. By utilizing blockchain technology, the system seeks to provide a tamper-proof, transparent, and secure way to record and access grades. The vision is to create a trustworthy and universally accessible platform for academic institutions, ensuring that every student's hard-earned grades are protected from manipulation and are accessible globally.

## Overview

The Decentralized Grading System is a smart contract built on the Ethereum blockchain that allows for the decentralized management of student grades. Designed to be secure and transparent, this system ensures that grades are recorded immutably and can only be modified by authorized teachers.

## Architecture

### 🏗️ Contract Structure

- **👑 Owner:** The contract administrator with the authority to manage teacher permissions.
- **📜 Grade Struct:** Represents a grade with the course name, grade, and a flag to indicate validity.
- **🗂️ Mappings:**
  - **📝 studentGrades:** Maps student addresses to their list of grades.
  - **✅ authorizedTeachers:** Maps teacher addresses to their authorization status.

### ⚙️ Key Functions

- **✅ authorizeTeacher(address teacher):** Authorizes a teacher to assign grades. Only the contract owner can call this function.
- **🚫 revokeTeacher(address teacher):** Revokes a teacher's authorization. Only the contract owner can call this function.
- **📚 assignGrade(address student, string memory courseName, string memory grade):** Allows an authorized teacher to assign a grade to a student.
- **🔍 viewGradesDetailed(address student):** Returns a detailed string of grades for a given student. If no grades are found, it returns "Student grade doesn't exist."

### 🛠️ Function Details

#### 1. 🔨 constructor()
- **Description:** This is the contract's constructor, which sets the contract deployer as the owner.
  
```solidity
constructor() {
    owner = msg.sender;
}
```

- **Purpose:** Initializes the contract by setting the owner as the address that deployed the contract.
- **Access Control:** Only runs once during deployment.

#### 2. ✅ authorizeTeacher(address teacher)
- **Description:** This function allows the owner to authorize a teacher who can then assign grades.

```solidity
function authorizeTeacher(address teacher) public onlyOwner {
    authorizedTeachers[teacher] = true;
}
```

- **Purpose:** Authorizes a teacher to assign grades to students.
- **Access Control:** Restricted to the contract owner using the onlyOwner modifier.

#### 3. 🚫 revokeTeacher(address teacher)
- **Description:** This function allows the owner to revoke a teacher’s authorization.

```solidity
function revokeTeacher(address teacher) public onlyOwner {
    authorizedTeachers[teacher] = false;
}
```

- **Purpose:** Removes a teacher’s ability to assign grades.
- **Access Control:** Restricted to the contract owner using the onlyOwner modifier.

#### 4. 📚 assignGrade(address student, string memory courseName, string memory grade)
- **Description:** Authorized teachers can use this function to assign a grade to a student.

```solidity
function assignGrade(address student, string memory courseName, string memory grade) public onlyTeacher {
    studentGrades[student].push(Grade(courseName, grade, true));
}
```

- **Purpose:** Allows an authorized teacher to assign a grade to a student.
- **Access Control:** Restricted to authorized teachers using the onlyTeacher modifier.
- **Tamper-Proof:** Once assigned, grades are stored immutably on the blockchain. They cannot be modified or deleted.

#### 5. 🔍 viewGradesDetailed(address student)
- **Description:** This function allows anyone to view a student's grades in detail.

```solidity
function viewGradesDetailed(address student) public view returns (string memory) {
    Grade[] memory grades = studentGrades[student];
    string memory result = "Grades for student:";

    bool hasGrades = false;

    for (uint i = 0; i < grades.length; i++) {
        if (grades[i].exists) {
            hasGrades = true;
            string memory course = grades[i].courseName;
            string memory grade = grades[i].grade;
            
            result = string(abi.encodePacked(result, " Course: ", course, ", Grade: ", grade, ";"));
        }
    }

    if (!hasGrades) {
        return "Student grade doesn't exist.";
    }

    return result;
}
```

- **Purpose:** Provides a detailed list of grades for a student, showing all valid grade entries.
- **Output:** Returns a string that lists all courses and corresponding grades for the specified student. If no grades are found, it returns "Student grade doesn't exist."

### 🔒 Modifiers

#### 1. 👑 onlyOwner
- **Description:** Restricts the execution of certain functions to the contract owner.

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Not authorized");
    _;
}
```

- **Usage:** Applied to functions that should only be executed by the contract owner, like authorizeTeacher and revokeTeacher.

#### 2. 🧑‍🏫 onlyTeacher
- **Description:** Restricts the execution of certain functions to authorized teachers.

```solidity
modifier onlyTeacher() {
    require(authorizedTeachers[msg.sender], "Not an authorized teacher");
    _;
}
```

- **Usage:** Applied to functions that should only be executed by authorized teachers, like assignGrade.
