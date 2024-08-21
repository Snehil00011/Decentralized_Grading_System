// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DecentralizedGradingSystem {

    address public owner;  // Contract owner (administrator)

    // Struct to represent a grade
    struct Grade {
        string courseName;
        string grade;
        bool exists;  // Flag to indicate if the grade entry is valid
    }

    // Mapping from student address to their grades
    mapping(address => Grade[]) public studentGrades;

    // Mapping for authorized teachers
    mapping(address => bool) public authorizedTeachers;

    // Modifier to restrict functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Modifier to restrict functions to authorized teachers
    modifier onlyTeacher() {
        require(authorizedTeachers[msg.sender], "Not an authorized teacher");
        _;
    }

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function to authorize a teacher (only owner can do this)
    function authorizeTeacher(address teacher) public onlyOwner {
        authorizedTeachers[teacher] = true;
    }

    // Function to revoke a teacher's authorization (only owner can do this)
    function revokeTeacher(address teacher) public onlyOwner {
        authorizedTeachers[teacher] = false;
    }

    // Function to assign a grade to a student (only authorized teachers can do this)
    function assignGrade(address student, string memory courseName, string memory grade) public onlyTeacher {
        studentGrades[student].push(Grade(courseName, grade, true));
    }

    // Function to view a student's grades with detailed info
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
}
