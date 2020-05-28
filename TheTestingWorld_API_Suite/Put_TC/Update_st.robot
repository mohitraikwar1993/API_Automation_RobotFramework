*** Settings ***
Library    RequestsLibrary    
Library    Collections    
Library    JSONLibrary    

*** Variables ***
${base_url}    http://thetestingworldapi.com
${resource}    api/studentsDetails
&{body}    id=186733    first_name=Mohit1234    middle_name=kumar    last_name=Raikwar    date_of_birth=07/03/1993

*** Test Cases ***
TC01_Upadate existing student details using PUT method
    [Tags]    Smoke    Regression
    Create Session    put_st    ${base_url}
    &{header}=    Create Dictionary    Content-Type=application/json
    ${put_resp}=    Put Request    put_st    ${resource}/186733    data=${body}    headers=${header}
    Log To Console    ${put_resp.content}    
    Log To Console    ${put_resp.status_code}
    ${json_resp}=    To Json    ${put_resp.content}    
    ${status}=    Get Value From Json    ${json_resp}    status
    
    Should Be Equal    ${status}[0]    true    