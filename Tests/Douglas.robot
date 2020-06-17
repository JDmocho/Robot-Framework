*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${browser}          Firefox
${url_douglas}      https://www.douglas.pl/

${selector_cookies_btn}        //*[@id="uc-btn-accept-banner"]
${selector_registration_btn}   css:.rd__nav-mydouglas__icon
${selector_submit_btn}         css:button.rd__button:nth-child(9)
${selector_error_div}          css:.rd__form-field--error

${selector_input_name}        name:my-douglas-register-prename
${selector_input_surname}     name:my-douglas-register-lastname
${selector_input_password}    name:my-douglas-register-password
${selector_input_repassword}  name:my-douglas-register-password-repeat
${selector_input_email}       name:my-douglas-register-email

${valid_name}   Krystyna
${valid_surname}   Kowalska
${valid_password}   Tester2020
${valid_repassword}   Tester2020
${valid_email}    krystyna@gmail.com


${name_invalid_lenght}         Imię: To pole nie może pozostać puste.
${surname_invalid_lenght}	   Nazwisko: To pole nie może pozostać puste.
${pwd_invalid_lenght}	 	   Wprowadzone hasło jest nieprawidłowe lub ma niepoprawny format.
${repwd_invalid_lenght}	 	   Powtórz hasło: To pole nie może pozostać puste.
${email_invalid_lenght}		   Adres e-mail: To pole nie może pozostać puste.
${repwd_dont_match}            Wprowadzone hasła różnią się.
${name_invalid_format}         Imię: Niepoprawny format
${surname_invalid_format}      Nazwisko: Niepoprawny format
${email_invalid_format}        Adres e-mail: Niepoprawny format



*** Test Case ***
Test 1 Empty form should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    Register button
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}
    Close All Browsers

Test 2 Filed only name should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    Input Text   ${selector_input_name}     ${valid_name}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}
    Close All Browsers

Test 3 Filed only surname should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    Input Text   ${selector_input_surname}    ${valid_surname}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}
    Close All Browsers

Test 4 Filed only password should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    Input Text     ${selector_input_password}    ${valid_password}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}
    Close All Browsers

Test 5 Filed only repeat password should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    Input Text     ${selector_input_repassword}   ${valid_repassword}
    Register button
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}
    Close All Browsers

Test 6 Filed only email should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    Input Text       ${selector_input_email}     ${valid_email}
    Register button
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Close All Browsers

Test 7 Data-driven invalid name
    [Template]     Registration with invalid name should fail
    123456
    1q2w3e4r5t6y
    !@@$#$^%

Test 8 Data-driven invalid surname
    [Template]     Registration with invalid surname should fail
    123456
    1q2w3e4r5t6y
    !@@$#$^%

Test 9 Data-driven invalid password and repeat password
    [Template]     Registration with invalid password should fail
    ${EMPTY}                ${valid_repassword}
    ${valid_password}       ${EMPTY}
    12345                   ${valid_repassword}
    ${valid_password}       1234

Test 10 Data-driven invalid email
    [Template]     Registration with invalid email should fail
    {EMPTY}
    @
    1q@
    @.pl
    @bleble.com

*** Keywords ***

Open Browser and Main Page
    Open Browser   about:blank   ${browser}
    Go to    ${url_douglas}

Acept Cookies Policy
    Wait Until Element Is Visible   ${selector_cookies_btn}
    Click Button   ${selector_cookies_btn}

Go to Registration Page
    Wait Until Element Is Visible   ${selector_registration_btn}
    Click Element  ${selector_registration_btn}

Register button
    Click Button      ${selector_submit_btn}

Registration with invalid name should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    [Arguments]    ${bad_name}
    Input Text   ${selector_input_name}        ${bad_name}
    Input Text   ${selector_input_surname}     ${valid_surname}
    Input Text   ${selector_input_password}    ${valid_password}
    Input Text   ${selector_input_repassword}  ${valid_repassword}
    Input Text   ${selector_input_email}       ${valid_email}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain   ${name_invalid_format}
    Close All Browsers

Registration with invalid surname should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    [Arguments]    ${bad_surname}
    Input Text   ${selector_input_name}        ${valid_name}
    Input Text   ${selector_input_surname}     ${bad_surname}
    Input Text   ${selector_input_password}    ${valid_password}
    Input Text   ${selector_input_repassword}  ${valid_repassword}
    Input Text   ${selector_input_email}       ${valid_email}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain   ${surname_invalid_format}
    Close All Browsers

Registration with invalid password should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    [Arguments]    ${bad_password}   ${bad_repassword}
    Input Text   ${selector_input_name}        ${valid_name}
    Input Text   ${selector_input_surname}     ${valid_surname}
    Input Text   ${selector_input_password}    ${bad_password}
    Input Text   ${selector_input_repassword}  ${bad_repassword}
    Input Text   ${selector_input_email}       ${valid_email}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    ${error_msg}    Get Text    ${selector_error_div}
    log to console  ${error_msg}
    Should Contain Any   ${error_msg}   ${pwd_invalid_lenght}   ${repwd_invalid_lenght}   ${repwd_dont_match}
    Close All Browsers

Registration with invalid email should fail
    Open Browser and Main Page
    Acept Cookies Policy
    Go to Registration Page
    [Arguments]    ${bad_email}
    Input Text   ${selector_input_name}        ${valid_name}
    Input Text   ${selector_input_surname}     ${valid_surname}
    Input Text   ${selector_input_password}    ${valid_password}
    Input Text   ${selector_input_repassword}  ${valid_repassword}
    Input Text   ${selector_input_email}       ${bad_email}
    Register button
    Wait Until Element Is Visible     ${selector_error_div}
    ${error_msg}    Get Text    ${selector_error_div}
    log to console  ${error_msg}
    Should Contain Any   ${error_msg}   ${email_invalid_lenght}   ${email_invalid_format}
    Close All Browsers