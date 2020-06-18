*** Settings ***
Documentation   This is a test suite to test signup functionality on the page.
Metadata        Version 1.0
Metadata        Author  Joanna Dmochowska

Library     SeleniumLibrary

Default Tags    smoke

Test Setup      Go to the sign up page
Test Teardown   Close All Browsers

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
Test 1 Sign up user with empty form
	Click Register Button
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}

Test 2 Sign up user with valid name and invalid surname, password, repasword, email
    Input Text   ${selector_input_name}     ${valid_name}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}


Test 3 Sign up user with valid surname and invalid name, password, repasword, email
    Input Text   ${selector_input_surname}    ${valid_surname}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}

Test 4 Sign up user with valid password and invalid surname, password, email
    Input Text     ${selector_input_password}    ${valid_password}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}

Test 5 Sign up user with valid repassword and invalid name, surname, password, email
    Input Text     ${selector_input_repassword}   ${valid_repassword}
    Click Register Button
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${email_invalid_lenght}

Test 6 Sign up user with valid email and invalid name, surname, password, repassword
    Input Text       ${selector_input_email}     ${valid_email}
    Click Register Button
    Page Should Contain    ${name_invalid_lenght}
    Page Should Contain    ${surname_invalid_lenght}
    Page Should Contain    ${pwd_invalid_lenght}
    Page Should Contain    ${repwd_invalid_lenght}

Test 7 Sign up user with invalid name
    [Template]     Registration with invalid name should fail
    123456
    1q2w3e4r5t6y
    !@@$#$^%

Test 8 Sign up user with invalid surname
    [Template]     Registration with invalid surname should fail
    123456
    1q2w3e4r5t6y
    !@@$#$^%

Test 9 Sign up user with invalid password and repassword
    [Template]     Registration with invalid password should fail
    ${EMPTY}                ${valid_repassword}
    ${valid_password}       ${EMPTY}
    12345                   ${valid_repassword}
    ${valid_password}       1234

Test 10 Sign up user with invalid email
    [Template]     Registration with invalid email should fail
    {EMPTY}
    @
    1q@
    @.pl
    @bleble.com

*** Keywords ***
Go to the sign up page
	Open Browser and go to Main Page
	Acept Cookies Policy
	Go to Registration Page

Open Browser and go to Main Page
    Open Browser   about:blank   ${browser}
    Go to    ${url_douglas}

Acept Cookies Policy
    Wait Until Element Is Visible   ${selector_cookies_btn}
    Click Button   ${selector_cookies_btn}

Go to Registration Page
    Wait Until Element Is Visible   ${selector_registration_btn}
    Click Element  ${selector_registration_btn}

Click Register Button
    Click Button      ${selector_submit_btn}

Registration with invalid name should fail
    Go to the sign up page
    [Arguments]    ${bad_name}
    Input Text   ${selector_input_name}        ${bad_name}
    Input Text   ${selector_input_surname}     ${valid_surname}
    Input Text   ${selector_input_password}    ${valid_password}
    Input Text   ${selector_input_repassword}  ${valid_repassword}
    Input Text   ${selector_input_email}       ${valid_email}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain   ${name_invalid_format}


Registration with invalid surname should fail
    Go to the sign up page
    [Arguments]    ${bad_surname}
    Input Text   ${selector_input_name}        ${valid_name}
    Input Text   ${selector_input_surname}     ${bad_surname}
    Input Text   ${selector_input_password}    ${valid_password}
    Input Text   ${selector_input_repassword}  ${valid_repassword}
    Input Text   ${selector_input_email}       ${valid_email}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    Page Should Contain   ${surname_invalid_format}

Registration with invalid password should fail
    Go to the sign up page
    [Arguments]    ${bad_password}   ${bad_repassword}
    Input Text   ${selector_input_name}        ${valid_name}
    Input Text   ${selector_input_surname}     ${valid_surname}
    Input Text   ${selector_input_password}    ${bad_password}
    Input Text   ${selector_input_repassword}  ${bad_repassword}
    Input Text   ${selector_input_email}       ${valid_email}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    ${error_msg}    Get Text    ${selector_error_div}
    log to console  ${error_msg}
    Should Contain Any   ${error_msg}   ${pwd_invalid_lenght}   ${repwd_invalid_lenght}   ${repwd_dont_match}

Registration with invalid email should fail
    Go to the sign up page
    [Arguments]    ${bad_email}
    Input Text   ${selector_input_name}        ${valid_name}
    Input Text   ${selector_input_surname}     ${valid_surname}
    Input Text   ${selector_input_password}    ${valid_password}
    Input Text   ${selector_input_repassword}  ${valid_repassword}
    Input Text   ${selector_input_email}       ${bad_email}
    Click Register Button
    Wait Until Element Is Visible     ${selector_error_div}
    ${error_msg}    Get Text    ${selector_error_div}
    log to console  ${error_msg}
    Should Contain Any   ${error_msg}   ${email_invalid_lenght}   ${email_invalid_format}