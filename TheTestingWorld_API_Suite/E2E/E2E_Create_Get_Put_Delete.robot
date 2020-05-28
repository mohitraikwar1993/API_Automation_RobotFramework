*** Settings ***
Library    Collections    
Library    JSONLibrary    
Library    RequestsLibrary  
Force Tags    E2E  

*** Variables ***
${base_url}    http://thetestingworldapi.com
${resource}    api/studentsDetails
&{body}    first_name=Mohit    middle_name=kumar    last_name=Raikwar    date_of_birth=07/03/1993
&{header}   Content-Type=application/json



*** Test Cases ***
TC01_Create student and perform get update and delete operations
#Create Student
    Create Session    E2E    ${base_url} 
    ${post_resp}=    Post Request    E2E    ${resource}    data=${body}    headers=${header}
    Log To Console    ${post_resp.content}   
    ${status_cd}=    Convert To String    ${post_resp.status_code}
    Should Be Equal    ${status_cd}    201     
    ${json_resp}=    To Json    ${post_resp.content}    
    @{id_list}=    Get Value From Json    ${json_resp}    id
    ${id}=    Get From List    ${id_list}    0
    Log To Console    ${id}


# Get Student
    ${get_resp}=    Get Request    E2E    ${resource}/${id}
    Log To Console    ${get_resp.content}
    ${status_cd}=    Convert To String    ${get_resp.status_code}
    Should Be Equal    ${status_cd}    200
    
# update middle name
    &{body_put}=    Create Dictionary    id=${id}    first_name=Mohit    middle_name=123    last_name=Raikwar    date_of_birth=07/03/1993
    ${put_resp}=    Put Request    E2E    ${resource}/${id}    data=${body_put}    headers=${header}
    Log To Console    ${put_resp.content}    
    ${status_cd}=    Convert To String    ${put_resp.status_code}
    Should Be Equal    ${status_cd}    200
    ${json_resp}=    To Json    ${put_resp.content}    
    ${status}=    Get Value From Json    ${json_resp}    status
    Should Be Equal    ${status}[0]    true

#delete student details
    ${del_resp}=    Delete Request    E2E    ${resource}/${id}
    Log To Console    ${del_resp.content} 
    ${status_cd}=    Convert To String    ${del_resp.status_code}       
    Should Be Equal    ${status_cd}    200    
    ${json_resp}=    To Json    ${del_resp.content} 
    ${status}=    Get Value From Json    ${json_resp}    status 
    Should Be Equal    ${status}[0]    true
