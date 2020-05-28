*** Settings ***
Library    JSONLibrary    
Library    Collections    
Library    RequestsLibrary    

*** Variables ***
${base_url}    https://reqres.in
${resource}    api/users?page=2

*** Test Cases ***
TC01_Test Get with parameters
    [Tags]    Smoke
    Create Session    session1    ${base_url}    
    ${response1}=    Get Request    session1    ${resource}
    ${status_cd}=    Convert To String    ${response1.status_code}
    Should Be Equal    ${status_cd}    200
    Log To Console    ${response1.content}  
    ${json_req}=    To Json    ${response1.content}    
    @{email_list}=    Get Value From Json    ${json_req}    data[1].email  
    Log To Console    value_from_list_${email_list}[0]    
    ${email}=    Get From List    ${email_list}    0        
    Log To Console    ${email}
       