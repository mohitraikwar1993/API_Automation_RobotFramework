*** Settings ***
Library    RequestsLibrary    
Library    JSONLibrary  
Library     Collections      


*** Variables ***
${base_url}    http://thetestingworldapi.com
${resource}    api/studentsDetails
&{header}   Content-Type=application/json

*** Keywords ***
create student using POST
    [Arguments]    ${body}    
    Create Session    E2E    ${base_url}    
    ${post_resp}=    Post Request    E2E    ${resource}    data=${body}    headers=${header}
    Log To Console    ${post_resp.content}   
    ${status_cd}=    Convert To String    ${post_resp.status_code}
    Should Be Equal    ${status_cd}    201     
    ${json_resp}=    To Json    ${post_resp.content}    
    @{id_list}=    Get Value From Json    ${json_resp}    id
    ${id}=    Get From List    ${id_list}    0
    Log To Console    ${id}
    [Return]    ${id}


get student info using GET
    [Arguments]    ${id}
    Create Session    stu_get    ${base_url}
    ${get_resp}=    Get Request    stu_get    ${resource}/${id}    
    [Return]    ${get_resp}
    

update student info using PUT
    [Arguments]    ${id}    ${put_body}
    Create Session    stu_put    ${base_url}
    ${put_resp}=    Put Request    stu_put  ${resource}/${id}    data=${put_body}    headers=${header}
    ${json_resp}=    To Json    ${put_resp.content}    
    ${status}=    Get Value From Json    ${json_resp}    status
    Should Be Equal    ${status}[0]    true
    Log To Console    put_status_${status}[0]    
    [Return]    ${put_resp}
    

delete student info using DELETE
    [Arguments]    ${id}
    Create Session    stu_del    ${base_url}    
    ${del_resp}=    Delete Request    stu_del    ${resource}/${id}        
    ${json_resp}=    To Json    ${del_resp.content}    
    ${status}=    Get Value From Json    ${json_resp}    status
    Should Be Equal    ${status}[0]    true  
    [Return]    ${del_resp}  

