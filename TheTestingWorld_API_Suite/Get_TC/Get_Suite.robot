*** Settings ***
Library    RequestsLibrary    
Library    SeleniumLibrary 
Library    JSONLibrary
Library    Collections    

*** Variables ***
${base_url}    http://thetestingworldapi.com/
${resource_all}    api/studentsDetails
${studentId}    186733


*** Test Cases ***
TC01_Verify get Student data method
    [Tags]    Smoke Regression
    Create Session    GET_STUDENT_DETAILS    ${base_url}
    ${response1}=    Get Request    GET_STUDENT_DETAILS        ${resource_all}
    Log To Console   ${response1.status_code}
    Log To Console   ${response1}  
    Log To Console   ${response1.content} 
        
 

TC02_Verify a student details
    [Tags]    Regression
    [Documentation]    get a student detail and validate
    Create Session    student_details    ${base_url}
    ${response2}=    Get Request    student_details    ${resource_all}/${studentId} 
    Log To Console    ${response2.status_code}
    Log To Console    ${response2.content} 
    ${status_cd}=    Convert To String    ${response2.status_code}
    Should Be Equal    ${status_cd}    200
    ${json_response}=    To Json    ${response2.content} 
    @{fname_list}=    Get Value From Json    ${json_response}    data.first_name
    Log To Console    ${fname_list}[0]
    ${fn}=    Set Variable    ${fname_list}[0]
    Log To Console    ${fn}    
    ${fname}=    Get From List    ${fname_list}    0
    Should Be Equal As Strings   ${fname_list}[0]     p2    
           
         
    

    