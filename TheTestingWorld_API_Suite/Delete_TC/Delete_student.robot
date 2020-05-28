*** Settings ***
Library    JSONLibrary    
Library    Collections    
Library    RequestsLibrary    
   


*** Variables ***
${base_url}    http://thetestingworldapi.com/
${studentID}    1091
${resource}    api/studentsDetails/
&{body}    first_name=Mohit    middle_name=kumar    last_name=Raikwar    date_of_birth=07/03/1993
&{header}   Content-Type=application/json

*** Test Cases ***
TC01_Delete student details with id
    [Tags]    Regression
    Create Session    delete_student    ${base_url}    
    ${response1}=    Delete Request    delete_student    ${resource}${studentID}   
    Log To Console    ${response1.status_code}    
    Log To Console    ${response1.content}    
    ${json_resp}=    To Json    ${response1.content} 
    ${status}=    Get Value From Json    ${json_resp}    status
    Should Be Equal    ${status}[0]   true
    ${status_cd}=      Convert To String    ${response1.status_code}
    Should Be Equal    ${status_cd}    200    


TC02_Create student and then delete student
    [Tags]    Smoke
    Create Session    delete_student    ${base_url}    
    ${post_resp}=    Post Request    delete_student    ${resource}    data=${body}    headers=${header}
    ${json_resp}=    To Json    ${post_resp.content}
    ${id}=    Get Value From Json    ${json_resp}    id
    
    ${response1}=    Delete Request    delete_student    ${resource}${id}[0]   
    Log To Console    ${response1.status_code}    
    Log To Console    ${response1.content}    
    ${json_resp}=    To Json    ${response1.content} 
    ${status}=    Get Value From Json    ${json_resp}    status
    Should Be Equal    ${status}[0]   true
    ${status_cd}=      Convert To String    ${response1.status_code}
    Should Be Equal    ${status_cd}    200 