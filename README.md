# Decentralized Grading System

## Overview

The **Decentralized Grading System** is a smart contract built on the Ethereum blockchain that allows for the decentralized management of student grades. Designed to be secure and transparent, this system ensures that grades are recorded immutably and can only be modified by authorized teachers.

## Features

- **Decentralized Management**: Grades are stored on the blockchain, providing a secure and transparent way to track academic records.
- **Authorized Teachers**: Only approved teachers can assign grades, ensuring that only valid entries are recorded.
- **Detailed Grade Viewing**: Students and other authorized parties can view detailed information about grades, including course names and grades.
- **Flexible Administration**: Contract owner can authorize or revoke teachers' permissions, maintaining control over who can interact with the grading system.

## Architecture

### Contract Structure

- **Owner**: The contract administrator with the authority to manage teacher permissions.
- **Grade Struct**: Represents a grade with the course name, grade, and a flag to indicate validity.
- **Mappings**:
  - `studentGrades`: Maps student addresses to their list of grades.
  - `authorizedTeachers`: Maps teacher addresses to their authorization status.

### Key Functions

- **authorizeTeacher(address teacher)**: Authorizes a teacher to assign grades. Only the contract owner can call this function.
- **revokeTeacher(address teacher)**: Revokes a teacher's authorization. Only the contract owner can call this function.
- **assignGrade(address student, string memory courseName, string memory grade)**: Allows an authorized teacher to assign a grade to a student.
- **viewGradesDetailed(address student)**: Returns a detailed string of grades for a given student. If no grades are found, it returns "Student grade doesn't exist."
