*** Settings ***
Library    Collections    
Library    JSONLibrary    
Library    RequestsLibrary   
Resource    ../../Resources/Student_Resources.robot
Force Tags    E2E


*** Variables ***
${base_url}    http://thetestingworldapi.com
${resource}    api/studentsDetails
&{body}    first_name=Mohit    middle_name=kumar    last_name=Raikwar123    date_of_birth=07/03/1993

*** Test Cases ***
TC01_Create, Get, Update and Delete student record using user defined keywords
#Create Student 
    ${id}=    create student using POST    ${body}
    Log To Console    ${id}    
    
#Get Student 
    ${get_resp}=    get student info using GET    ${id}
    Log To Console    ${get_resp.content}    
    ${json_resp}=    To Json    ${get_resp.content}    
    ${status}=    Get Value From Json    ${json_resp}    status
    Should Be Equal    ${status}[0]    true

#Update Student details
    ${body_put}=    Create Dictionary    id=${id}    first_name=Mohit1234    middle_name=kumar    last_name=Raikwar    date_of_birth=07/03/1993
    ${resp}=    update student info using PUT    ${id}    ${body_put}    
    Log To Console    ${resp.content}    
    
#Delete student record
    ${resp}=    delete student info using DELETE    ${id}    
    Log To Console    ${resp.content}    
