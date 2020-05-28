*** Settings ***
Library    RequestsLibrary    
Library    Collections    
Library    JSONLibrary    

*** Variables ***
${base_url}    http://thetestingworldapi.com/
${resource}    api/studentsDetails
&{body}    first_name=Mohit    middle_name=kumar    last_name=Raikwar    date_of_birth=07/03/1993



*** Test Cases ***
TC01_Generate student record using POST method
    [Tags]    Regression
    Create Session    post_st    ${base_url}
    &{header}=    Create Dictionary    Content-Type=application/json
    ${post_resp}=    Post Request    post_st    ${resource}    data=${body}    headers=${header}
    Log To Console    ${post_resp.content}
    ${status_cd}=    Convert To String    ${post_resp.status_code}
    Should Be Equal    ${status_cd}    201
    ${json_resp}=    To Json    ${post_resp.content} 
    ${id}=    Get Value From Json    ${json_resp}    id   
    Log To Console    ${id}[0]      