*** Settings ***
Library    JSONLibrary    
Library    Collections    
Library    RequestsLibrary 
Library    ../../Python_Utilities/Read_Json_File.py       

*** Variables ***
${base_url}    http://thetestingworldapi.com
${resource}    api/studentsDetails
&{header}   Content-Type=application/json
&{body}    first_name=Mohit    middle_name=kumar    last_name=Raikwar    date_of_birth=07/03/1993
${filepath}    C:/Users/Beauty/eclipse-workspace/API_Testing_Robot_FW/Payload/Student.json

*** Test Cases ***
TC01_Create student using complex json file
    [Tags]    Smoke    Regression
    [Documentation]    This scripts will create new student by using complex payload present in json file using python read_json user defined method
    Create Session    stu_post    ${base_url}
    ${body_from_Json}=    read_Json    ${filepath}
    ${post_resp}=    Post Request    stu_post    ${resource}    data=${body_from_Json}    headers=${header}
    Log To Console    ${post_resp.content}   
    ${json_resp}=    To Json    ${post_resp.content}    
    @{id_list}=    Get Value From Json    ${json_resp}    id
    ${id}=    Get From List    ${id_list}    0
    Log To Console    id_of_new_student_is_:${id}   
    

